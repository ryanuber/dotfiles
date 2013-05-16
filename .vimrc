set syntax=on
set title
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set number
autocmd BufRead,BufNewFile *.md,*.markdown setlocal tw=80 wrap syntax=off
autocmd BufRead,BufNewFile *.c,*.cpp setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd BufRead,BufNewFile *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd BufRead,BufNewFile *.sh,*.bash setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd BufRead,BufNewFile *.php setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd BufRead,BufNewFile *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd BufRead,BufNewFile *.yaml,*.yml setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd BufRead,BufNewFile *.json setlocal tabstop=2 softtabstop=2 shiftwidth=2
