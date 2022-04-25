local luasnip = require('luasnip')
local cmp = require('cmp')

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    window = {
        completion = {
            border = 'rounded',
            scrollbar = "║",
            autocomplete = {
                require("cmp.types").cmp.TriggerEvent.InsertEnter,
                require("cmp.types").cmp.TriggerEvent.TextChanged,
            },
        },
        documentation = {
            border = 'rounded',
            scrollbar = "║",
        },
    },

    mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ["<C-Space>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        }),
        ["<Tab>"] = function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if luasnip.expand_or_jumpable(-1) then
                luasnip.expand_or_jump(-1)
            else
                fallback()
            end
        end
    }),

    sources = cmp.config.sources({
        { name = 'copilot' },
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'path' },
    }, {
        { name = 'buffer' },
    }),

    formatting = {
        format = require('lspkind').cmp_format({
            mode = 'symbol',

            menu = {
                nvim_lsp = "[LSP]",
                nvim_lsp_signature_help = "[LSP]",
                path = "[path]",
                luasnip = "[snip]",
                buffer = "[buf]",
                copilot = "[copilot]",
            }
        })
    },

    experimental = {
        ghost_text = true,
    },

    sorting = {
        comparators = {
            cmp.config.compare.recently_used,
            cmp.config.compare.offset,
            cmp.config.compare.score,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },

    preselect = cmp.PreselectMode.Item,
})
