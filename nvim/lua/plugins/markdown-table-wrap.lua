-- Disabled fallback: word-wraps wide table cells but has no row-level editing,
-- so editing means scrolling the whole rendered block. Superseded by
-- markdown-pipetable.nvim (fit-to-width + cell-by-cell editing). Re-enable this
-- (and disable pipetable) if you'd rather have wrapping than in-place editing.
-- Tracking upstream fix: https://github.com/MeanderingProgrammer/render-markdown.nvim/issues/616
return {
    "ice345/markdown-table-wrap.nvim",
    enabled = false,
    ft = "markdown",
    opts = {
        highlight_preset = "render_markdown", -- match render-markdown.nvim colors
        auto_preview_in_insert = true, -- keep tables rendered while editing
        -- Render the table as virtual lines *above* the source (which stays
        -- visible but dimmed) instead of overlaying it, so you edit the real
        -- pipe-table text and cursor position matches the cell you're editing.
        inline_mode = "insert",
    },
}
