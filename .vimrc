" These will be applied to all unknown extensions and every known file
" extension unless overridden later on
set syntax=on
set title
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set number

" Markdown files
autocmd BufRead,BufNewFile *.md,*.markdown setlocal tw=80 wrap syntax=off

" C files
autocmd BufRead,BufNewFile *.c,*.cpp setlocal tabstop=4 softtabstop=4 shiftwidth=4

" Python files
autocmd BufRead,BufNewFile *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4

" Shell scripts
autocmd BufRead,BufNewFile *.sh,*.bash setlocal tabstop=4 softtabstop=4 shiftwidth=4

" PHP files
autocmd BufRead,BufNewFile *.php setlocal tabstop=4 softtabstop=4 shiftwidth=4

" Ruby files
autocmd BufRead,BufNewFile *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2

" YAML documents
autocmd BufRead,BufNewFile *.yaml,*.yml setlocal tabstop=2 softtabstop=2 shiftwidth=2

" JSON documents
autocmd BufRead,BufNewFile *.json setlocal tabstop=2 softtabstop=2 shiftwidth=2

" CSS files
autocmd BufRead,BufNewFile *.css setlocal tabstop=2 softtabstop=2 shiftwidth=2

" HTML documents
autocmd BufRead,BufNewFile *.html setlocal tabstop=4 softtabstop=4 shiftwidth=4
