local ts = require('nvim-treesitter')

ts.install({ 'vimdoc', 'java', 'javascript' })

local function enable(bufnr)
  -- Disable in large files
  if vim.api.nvim_buf_line_count(bufnr) > 50000 then
    return
  end

  if not pcall(vim.treesitter.start, bufnr) then
    return
  end

  vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Enable treesitter, installing the parser when available',
  group = vim.api.nvim_create_augroup('matheus-treesitter', { clear = true }),
  callback = function(event)
    local lang = vim.treesitter.language.get_lang(event.match)

    if not lang then
      return
    end

    if vim.list_contains(ts.get_installed(), lang) then
      enable(event.buf)
    elseif vim.list_contains(ts.get_available(), lang) then
      ts.install({ lang }):await(vim.schedule_wrap(function()
        if vim.api.nvim_buf_is_valid(event.buf) then
          enable(event.buf)
        end
      end))
    end
  end,
})

require('nvim-treesitter-textobjects').setup({
  select = {
    lookahead = true,
  },
})

local select_textobjects = {
  ['af'] = { '@function.outer', 'Select function' },
  ['if'] = { '@function.inner', 'Select inner function' },
  ['ac'] = { '@class.outer', 'Select class' },
  ['ic'] = { '@class.inner', 'Select inner class' },
}

for keys, textobject in pairs(select_textobjects) do
  vim.keymap.set({ 'x', 'o' }, keys, function()
    require('nvim-treesitter-textobjects.select').select_textobject(textobject[1], 'textobjects')
  end, { desc = textobject[2] })
end
