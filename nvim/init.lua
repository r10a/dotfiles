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
opt.wrap = false

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
