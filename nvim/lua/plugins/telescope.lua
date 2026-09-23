return {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        telescope.setup({
            defaults = {
                mappings = {
                    i = { ["<C-f>"] = actions.to_fuzzy_refine },
                    n = { ["<C-f>"] = actions.to_fuzzy_refine },
                },
            },
        })
        telescope.load_extension("fzf")

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find files" })
        vim.keymap.set("n", "<leader>g", function()
            builtin.live_grep({ glob_pattern = { "!node_modules/**", "!.git/**" } })
        end, { desc = "Live grep" })
        vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Find buffers" })
        vim.keymap.set("n", "<leader>?", builtin.keymaps, { desc = "Search keybinds" })
    end,
}
