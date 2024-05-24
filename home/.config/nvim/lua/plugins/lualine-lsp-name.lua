local M = require('lualine.component'):extend()

M.update_status = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = {}

  for _, client in ipairs(vim.lsp.get_active_clients()) do
    if client.attached_buffers[bufnr] ~= nil then
      table.insert(clients, client.name)
    end
  end

  return table.concat(clients, ', ')
end

return M
