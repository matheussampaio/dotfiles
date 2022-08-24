local M = require('lualine.component'):extend()

M.update_status = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_active_clients()

    for _, client in ipairs(clients) do
        if client.attached_buffers[bufnr] ~= nil then
            return client.name
        end
    end

    return ''
end

return M
