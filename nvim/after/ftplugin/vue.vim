call coc#add_extension('coc-vetur')

autocmd FileType vue let g:context#commentstring#table.vue = {
  \ 'javaScript'     : '// %s',
  \ 'cssStyle'       : '/* %s */',
  \ 'vue_typescript' : '// %s',
  \}
