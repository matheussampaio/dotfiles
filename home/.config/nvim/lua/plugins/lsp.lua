local M = {}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
M.on_attach = function(_, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- vim.api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave', 'BufWritePost' }, {
    --     desc = 'Refresh CodeLens',
    --     buffer = bufnr,
    --     callback = function()
    --         if vim.lsp.buf.server_ready() then
    --             -- vim.lsp.codelens.refresh()
    --         end
    --     end
    -- })
end

M.capabilities = require('cmp_nvim_lsp').default_capabilities()


-- Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
vim.keymap.set('n', '<Leader>a', vim.lsp.buf.code_action, { desc = 'Open code action' })
vim.keymap.set('n', '<Leader>lf', function() vim.lsp.buf.format() end, { desc = 'Format' })
vim.keymap.set('n', 'gD', function ()
    if not pcall(vim.lsp.buf.declaration) then
        vim.cmd([[normal! gD]])
    end
end, { desc = 'Go to declaration' })
vim.keymap.set('n', 'gd', function()
    if not pcall(require('telescope.builtin').lsp_definitions) then
        vim.cmd([[normal! gd]])
    end
end, { desc = 'Go to definition' })
vim.keymap.set('n', 'gm', require('telescope.builtin').lsp_implementations, { desc = 'Go to implementation' })
vim.keymap.set('n', 'gp', require('telescope.builtin').lsp_type_definitions, { desc = 'Go to type definition' })
vim.keymap.set('n', '<Leader>lr', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { desc = 'Open references' })
-- vim.keymap.set('n', '<Leader>lwa', vim.lsp.buf.add_workspace_folder, { desc = 'Add workspace folder' })
-- vim.keymap.set('n', '<Leader>lwl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
--     { desc = 'List workspaces folders' })
-- vim.keymap.set('n', '<Leader>lwr', vim.lsp.buf.remove_workspace_folder, { desc = 'Remove workspace folder' })
vim.keymap.set('n', 'K', function()
    if not pcall(vim.lsp.buf.hover) then
        vim.cmd([[normal! K]])
    end
end, { desc = 'See documentation' })

local lspconfig = require('lspconfig')

local lsp_with_simple_configs = {
    -- javascript, typescript
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
    "tsserver",

    -- python
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pylsp
    "pylsp",

    -- rust
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    "rust_analyzer",
}

for _, lsp in ipairs(lsp_with_simple_configs) do
    lspconfig[lsp].setup({ on_attach = M.on_attach, capabilities = M.capabilities })
end

-- ruby
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#solargraph
lspconfig.solargraph.setup({
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    settings = {
        solargraph = {
            diagnostics = false
        }
    }
})

-- lua
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
local runtime_path = vim.split(package.path, ';')

table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.sumneko_lua.setup({
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' }
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false
            },
            telemetry = {
                enable = false
            }
        }
    }
})

return M
