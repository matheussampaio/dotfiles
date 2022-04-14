vim.diagnostic.config({
  update_in_insert = false,
  virtual_text = {
    source = true
  },
  float = {
    source = true
  }
})

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true, desc = "Diagnostic open float" })
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true, desc = "Go to previous diagnostic" })
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true, desc = "Go to next diagnostic" })
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true, desc = "Load diagnostics to loc list" })

-- show diagnostic problem when hovering line
-- vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
--   group = vim.api.nvim_create_augroup('DiagnosticOnHover', { clear = true }),
--   pattern = { '*' },
--   callback = function() vim.diagnostic.open_float(nil, {focus=false, scope="cursor"}) end
-- })