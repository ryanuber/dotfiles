" Custom open function for Command-T. This forces vim to always open a new
" vertical split when a file is selected from the Command-T list.
function! CommandTCustomOpen(...)
  for file in a:000
    if !&modified
      exec "e " . file
    else
      exec "vs " . file
    endif
  endfor
endfunction
command! -nargs=+ CommandTCustomOpen call CommandTCustomOpen("<args>")

function! CommandTCustomOpenForceSplit(...)
  for file in a:000
    exec "vs " . file
  endfor
endfunction
command! -nargs=+ CommandTCustomOpenForceSplit call CommandTCustomOpenForceSplit("<args>")

let g:CommandTAcceptSelectionCommand = 'CommandTCustomOpen'
let g:CommandTAcceptSelectionSplitCommand = 'CommandTCustomOpenForceSplit'
