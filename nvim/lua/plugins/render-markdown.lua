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
