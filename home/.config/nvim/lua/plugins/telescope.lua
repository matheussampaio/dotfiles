require('telescope').setup({
    defaults = {
        -- vimgrep_arguments = {
        --     "rg",
        --     "--color=never",
        --     "--no-heading",
        --     "--with-filename",
        --     "--line-number",
        --     "--column",
        --     "--smart-case",
        --     "--hidden",
        --     "--iglob",
        --     "!package-lock.json",
        -- },
        file_ignore_patterns = { "node_modules", ".git", "alfred" },
        mappings = {
            i = {
                ["<Esc>"] = require('telescope.actions').close,
                ["<C-l>"] = require('telescope.actions.layout').toggle_preview,
                ["<C-d>"] = require('telescope.actions').results_scrolling_down,
                ["<C-u>"] = require('telescope.actions').results_scrolling_up,
                ["<C-k>"] = require('telescope.actions').move_selection_previous,
                ["<C-j>"] = require('telescope.actions').move_selection_next
            }
        },
        path_display = {
            shorten = {
                len = 1,
                exclude = { 1, -1 }
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
        ["zf-native"] = {
            file = {
                enable = true,
                highlight_results = true,
                match_filename = true
            },
            generic = {
                enable = true,
                highlight_results = true,
                match_filename = false
            }
        },
        ['ui-select'] = {
            require('telescope.themes').get_dropdown()
        }
    }
})

 -- Enable Telescope extensions if they are installed
pcall(require('telescope').load_extension, 'zf-native')
pcall(require('telescope').load_extension, 'ui-select')

-- See `:help telescope.builtin`
local builtin = require 'telescope.builtin'

vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', function ()
    builtin.find_files({ hidden = true })
end, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', 'z=', builtin.spell_suggest, { desc = "[S]earch Spell S[u]ggestions" })
