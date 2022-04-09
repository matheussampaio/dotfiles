require('telescope').setup {
  defaults = {
    file_sorter = require "telescope.sorters".get_fzy_sorter,
    generic_sorter = require "telescope.sorters".get_fzy_sorter,
    preview = {
      hide_on_startup = true
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--iglob",
      "!package-lock.json",
    },
    file_ignore_patterns = { "node_modules", ".git" }
  },

  pickers = {
    find_files = {
      hidden = true,
      follow = true
    }
  },

  extensions = {
  }
}

require('telescope').load_extension('fzf')
