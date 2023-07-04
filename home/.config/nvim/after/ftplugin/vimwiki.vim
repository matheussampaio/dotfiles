nmap <buffer> <silent> - :lua require('carbon').explore({ bang = true })<CR>
nnoremap <buffer> =- <Plug>VimwikiRemoveHeaderLevel
nnoremap <buffer> <silent> <Leader>uu :call vimwiki#base#linkify()<CR>

setlocal formatprg=sort\ -V\ --reverse
