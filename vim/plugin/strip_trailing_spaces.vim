function RemoveTrailingSpaces()
    if exists('b:strip_whitespace')
      let w:winview = winsaveview()

      %s/\s\+$//e

      if exists('w:winview')
          call winrestview(w:winview)
      endif
    endif
endfunction
