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

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true
  },

  -- this works?! not sure.
  autopairs = {
    enable = true
  },

  context_commentstring = {
    enable = true
  }
}

-- syntax highlighting items specify folds.
vim.o.foldmethod = "expr"
vim.cmd("set foldexpr=nvim_treesitter#foldexpr()")
