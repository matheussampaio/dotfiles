nmap <buffer> - <Plug>(dirvish_up)
nnoremap <buffer> =- <Plug>VimwikiRemoveHeaderLevel
nnoremap <buffer> <silent> <Leader>uu :call vimwiki#base#linkify()<CR>

setlocal formatprg=sort\ -V\ --reverse
