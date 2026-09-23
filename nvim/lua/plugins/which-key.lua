-- Popup that shows follow-up keys as you type a prefix. Reads the `desc` on
-- every existing mapping; the spec below only labels the leader groups.
return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        spec = {
            { "<leader>t", group = "tab" },
        },
    },
}
