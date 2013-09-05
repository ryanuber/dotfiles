" These will be applied to all unknown extensions and every known file
" extension unless overridden later on
syntax on
set title
set ts=4
set sts=4
set sw=4
set smarttab
set expandtab
set number
set nosi
set noai

" Line highlighting options (may cause performance issues)
set cursorline
hi CursorLine cterm=NONE ctermbg=darkgrey
hi CursorLineNr cterm=NONE ctermfg=grey
hi LineNr cterm=NONE ctermfg=darkgrey

" Remember cursor position and jump to it on file open
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Highlight chars after column 80
hi toolong ctermbg=red ctermfg=white
match toolong /\%81v.*/

" Markdown files
au BufRead,BufNewFile *.md,*.markdown setl tw=80 wrap syntax=off

" C files
au FileType c setl ts=4 sts=4 sw=4
au FileType cpp setl ts=4 sts=4 sw=4

" Python files
au FileType python setl ts=4 sts=4 sw=4

" Shell scripts
au FileType sh setl ts=4 sts=4 sw=4

" PHP files
au FileType php setl ts=4 sts=4 sw=4

" Ruby files
au FileType ruby setl ts=2 sts=2 sw=2

" YAML documents
au BufRead,BufNewFile *.yaml,*.yml setl ts=2 sts=2 sw=2

" JSON documents
au BufRead,BufNewFile *.json setl ts=2 sts=2 sw=2

" CSS files
au FileType css setl ts=2 sts=2 sw=2

" HTML documents
au FileType html setl ts=4 sts=4 sw=4

" Disable comment continuation *AFTER* defaults from autocmd are collected
au FileType * setl fo-=cro
