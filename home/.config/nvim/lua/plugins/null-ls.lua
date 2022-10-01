local null_ls = require('null-ls')

null_ls.setup({
    log_level = "trace",
    sources = {
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.formatting.rustfmt
    },
})
