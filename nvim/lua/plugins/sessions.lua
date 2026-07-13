return {
    "rmagatti/auto-session",
    config = function()
        require("auto-session").setup({
            auto_restore = true,
            auto_save = true,
            auto_create = true,
            suppressed_dirs = { "~/", "/" },
            session_lens = {
                load_on_setup = false,
            },
        })
    end,
}
