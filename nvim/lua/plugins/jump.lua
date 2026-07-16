-- nvim-jump: label-based on-screen motion. Press `s` then type a match to jump.
return {
    "yorickpeterse/nvim-jump",
    keys = {
        {
            "s",
            function()
                require("jump").start()
            end,
            mode = { "n", "x", "o" },
            desc = "Jump to a location on screen",
        },
    },
    config = function()
        require("jump").setup({})
    end,
}
