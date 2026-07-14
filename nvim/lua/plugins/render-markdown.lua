return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    ft = { "markdown" },
    config = function()
        require("render-markdown").setup({
            render_modes = true,
            -- Tables are rendered by markdown-table-wrap.nvim, which word-wraps
            -- wide cells (render-markdown can't wrap tables yet). TODO: re-enable
            -- once render-markdown supports table cell-wrapping (issue #616 / PR #617).
            pipe_table = { enabled = false },
            anti_conceal = {
                enabled = true,
                disabled_modes = false,
                above = 0,
                below = 0,
                ignore = {
                    code_background = true,
                    indent = true,
                    sign = true,
                    virtual_lines = true,
                },
            },
        })
    end,
}
