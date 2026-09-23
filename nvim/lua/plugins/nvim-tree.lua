return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        require("nvim-tree").setup({
            update_focused_file = { enable = true },
            -- The built-in hijack replaces the window with a full-screen tree and
            -- no editor buffer; the VimEnter handler below docks it as a sidebar.
            hijack_directories = { enable = false },
            view = {
                side = "right",
                -- Table form = dynamic width tracking the longest visible line;
                -- max = -1 is unbounded, so names are never clipped.
                width = { min = 30, max = -1, padding = 2 },
            },
        })

        vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file tree", silent = true })

        -- `nvim <dir>`: swap the directory buffer for an empty one, dock the tree,
        -- and leave the cursor in the editor. Scheduled so it lands after
        -- auto-session's restore, which also runs on VimEnter.
        vim.api.nvim_create_autocmd("VimEnter", {
            callback = function(data)
                if vim.fn.isdirectory(data.file) ~= 1 then
                    return
                end
                vim.schedule(function()
                    if vim.api.nvim_get_current_buf() == data.buf then
                        vim.cmd.enew()
                        pcall(vim.api.nvim_buf_delete, data.buf, { force = true })
                    end
                    require("nvim-tree.api").tree.open()
                    vim.cmd("wincmd p")
                end)
            end,
        })
    end,
}
