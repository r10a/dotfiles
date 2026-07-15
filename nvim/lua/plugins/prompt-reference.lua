-- Stage code selections + per-item prompts into a review, then copy the whole
-- bundle (XML) for pasting to LLMs. Extracted from this config into a standalone
-- plugin: https://github.com/r10a/prompt-reference.nvim
-- Visual <CR> adds the selection (asking a prompt); a live panel shows staged
-- items at the bottom-right; TabTab opens the review (Enter copies + clears).
return {
    "r10a/prompt-reference.nvim",
    opts = {
        output_style = "xml", -- xml parses more reliably for Claude
        keymaps = true, -- visual <CR> = add, <Tab><Tab> = review
    },
}
