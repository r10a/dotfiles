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

-- Command-line completion: <Tab> shows matches in a popup menu
opt.wildmode = "longest:full,full"
opt.wildoptions = "pum"

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

-- Enter visual mode from insert mode (overrides insert-literal <C-v>)
vim.keymap.set("i", "<C-v>", "<Esc>v", { silent = true, desc = "Insert → visual mode" })

-- Clear search highlight
vim.keymap.set("n", "<Esc><Esc>", ":noh<CR>", { silent = true, desc = "Clear search highlight" })

-- Buffers
vim.keymap.set("n", "<leader>]", ":bnext<CR>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<leader>[", ":bprevious<CR>", { silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "<leader>q", ":bdelete<CR>", { silent = true, desc = "Close buffer" })

-- Split management
vim.keymap.set("n", "<leader>h", ":split<CR>", { silent = true, desc = "Horizontal split" })
vim.keymap.set("n", "<leader>v", ":vsplit<CR>", { silent = true, desc = "Vertical split" })
vim.keymap.set("n", "<leader><Left>", "<C-w>h", { silent = true, desc = "Move to left split" })
vim.keymap.set("n", "<leader><Down>", "<C-w>j", { silent = true, desc = "Move to below split" })
vim.keymap.set("n", "<leader><Up>", "<C-w>k", { silent = true, desc = "Move to above split" })
vim.keymap.set("n", "<leader><Right>", "<C-w>l", { silent = true, desc = "Move to right split" })

vim.keymap.set("n", "<leader>tq", ":tabclose<CR>", { silent = true, desc = "Close tab" })

vim.keymap.set("n", "<leader>Q", ":qa<CR>", { silent = true, desc = "Quit all" })

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

-- Reload config
vim.keymap.set("n", "<leader>r", function()
    vim.cmd("source $MYVIMRC")
    vim.notify("Config reloaded")
end, { silent = true, desc = "Reload config" })

-- Rust LSP (native client, 0.11+). rust-analyzer via rustup proxy (not on PATH).
vim.lsp.config("rust_analyzer", {
    cmd = { "rustup", "run", "stable", "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "Cargo.toml", "rust-project.json", ".git" },
})
vim.lsp.enable("rust_analyzer")

-- gd to jump; grr/gra/grn/K are native LSP defaults
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition,
            { buffer = ev.buf, desc = "LSP go to definition" })
    end,
})

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
