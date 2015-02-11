set background=dark
hi clear
if exists("syntax_on")
	syntax reset
endif
let colors_name = "ryanuber1"

" General colors
hi Normal		ctermfg=254		ctermbg=234		cterm=none
hi Cursor		ctermfg=none	ctermbg=241		cterm=none
hi Visual		ctermfg=7		ctermbg=238		cterm=none
hi Folded		ctermfg=103		ctermbg=238		cterm=none
hi Title		ctermfg=7		ctermbg=none	cterm=bold
hi StatusLine	ctermfg=7		ctermbg=238		cterm=none
hi VertSplit	ctermfg=238		ctermbg=238		cterm=none
hi StatusLineNC	ctermfg=243		ctermbg=238		cterm=none
hi LineNr		ctermfg=243		ctermbg=0		cterm=none
hi SpecialKey	ctermfg=244		ctermbg=236		cterm=none
hi NonText		ctermfg=244		ctermbg=236		cterm=none

" Vim >= 7.0 specific colors
if version >= 700
hi CursorLine					ctermbg=236		cterm=none
hi MatchParen	ctermfg=7		ctermbg=243		cterm=bold
hi Pmenu		ctermfg=7		ctermbg=238
hi PmenuSel		ctermfg=0		ctermbg=203
endif

" Syntax highlighting
hi Keyword		ctermfg=197		cterm=none
hi Statement	ctermfg=203		cterm=none
hi Constant		ctermfg=120		cterm=none
hi Number		ctermfg=255		cterm=none
hi PreProc		ctermfg=108		cterm=none
hi Function		ctermfg=249		cterm=none
hi Identifier	ctermfg=197     cterm=none
hi Type			ctermfg=250		cterm=none
hi Special		ctermfg=120		cterm=none
hi String		ctermfg=250		cterm=none
hi Comment		ctermfg=241		cterm=none
hi Todo			ctermfg=245		cterm=none
hi Boolean		ctermfg=197		cterm=none
hi Operator     ctermfg=250     cterm=none
hi Repeat       ctermfg=203     cterm=none

" Links
hi! link FoldColumn		Folded
hi! link CursorColumn	CursorLine

" vim:set ts=4 sw=4 noet:
