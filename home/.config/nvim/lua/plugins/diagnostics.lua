vim.diagnostic.config({
    -- signs = true,
    float = {
        source = true
    },
    -- virtual_text = {
    --     source = true
    -- }
})

vim.keymap.set('n', '<CR>', vim.diagnostic.open_float, { desc = "Diagnostic open float" })
vim.keymap.set('n', '<Leader>ll', vim.diagnostic.setloclist, { desc = "Load diagnostics to loc list" })
vim.keymap.set('n', '<Leader>lq', vim.diagnostic.setqflist, { desc = "Load all diagnostics to quickfix list" })
vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev({ float = false }) end, { desc = "Go to previous diagnostic" })
vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next({ float = false }) end, { desc = "Go to next diagnostic" })
