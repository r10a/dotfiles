return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        require("nvim-tree").setup({
            view = {
                float = {
                    enable = true,
                    open_win_config = {
                        relative = "editor",
                        width = 60,
                        height = 30,
                        row = 4,
                        col = 10,
                        border = "rounded",
                    },
                },
            },
            actions = {
                open_file = {
                    quit_on_open = true,
                },
            },
        })

        vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file tree", silent = true })
    end,
}
