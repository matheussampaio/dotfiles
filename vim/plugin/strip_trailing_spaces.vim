function RemoveTrailingSpaces()
    let w:winview = winsaveview()

    %s/\s\+$//e

    if exists('w:winview')
        call winrestview(w:winview)
    endif
endfunction
