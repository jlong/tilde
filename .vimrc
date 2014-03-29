set nocompatible     " We aren't interested in backward compatability with vi, set before all other
filetype off         " Required for Vundle


" Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Vundle Plugins

Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdtree'

" File types
filetype plugin indent on                                  " Required for Vundle
autocmd BufRead,BufNewFile Capfile set filetype=ruby       " recognize Capfile
autocmd BufRead,BufNewFile Gemfile set filetype=ruby       " recognize Gemfile
autocmd BufRead,BufNewFile *.jst set filetype=html

" Other settings
set history=1000                                           " Lots of command line history
set autoindent
set autowrite
set expandtab                                              " Expand tabs to spaces
set shiftwidth=2
set tabstop=2
set smarttab
set wildmode=list:longest                                  " Helpful tab completion
set wildcharm=<Tab>                                        " :h wildcharm
set backspace=start,indent,eol                             " Allow delete across lines

set fileformats=unix,mac,dos

set showmatch
set nojoinspaces
set scrolloff=2
set splitbelow

" :Man plugin
runtime ftplugin/man.vim

" Ignore case in search patterns, unless uppercase letters used
set ignorecase smartcase

" Backup Dir
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Swapfile Dir
set directory=~/.vim-tmp//,~/.tmp//,~/tmp//,/var/tmp//,/tmp//

" Clear the backup dir
command ClearBackups execute "!rm -rf ~/.vim-tmp/*"


" ====================
" User Interface
" ====================

set hlsearch                                               " I like highlighted searches
set visualbell
set cursorline                                             " highlight the current line

" Status line
let g:airline_powerline_fonts=1                            " use airline with powerline fonts
let g:airline_theme='badwolf'                                " airline theme
set laststatus=2                                           " always show status line
set statusline=
set statusline+=%-3.3n\                                    " buffer number
set statusline+=%f%{&modified?'+':''}\                     " filename (+ modified)
set statusline+=%h%r%w\                                    " status flags
set statusline+=%=                                         " right align remainder
"set statusline+=0x%-8B                                    " character value
set statusline+=\[%{strlen(&ft)?&ft:'none'}]\ \ \          " file type
"set statusline+=%-20{fugitive#statusline()}\ 
set statusline+=%-14(%l,%c%V%)                             " line, character
set statusline+=%<%P                                       " file position

" Syntax highlighting
syntax enable
set t_Co=256
colorscheme lucius-dark
autocmd BufRead * highlight ExtraWhitespace ctermbg=bg guibg=bg " Hide extra whitespace

hi TabLine      ctermfg=Gray   ctermbg=Black   cterm=NONE
hi TabLineFill  ctermfg=Gray   ctermbg=Black   cterm=NONE
hi TabLineSel   ctermfg=Black  ctermbg=White   cterm=NONE

" Mouse
set mouse=a

" GUI Options
if has("gui_running")
  set guioptions+=TlRLrb
  set guioptions-=TlRLrb
  set guifont=Monaco:h14
  set noantialias
  set transparency=8
endif


" Expand all folds
autocmd BufRead * call feedkeys("zR")

