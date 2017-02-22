" Enable pathogen
execute pathogen#infect()

" These will be applied to all unknown extensions and every known file
" extension unless overridden later on
syn on
set title
set ts=4
set sts=4
set sw=4
set smarttab
set expandtab
set nu
set nosi
set nolist
set dir=/tmp
set scrolloff=5

" Enable filetype detection
filetype plugin on

" Colors
colorscheme predawn

" Disable left/right scrollbars in GUI
set go-=L
set go-=r

" Draws a line at the 80-character boundary
set colorcolumn=80
hi ColorColumn ctermbg=236

" Line highlighting options (may cause performance issues)
set cursorline
hi CursorLine ctermbg=236

" Remap leader key
let mapleader=","

" Resize splits sanely
noremap <C-i> <C-w><
noremap <C-o> <C-w>>
noremap <C-u> <C-w>=

" Remember cursor position and jump to it on file open
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") |
    \ exe "normal! g'\"" | endif
endif

" Mark indentation
set listchars=tab:·\ 

" Highlight trailing whitespace.
" I would normally just have vim remove it but this can be problmatic when
" editing large, existing codebases which haven't followed this strictly.
hi trailws ctermbg=52
match trailws /\s\+\%#\@<!$/

" Split settings
set splitright
set splitbelow
nnoremap <C-j> <C-w><Left>
nnoremap <C-k> <C-w><Right>

" Git commit messages
au FileType gitcommit setl tw=72 wrap syn=off

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

" Go files
au FileType go setl nosmarttab noexpandtab
au FileType go setl ts=4 sts=4 sw=4
let g:go_highlight_operators=1
let g:go_highlight_methods=0
let g:go_highlight_structs=0
let g:go_highlight_trailing_whitespace_error=0
let g:go_highlight_space_tab_error=0
let g:go_highlight_chan_whitespace_error=0
let g:go_highlight_array_whitespace_error=0

" Terraform files
au BufRead,BufNewFile *.tf setl ts=2 sts=2 sw=2

" Disable comment continuation *AFTER* defaults from autocmd are collected
au FileType * setl fo-=cro

" vim-airline
set laststatus=2
let g:airline_powerline_fonts=1
let g:airline_theme="ryanuber"

" Use silver searcher instead of grep
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
