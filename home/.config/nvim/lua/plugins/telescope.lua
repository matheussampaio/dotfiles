require('telescope').setup({
    defaults = {
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--iglob",
            "!package-lock.json",
        },
        file_ignore_patterns = { "node_modules", ".git" },
        mappings = {
            i = {
                ["<Esc>"] = require('telescope.actions').close,
                ["<C-l>"] = require('telescope.actions.layout').toggle_preview,
                ["<C-d>"] = require('telescope.actions').results_scrolling_down,
                ["<C-u>"] = require('telescope.actions').results_scrolling_up,
                ["<C-k>"] = require('telescope.actions').move_selection_previous,
                ["<C-j>"] = require('telescope.actions').move_selection_next
            }
        }
    },

    pickers = {
        find_files = {
            hidden = true,
            follow = true
        }
    },

    extensions = {
        fzf = {
            override_generic_sorter = true,
            override_file_sorter = true,
        },
        ["ui-select"] = {
            require("telescope.themes").get_dropdown({})
        }
    }
})

require('telescope').load_extension('fzf')
require('telescope').load_extension('ui-select')
require('telescope').load_extension('dap')

-- Search for a term in the current directory
vim.keymap.set('', '<Leader>f', require('telescope.builtin').live_grep, { desc = "Search text" })

-- Browse list of files in current directory
vim.keymap.set('', '<Leader>p', require('telescope.builtin').find_files, { desc = "Search files" })

-- Search help tags
vim.keymap.set('', '<Leader>sh', require('telescope.builtin').help_tags, { desc = "Search help tags" })

-- Search for word under cursor
vim.keymap.set('', '<Leader>sw', require('telescope.builtin').grep_string, { desc = "Search current word" })

-- Resume telescope
vim.keymap.set('', '<Leader>sr', require('telescope.builtin').resume, { desc = "Resume search" })
