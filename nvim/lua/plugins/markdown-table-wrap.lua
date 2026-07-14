-- Word-wraps wide markdown table cells so tables render cleanly while global
-- `wrap` stays on for prose. Unlike an alignment renderer, this wraps cells
-- itself and (with inline_disable_wrap = false) never forces `wrap = false`, so
-- prose soft-wrapping and a rendered table coexist in the same file.
-- Requires render-markdown's own table renderer disabled — see
-- lua/plugins/render-markdown.lua (pipe_table.enabled = false).
return {
    "ice345/markdown-table-wrap.nvim",
    ft = "markdown",
    config = function()
        require("markdown-table-wrap").setup({
            highlight_preset = "render_markdown", -- match render-markdown.nvim colors
            inline_disable_wrap = false, -- keep our global `wrap` so prose still wraps
        })

        -- The plugin clears the table in visual mode, but leaving insert (e.g.
        -- <C-v> = <Esc>v) fires InsertLeave, which schedules a *debounced*
        -- re-render with no visual-mode guard — so it can repaint the table while
        -- you're selecting. Rather than race that timer, drive the state
        -- deterministically off mode changes, using the plugin's own APIs:
        --   • entering visual: clear, and bump refresh_token so the plugin's
        --     pending debounced refresh aborts (it checks the token before it
        --     runs), preventing the stray repaint.
        --   • leaving visual: schedule a normal refresh to restore the render.
        local mtw = require("markdown-table-wrap")
        local inline = require("markdown-table-wrap.inline")
        vim.api.nvim_create_autocmd("ModeChanged", {
            callback = function(ev)
                if vim.bo[ev.buf].filetype ~= "markdown" then
                    return
                end
                local from, to = ev.match:match("^(.-):(.*)$")
                local was_visual = from and from:match("[vV\22]") ~= nil
                local now_visual = to and to:match("[vV\22]") ~= nil
                if now_visual and not was_visual then
                    inline.clear(ev.buf)
                    mtw.state.refresh_token = mtw.state.refresh_token + 1 -- cancel pending refresh
                    mtw.state.last_signature[ev.buf] = nil -- force a full repaint next time
                elseif was_visual and not now_visual then
                    mtw.schedule_refresh({ silent = true })
                end
            end,
        })
    end,
}
