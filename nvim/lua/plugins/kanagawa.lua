-- Kanagawa colorscheme for the whole editor.
return {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    priority = 1000, -- load before other plugins so highlights are available
    config = function()
        require("kanagawa").setup({})
        vim.cmd.colorscheme("kanagawa-wave")
    end,
}
