require('nvim-treesitter.configs').setup({
    ensure_installed = {
        "bash",
        "html",
        "java",
        "javascript",
        "json",
        "lua",
        "markdown",
        "python",
        "ruby",
        "rust",
        "typescript",
        "vim",
        "vue"
    },

    sync_install = false,

    highlight = {
        enable = true,

        additional_vim_regex_highlighting = { 'org' },
    },

    select = {
        enable = true,

        lookahead = true,

        keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner"
        }
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

require('treesitter-context').setup({
})
