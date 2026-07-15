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
            -- Table rendering left off: with global `wrap = true`, render-markdown's
            -- pipe tables break on wide rows (issue #616 / PR #617). Tables show as
            -- plain aligned markdown source, which is readable and doesn't misbehave.
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