" Make pasting work without indentation in terminal
if &term =~ "xterm.*"
    let &t_ti = &t_ti . "\e[?2004h"
    let &t_te = "\e[?2004l" . &t_te
    function XTermPasteBegin(ret)
        set pastetoggle=<Esc>[201~
        set paste
        return a:ret
    endfunction
    map <expr> <Esc>[200~ XTermPasteBegin("i")
    imap <expr> <Esc>[200~ XTermPasteBegin("")
endif

" ==================
" Buffers
" ==================

set hidden                                                 " Leave buffers even when they're changed

autocmd BufReadPost *                                      " Restore cursor position
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

if v:version >= 703                                        " Persistent UNDO, only available in Vim 7.3 or greater
  set undofile
  set undodir=~/.vim/.undo
endif

set clipboard+=unnamed                                     " Cause yank, p, etc to work with the System clipboard (requires +clipboard)

" ==================
" Mappings
" ==================
let mapleader = ","                                        " A way to make command mapping shorter; see <leader> throughout this
imap ;; <Esc>

" Paste linewise after with indent
nnoremap <leader>p :put *<cr>`[v`]=

set winheight=15 winminheight=0

" move between windows
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l

" move and maximize
nnoremap <D-j> <C-W>j<C-W>_
nnoremap <D-k> <C-W>k<C-W>_

" resize windows
nmap <S-Left> <C-W><<C-W><
nmap <S-Right> <C-W>><C-W>>
nmap <S-Up> <C-W>+<C-W>+
nmap <S-Down> <C-W>-<C-W>-
nmap <C--> <C-W>_
nmap <C-_> <C-W>_

" split explore hotkey
nmap <F2> <leader>d<CR>

" toggle line numbers
" set number        " Show line numbers on the left
nmap <F3> :set nonumber!<CR>

" toggle wordwrap
set nowrap          " Don't wrap lines longer than window width
set linebreak       " Wrap on words
nmap <F4> :set nowrap!<CR>

" Goyo
let g:goyo_margin_top=1
let g:goyo_margin_bottom=1
map <F5> :Goyo<CR>

" vimrc Hotkey
map <F6> :tabnew<CR><C-L>:e ~/.vimrc<CR>

" Tagbar
map <F8> :TagbarOpenAutoClose<CR>

" html template
nmap <leader>html _i<html><CR><ESC>0i<TAB><head><CR><ESC>0i<TAB><TAB><title></title><CR><ESC>0i<TAB></head><CR><ESC>0i<TAB><body><CR><ESC>0i<TAB></body><CR><ESC>0i</html><ESC>bbbbbbbbbbbbbba

" Copy to selection to clipboard
vmap <leader> !pbcopy && pbpaste<CR>

nnoremap <leader>b :b<space><Tab>

" edit vimrc
nmap <leader>v :sp $MYVIMRC<CR><C-W>_
nmap <leader>V :source $MYVIMRC<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR><leader>d<leader>d<C-L>

" Ctrl-p
silent! nmap <unique> <silent> <Leader>f :CtrlP<CR>
nnoremap <leader>F :CtrlPClearAllCaches<CR>:CtrlP<CR>
set wildignore+=public/assets/**,build/**,vendor/plugins/**,vendor/linked_gems/**,vendor/gems/**,vendor/rails/**,vendor/ruby/**,vendor/cache/**,Libraries/**,coverage/**
let g:ctrlp_max_height=20
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files . -co --exclude-standard']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v(\.git|\.yardoc|log|tmp)$',
  \ 'file': '\v\.(so|dat|DS_Store|png|gif|jpg|jpeg)$'
  \ }

" NERDtree
let NERDTreeWinSize=31
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
map <leader>nt :NERDTree<space>
map <leader>nb :NERDTreeFromBookmark<space>
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>
map <leader>R :NERDTreeFind<CR>

" Rails
nnoremap <leader><leader>c :Rcontroller<space>
nnoremap <leader><leader>m :Rmodel<space>
nnoremap <leader><leader>a :Rmailer<space>
nnoremap <leader><leader>v :Rview<space>
nnoremap <leader><leader>h :Rhelper<space>
nnoremap <leader><leader>i :Rinitializer<space>
nnoremap <leader><leader>e :Renvironment<space>
nnoremap <leader><leader>l :Rlib<space>
nnoremap <leader><leader>f :Rfeature<space>
nnoremap <leader><leader>u :Runittest<space>
nnoremap <leader><leader>j :Rjavascript<space>
nnoremap <leader><leader>t :Rtask<space>
nnoremap <leader><leader>r :Rspec<space>

" ==================
" Tags
"   See http://sites.google.com/site/daveparillo/software-development/vim/ctags
"
"   :!ctags -R  // recursively generate tags for every known file type
" ==================
" TODO Learn to use tags beyond the TlistToggle...
"set tags=./tags
"map <leader>gt :execute

" Taglist plugin
let Tlist_Show_One_File = 1
map <leader>S :TlistToggle<CR>
let tlist_javascript_settings='javascript;v:globals;c:classes;f:functions;m:methods;p:properties;r:protoype'


" Searching
set incsearch                                           " Incremental searching with /

" Command-Shift-F for Ack
nnoremap <D-F> :Ack<space>""<Left>
nnoremap <leader>a :Ack<space>""<Left>
nnoremap <leader>A :Ack<cword><CR>
nnoremap <leader>rw :Ack<space>--type=ruby<space><cword><CR>
vmap <leader>A "ry:Ack<space>"<C-r>r"<CR>

" Substitution
nmap <leader>r :%s/<C-r><C-w>/
vmap <leader>r "ry:%s/<C-r>r/

" Show trailing whitespace with ,s
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>

" Space pages
"map <Space> <C-d>
"map <S-Space> <C-u>

" Scroll the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
