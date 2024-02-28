require('nvim-treesitter.configs').setup({
    -- Disable in large files
    disable = function(_, bufnr)
        return vim.api.nvim_buf_line_count(bufnr) > 50000
    end,

    auto_install = true,

    ensure_installed = {
        "vimdoc",
        "java",
        "javascript",
    },

    sync_install = false,

    highlight = {
        enable = true,
    },

    textobjects = {
        select = {
            enable = true,

            lookahead = true,

            keymaps = {
                ["af"] = { query = "@function.outer", desc = "Select function" },
                ["if"] = { query = "@function.inner", desc = "Select inner function" },
                ["ac"] = { query = "@class.outer", desc = "Select class" },
                ["ic"] = { query = "@class.inner", desc = "Select inner class" },
            },
        },
    },

    incremental_selection = {
        enable = true,

        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm"
        }
    },

    indent = {
        enable = true
    },

    autopairs = {
        enable = true
    },

    context_commentstring = {
        enable = true
    }
})
