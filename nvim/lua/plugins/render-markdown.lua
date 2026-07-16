return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    ft = { "markdown" },
    config = function()
        -- Kanagawa doesn't theme the RenderMarkdown* groups (they fall back to
        -- diff colors — H1→DiffText, H2→DiffAdd, code→ColorColumn — which clash),
        -- so map them to the Kanagawa (wave) palette. https://github.com/rebelot/kanagawa.nvim
        local d = {
            bg = "#1f1f28", -- sumiInk1
            currentline = "#2a2a37", -- sumiInk3, subtle block background
            fg = "#dcd7ba", -- fujiWhite
            comment = "#727169", -- fujiGray
            cyan = "#7aa89f", -- waveAqua2
            green = "#98bb6c", -- springGreen
            orange = "#ffa066", -- surimiOrange
            pink = "#d27e99", -- sakuraPink
            purple = "#957fb8", -- oniViolet
            red = "#ff5d62", -- peachRed
            yellow = "#e6c384", -- carpYellow
        }
        local function set_md_hl()
            local hl = vim.api.nvim_set_hl
            -- Heading foreground: colored + bold, cycling through the palette.
            hl(0, "RenderMarkdownH1", { fg = d.purple, bold = true })
            hl(0, "RenderMarkdownH2", { fg = d.cyan, bold = true })
            hl(0, "RenderMarkdownH3", { fg = d.pink, bold = true })
            hl(0, "RenderMarkdownH4", { fg = d.green, bold = true })
            hl(0, "RenderMarkdownH5", { fg = d.orange, bold = true })
            hl(0, "RenderMarkdownH6", { fg = d.yellow, bold = true })
            -- Heading background blocks: a subtle current-line tint, level-colored fg.
            hl(0, "RenderMarkdownH1Bg", { fg = d.purple, bg = d.currentline })
            hl(0, "RenderMarkdownH2Bg", { fg = d.cyan, bg = d.currentline })
            hl(0, "RenderMarkdownH3Bg", { fg = d.pink, bg = d.currentline })
            hl(0, "RenderMarkdownH4Bg", { fg = d.green, bg = d.currentline })
            hl(0, "RenderMarkdownH5Bg", { fg = d.orange, bg = d.currentline })
            hl(0, "RenderMarkdownH6Bg", { fg = d.yellow, bg = d.currentline })
            -- Code block background: faint current-line off the base.
            hl(0, "RenderMarkdownCode", { bg = d.currentline })
            -- Bullets, checkboxes, links: palette accents.
            hl(0, "RenderMarkdownBullet", { fg = d.orange })
            hl(0, "RenderMarkdownLink", { fg = d.cyan, underline = true })
        end
        set_md_hl()
        -- Re-apply after any colorscheme change so our overrides stick.
        vim.api.nvim_create_autocmd("ColorScheme", { callback = set_md_hl })

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
