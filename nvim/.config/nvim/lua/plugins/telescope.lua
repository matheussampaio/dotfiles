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
    file_ignore_patterns = { "node_modules", ".git" },
    mappings = {
      i = {
        ["<Esc>"] = require('telescope.actions').close,
      }
    }
  },

  pickers = {
    find_files = {
      hidden = true,
      follow = true
    }
  }
}

require('telescope').load_extension('fzf')

-- Search for a term in the current directory
vim.api.nvim_set_keymap('', '<Leader>s', ':Telescope live_grep<CR>', { noremap = true, silent = true })

-- Browse list of files in current directory
vim.api.nvim_set_keymap('', '<Leader>p', ':Telescope find_files<CR>', { noremap = true, silent = true })

-- Search help tags
vim.api.nvim_set_keymap('', '<Leader>th', ':Telescope help_tags<CR>', { noremap = true, silent = true })

