augroup vuecommentstring
  au!
  au FileType vue let g:context#commentstring#table.vue = {
    \ 'javaScript'     : '// %s',
    \ 'cssStyle'       : '/* %s */',
    \ 'vue_typescript' : '// %s',
    \}
augroup END
