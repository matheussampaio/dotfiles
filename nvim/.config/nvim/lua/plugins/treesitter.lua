require('nvim-treesitter.configs').setup {
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
        "typescript",
        "vim",
        "vue"
    },

    sync_install = false,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
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
}

vim.o.foldmethod = "expr"
vim.cmd("set foldexpr=nvim_treesitter#foldexpr()")
