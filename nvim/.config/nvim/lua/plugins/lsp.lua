local lspconfig = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end


-- Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
vim.keymap.set('n', '<Leader>la', vim.lsp.buf.code_action, { desc = 'Open code action' })
vim.keymap.set('n', '<Leader>ld', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', '<Leader>lD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
vim.keymap.set('n', '<Leader>lf', vim.lsp.buf.formatting, { desc = 'Format' })
vim.keymap.set('n', '<Leader>li', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
vim.keymap.set('n', '<Leader>ln', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', '<Leader>lr', vim.lsp.buf.references, { desc = 'Open references' })
vim.keymap.set('n', '<Leader>lt', vim.lsp.buf.type_definition, { desc = 'Go to type definition' })
vim.keymap.set('n', '<Leader>lwa', vim.lsp.buf.add_workspace_folder, { desc = 'Add workspace folder' })
vim.keymap.set('n', '<Leader>lwl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, { desc = 'List workspaces folders' })
vim.keymap.set('n', '<Leader>lwr', vim.lsp.buf.remove_workspace_folder, { desc = 'Remove workspace folder' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'See documentation' })

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- javascript, typescript
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
lspconfig.tsserver.setup({
    on_attach = on_attach,
    capabilities = capabilities
})

-- ruby
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#solargraph
lspconfig.solargraph.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        solargraph = {
            diagnostics = false
        }
    }
})

-- python
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pylsp
lspconfig.pylsp.setup({})

-- lua
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
local runtime_path = vim.split(package.path, ';')

table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.sumneko_lua.setup({
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
})
