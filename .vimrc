" These will be applied to all unknown extensions and every known file
" extension unless overridden later on
syn on
set title
set ts=4
set sts=4
set sw=4
set smarttab
set expandtab
set ru
set nu
set nosi
set noai

" Colors
"colorscheme zenburn
colorscheme wombat256

" Line highlighting options (may cause performance issues)
set cursorline

" Remember cursor position and jump to it on file open
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Highlight chars after column 80
hi toolong ctermbg=red ctermfg=white
match toolong /\%81v.\+/

" Highlight trailing whitespace
hi trailws ctermbg=red ctermfg=white
2match trailws /\s\+\%#\@<!$/

" Markdown files
au BufRead,BufNewFile *.md,*.markdown setl tw=80 wrap syn=off

" C files
au FileType c setl ts=4 sts=4 sw=4
au FileType cpp setl ts=4 sts=4 sw=4

" Makefiles
au FileType make set noexpandtab

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
au BufRead,BufNewFile *.html.erb,*.html.markdown set ft=html
au FileType html setl nosmarttab noexpandtab
au FileType html setl ts=2 sts=2 sw=2

" GO files
au BufRead,BufNewFile *.go set ft=go
au FileType go setl nosmarttab noexpandtab
au FileType go setl ts=4 sts=4 sw=4
au FileType go :au BufWritePost *
  \ call system("/usr/bin/env gofmt -w " . expand("%:p"))

" Disable comment continuation *AFTER* defaults from autocmd are collected
au FileType * setl fo-=cro
