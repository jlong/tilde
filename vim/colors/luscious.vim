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

