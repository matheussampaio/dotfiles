require('orgmode').setup_ts_grammar()

require('nvim-treesitter.configs').setup({
    ensure_installed = {
        "bash",
        "html",
        "java",
        "javascript",
        "json",
        "lua",
        "markdown",
        "org",
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

    incremental_selection = {
        enable = true,

        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
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
