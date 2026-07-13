return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "tiagovla/scope.nvim",
    },
    config = function()
        require("scope").setup()

        require("bufferline").setup({
            options = {
                numbers = "ordinal",
                close_command = "bdelete! %d",
                diagnostics = false,
                show_buffer_close_icons = true,
                show_close_icon = false,
                separator_style = "thin",
                always_show_bufferline = true,
            },
            highlights = {
                buffer_selected = {
                    bold = true,
                    italic = false,
                },
            },
        })

        vim.keymap.set("n", "<leader>]", ":BufferLineCycleNext<CR>", { silent = true, desc = "Next buffer" })
        vim.keymap.set("n", "<leader>[", ":BufferLineCyclePrev<CR>", { silent = true, desc = "Previous buffer" })
        for i = 1, 9 do
            vim.keymap.set("n", "<leader>" .. i, function()
                local buffers = require("bufferline").get_elements().elements
                local target = buffers[i]
                if not target then return end
                local target_bufnr = target.id
                local tabpage = vim.api.nvim_get_current_tabpage()
                for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tabpage)) do
                    if vim.api.nvim_win_get_buf(win) == target_bufnr then
                        vim.api.nvim_set_current_win(win)
                        return
                    end
                end
                vim.cmd("buffer " .. target_bufnr)
            end, { silent = true, desc = "Go to buffer " .. i })
        end
        vim.keymap.set("n", "<leader>q", function()
            local buf = vim.api.nvim_get_current_buf()
            local buffers = require("bufferline").get_elements().elements
            if #buffers <= 1 then
                vim.cmd("enew")
            else
                vim.cmd("BufferLineCyclePrev")
            end
            vim.cmd("bdelete! " .. buf)
        end, { silent = true, desc = "Close buffer" })
    end,
}
