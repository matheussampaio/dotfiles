local M = require('lualine.component'):extend()

M.update_status = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = {}

  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    table.insert(clients, client.name)
  end

  return table.concat(clients, ', ')
end

return M
