vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- Line numbers (hybrid: absolute on current line, relative on others)
opt.number = true
opt.relativenumber = true

-- Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Clipboard
opt.clipboard = "unnamedplus"

-- Mouse
opt.mouse = "a"

-- Undo persistence
opt.undofile = true

-- UI
opt.cursorline = true
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.termguicolors = true

-- Misc sensible defaults
opt.splitbelow = true
opt.splitright = true
opt.updatetime = 250
opt.timeoutlen = 300
opt.wrap = true
opt.linebreak = true -- wrap at word boundaries, not mid-word

-- Move by visual line when wrapped (bare j/k/arrows); counts like 5j stay linewise
for _, key in ipairs({ "j", "<Down>" }) do
    vim.keymap.set({ "n", "v" }, key, "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
end
for _, key in ipairs({ "k", "<Up>" }) do
    vim.keymap.set({ "n", "v" }, key, "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
end

-- Split management
vim.keymap.set("n", "<leader>h", ":split<CR>", { silent = true, desc = "Horizontal split" })
vim.keymap.set("n", "<leader>v", ":vsplit<CR>", { silent = true, desc = "Vertical split" })
vim.keymap.set("n", "<leader><Left>", "<C-w>h", { silent = true, desc = "Move to left split" })
vim.keymap.set("n", "<leader><Down>", "<C-w>j", { silent = true, desc = "Move to below split" })
vim.keymap.set("n", "<leader><Up>", "<C-w>k", { silent = true, desc = "Move to above split" })
vim.keymap.set("n", "<leader><Right>", "<C-w>l", { silent = true, desc = "Move to right split" })

vim.keymap.set("n", "<leader>Q", ":qa<CR>", { silent = true, desc = "Quit all" })
vim.keymap.set("n", "<leader>n", ":tabnew<CR>", { silent = true, desc = "New workspace" })
vim.keymap.set("n", "<leader>w", ":tabclose<CR>", { silent = true, desc = "Close workspace" })

-- Scratchpad
vim.keymap.set("n", "<leader>s", function()
    local scratch = vim.fn.stdpath("data") .. "/scratch.md"
    vim.cmd("edit " .. scratch)
end, { silent = true, desc = "Open scratchpad" })
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
    pattern = vim.fn.stdpath("data") .. "/scratch.md",
    callback = function()
        vim.cmd("silent! write")
    end,
})

-- Yank with file:line reference, formatted for pasting to LLMs
local function yank_with_ref(line1, line2)
    if line1 > line2 then
        line1, line2 = line2, line1 -- normalize upward selections
    end
    local path = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.") -- relative to cwd
    if path == "" then
        path = "[No Name]"
    end
    local ref = line1 == line2 and (path .. ":" .. line1)
        or (path .. ":" .. line1 .. "-" .. line2)
    local lines = vim.api.nvim_buf_get_lines(0, line1 - 1, line2, false)
    local ft = vim.bo.filetype
    local block = table.concat({
        ref,
        "```" .. ft,
        table.concat(lines, "\n"),
        "```",
    }, "\n")
    vim.fn.setreg("+", block)
    vim.notify("Copied " .. ref)
end
vim.keymap.set("n", "<leader>yr", function()
    local l = vim.fn.line(".")
    yank_with_ref(l, l)
end, { silent = true, desc = "Yank line with file:line ref (for LLMs)" })
vim.keymap.set("x", "<leader>yr", function()
    yank_with_ref(vim.fn.line("v"), vim.fn.line("."))
end, { silent = true, desc = "Yank selection with file:line ref (for LLMs)" })

-- Reload config
vim.keymap.set("n", "<leader>r", function()
    vim.cmd("source $MYVIMRC")
    vim.notify("Config reloaded")
end, { silent = true, desc = "Reload config" })

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
