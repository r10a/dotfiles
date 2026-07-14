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
            -- Tables are rendered by markdown-pipetable.nvim instead (interactive
            -- fit-to-width editing). TODO: re-enable once render-markdown supports
            -- table cell-wrapping (issue #616 / PR #617).
            pipe_table = { enabled = false },
            -- pipetable manages the cursor line while editing cells.
            win_options = { concealcursor = { rendered = "nvic" } },
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
