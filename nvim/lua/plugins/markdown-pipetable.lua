-- Interactive, fit-to-width markdown tables with cell-by-cell modal editing.
-- Wide columns are truncated (…/› markers) with horizontal scroll rather than
-- wrapped, so editing a cell never requires scrolling the whole table.
-- Requires render-markdown's own table renderer disabled — see
-- lua/plugins/render-markdown.lua (pipe_table.enabled = false).
return {
    "dominic-righthere/markdown-pipetable.nvim",
    ft = "markdown",
    config = function()
        require("pipetable").setup({
            -- Don't grab modal table mode on cursor move: tables still render,
            -- but normal Vim mode is preserved so CopyReference's visual <CR>
            -- (add-to-review) keeps working on tables. Edit a table on demand
            -- with <leader>te or :Pipetable.
            auto_enter = false,
            column = {
                max_width = 80, -- widen columns (default 40); raise for wider tables
            },
            keys = {
                enter = "<leader>te", -- manually enter interactive table mode
            },
        })
    end,
}
