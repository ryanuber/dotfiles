" Custom open function for Command-T. This forces vim to always open a new
" vertical split when a file is selected from the Command-T list.
function! CommandTCustomOpen(...)
  for file in a:000
    exec "vs " . file
  endfor
endfunction
command! -nargs=+ CommandTCustomOpen call CommandTCustomOpen("<args>")
let g:CommandTAcceptSelectionCommand = 'CommandTCustomOpen'
