" Reload this config if it changes.
if !exists('*ReloadVimRC')
  fun! ReloadVimRC()
    let save_cursor = getcurpos()
    source $MYVIMRC
    call setpos('.', save_cursor)
  endfun
endif
autocmd! BufWritePost $MYVIMRC call ReloadVimRC()

" Do plugin things after initializing.
colorscheme janah
nnoremap <C-p> :Files<cr>
let g:go_template_autocreate = 0
let g:dart_format_on_save = v:true
let g:dart_style_guide = 2

" Split settings
set splitright
set splitbelow
nnoremap <C-j> <C-w><Left>
nnoremap <C-l> <C-w><Right>
nnoremap <C-i> :vs<cr>

" Code shaping
set ts=4
set sts=4
set sw=4
set smarttab
set expandtab
set smartindent
set colorcolumn=80

" Highlight the current line
set cursorline

" Always write to /tmp. Avoids stupid issues with .swp files ending up in
" source control and needing to endlessly .gitignore them. Consider security
" if you use this.
set dir=/tmp

" Number dem lines.
set nu

" Mouse
set mouse=a
set scrolloff=5

" Highlight extraneous whitespace.
hi extraneous ctermbg=52
match extraneous /\s\+\%#\@<!$/
