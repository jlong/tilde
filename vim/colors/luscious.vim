"
" A few modifications to Lucius by @johnwlong
"

" Start with Lucius
runtime colors/lucius.vim

" Rename as "luscious"
let g:colors_name = "luscious"

" Darken the background
hi Normal        ctermfg=253      ctermbg=16

" Vertical split
hi VertSplit     guifg=#363946    guibg=#363946   gui=none
hi VertSplit     ctermfg=237      ctermbg=237     cterm=none

" Tab line
hi TabLine       ctermfg=244      ctermbg=234
hi TabLineFill   ctermfg=244      ctermbg=234
hi TabLineSel    ctermfg=white    ctermbg=126

" Cursor line
hi CursorLine    ctermfg=NONE     ctermbg=234

" Color Column
hi ColorColumn   ctermfg=NONE     ctermbg=234

" Keywords
hi Function      guifg=#efaf7f    gui=none
hi Function      ctermfg=216      cterm=none
hi Identifier    guifg=#efaf7f    gui=none
hi Identifier    ctermfg=216      cterm=none
hi Keyword       guifg=#efaf7f    gui=none
hi Keyword       ctermfg=216      cterm=none
hi Special       guifg=#efaf7f    gui=none
hi Special       ctermfg=216      cterm=none

hi SpellCap      ctermfg=fg       ctermbg=none
hi SpellCap      guifg=fg         guibg=none
