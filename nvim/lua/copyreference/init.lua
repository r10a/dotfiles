-- copyreference: yank a `path:line` reference (optionally with a fenced code
-- block) to a register, formatted for pasting to LLMs.

local M = {}

M.config = {
    register = "+", -- register to copy into (default: system clipboard)
    use_git_root = true, -- path relative to git root; falls back to cwd-relative
    include_code = true, -- append the code (fenced block / xml body)
    output_style = "markdown", -- "markdown" or "xml" (xml is parsed more reliably by Claude)
}

-- Resolve the current buffer's path for the reference.
local function ref_path()
    local abs = vim.fn.expand("%:p")
    if abs == "" then
        return "[No Name]"
    end
    if M.config.use_git_root then
        local root = vim.fn.systemlist({
            "git", "-C", vim.fn.expand("%:p:h"), "rev-parse", "--show-toplevel",
        })[1]
        if vim.v.shell_error == 0 and root and root ~= "" and abs:sub(1, #root + 1) == root .. "/" then
            return abs:sub(#root + 2)
        end
    end
    return vim.fn.fnamemodify(abs, ":.") -- cwd-relative fallback
end

-- Format the payload as markdown: a `path:line` header + fenced code block.
local function format_markdown(path, range, code)
    local ref = path .. ":" .. range
    if not code then
        return ref, ref
    end
    return table.concat({
        ref,
        "```" .. vim.bo.filetype,
        code,
        "```",
    }, "\n"), ref
end

-- Format the payload as XML, which Claude parses with less ambiguity.
local function format_xml(path, range, code)
    local ref = path .. ":" .. range
    local attrs = string.format('path="%s" lines="%s"', path, range)
    local ft = vim.bo.filetype
    if ft ~= "" then
        attrs = attrs .. string.format(' language="%s"', ft)
    end
    if not code then
        return string.format("<file %s />", attrs), ref
    end
    return string.format("<file %s>\n%s\n</file>", attrs, code), ref
end

-- Copy a reference for the given line range, using `lines` as the code text.
local function do_copy(line1, line2, lines)
    if line1 > line2 then
        line1, line2 = line2, line1 -- normalize upward selections
    end
    local path = ref_path()
    local range = line1 == line2 and tostring(line1)
        or (line1 .. "-" .. line2)
    local code = M.config.include_code and table.concat(lines, "\n") or nil

    local formatter = M.config.output_style == "xml" and format_xml or format_markdown
    local payload, ref = formatter(path, range, code)

    vim.fn.setreg(M.config.register, payload)
    vim.notify("Copied " .. ref)
end

-- Copy a reference for a full line range (whole lines).
function M.copy(line1, line2)
    if line1 > line2 then
        line1, line2 = line2, line1
    end
    do_copy(line1, line2, vim.api.nvim_buf_get_lines(0, line1 - 1, line2, false))
end

-- Copy the current line (normal mode).
function M.copy_line()
    local l = vim.fn.line(".")
    M.copy(l, l)
end

-- Copy the visual selection, honoring the exact region (charwise selections
-- copy only the highlighted text, not whole lines).
function M.copy_selection()
    local mode = vim.fn.mode()
    local p1, p2 = vim.fn.getpos("v"), vim.fn.getpos(".")
    local lines = vim.fn.getregion(p1, p2, { type = mode })
    do_copy(p1[2], p2[2], lines)
end

function M.setup(opts)
    M.config = vim.tbl_extend("force", M.config, opts or {})

    vim.api.nvim_create_user_command("CopyReference", function(args)
        if args.range > 0 then
            M.copy(args.line1, args.line2)
        else
            M.copy_line()
        end
    end, { range = true, desc = "Copy file:line reference (for LLMs)" })
end

return M
