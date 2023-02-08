setlocal conceallevel=0

if executable('python')
  setlocal formatprg=python\ -m\ json.tool
endif

if executable('jq')
  let &l:formatprg = 'jq . --indent ' . &shiftwidth
endif

if executable('js-beautify')
  let &l:formatprg = 'js-beautify -f - -j -B -s ' . &shiftwidth
endif
