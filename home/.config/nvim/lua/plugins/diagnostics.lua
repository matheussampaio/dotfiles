vim.diagnostic.config({
    update_in_insert = false,
    virtual_text = false,
    float = {
        source = true
    }
})

vim.keymap.set('n', '<Leader>df', vim.diagnostic.open_float, { desc = "Diagnostic open float" })
vim.keymap.set('n', '<Leader>dl', vim.diagnostic.setloclist, { desc = "Load diagnostics to loc list" })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
