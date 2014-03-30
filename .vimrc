set nocompatible                                            " We aren't interested in backward compatability with vi, set before all other

" Initialize Vundle
filetype off                                                " Required for Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Plugin 'gmarik/vundle'                                      " Let Vundle manage Vundle (required)

" Text manipulation and navigation
Plugin 'goldfeld/vim-seek'                                  " Quickly navigate with s and S
Plugin 'gcmt/wildfire.vim'                                  " Smart selection of closest text object with <ENTER>

" IDE-like features
Plugin 'scrooloose/nerdtree'                                " File tree plugin for Vim
Plugin 'kien/ctrlp.vim'                                     " Easily open files
Plugin 'mileszs/ack.vim'                                    " Simple Vim interface to Ack
Plugin 'bling/vim-airline'                                  " Pretty status line
Plugin 'mkitt/tabline.vim'                                  " Easier control of tabline
Plugin 'airblade/vim-gitgutter'                             " Keep track of additions, subtractions, and modifications
Plugin 'vim-scripts/gitignore'                              " Sync wildignore with .gitignore
Plugin 'Raimondi/delimitMate'                               " Automatically close brackets and quotes like Textmate
Plugin 'ervandew/supertab'                                  " <Tab> completion while in insert mode
Plugin 'msanders/snipmate.vim'                              " Textmate snippets in Vim!
Plugin 'junegunn/goyo.vim'                                  " Distraction-free writing for Vim
Plugin 'scrooloose/syntastic'                               " Syntax checking

" Language support
Plugin 'jlong/sass-convert.vim'                             " Easily convert between Sass syntaxes
Plugin 'plasticboy/vim-markdown'                            " Markdown syntax support
Plugin 'pangloss/vim-javascript'                            " Better support for JavaScript syntax
Plugin 'juvenn/mustache.vim'                                " Mustache syntax support
Plugin 'tpope/vim-haml'                                     " Support for Haml, Sass, & SCSS
Plugin 'vim-ruby/vim-ruby'                                  " Better support for Ruby
Plugin 'tpope/vim-rails'                                    " Support for Rails applications

" Misc plugins
Plugin 'flazz/vim-colorschemes'                             " A zillion Vim color schemes
Plugin 'tpope/vim-git'                                      " Basic git support
Plugin 'tpope/vim-fugitive'                                 " Tim Pope's amazing git plugin
Plugin 'bronson/vim-trailing-whitespace'                    " Whitespace plugin
Plugin 'guns/xterm-color-table.vim'                         " Show color table for adjusting Vim themes
" runtime ftplugin/man.vim                                    " :Man plugin

" File types
filetype plugin indent on                                  " Required for Vundle
autocmd BufRead,BufNewFile Capfile set filetype=ruby       " recognize Capfile
autocmd BufRead,BufNewFile Gemfile set filetype=ruby       " recognize Gemfile

" Search
set ignorecase smartcase                                   " Ignore case in search patterns, unless uppercase letters used
set incsearch                                              " Incremental searching with /
set hlsearch                                               " Highlight searches

" Indentation
set autoindent
set expandtab                                              " Expand tabs to spaces
set shiftwidth=2
set tabstop=2
set smarttab

" Directories
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp        " Backup Dir
set directory=~/.vim-tmp/,~/.tmp/,~/tmp/,/var/tmp/,/tmp/   " Swapfile Dir

" Word wrap
set nowrap                                                 " Don't wrap lines longer than window width
set linebreak                                              " Wrap on words

" Syntax highlighting
syntax enable                                              " Enable syntax higlighting
set t_Co=256                                               " Turn 256 color support on
colorscheme luscious                                       " My custom theme

" Other settings
set history=1000                                           " Lots of command line history
set autowrite
set wildmode=list:longest                                  " Helpful command tab completion
set wildcharm=<Tab>                                        " :h wildcharm
set backspace=start,indent,eol                             " Allow delete across lines
set fileformats=unix,mac,dos
set showmatch                                              " Show matching brackets
set nojoinspaces                                           " Don't join lines with 2 spaces after a period
set scrolloff=2                                            " Scroll up or down with at least 2 lines on either side of the cursor


" ====================
" User Interface
" ====================

set visualbell
set cursorline                                             " highlight the current line
set winheight=15
set winminheight=0

" Status line
let g:airline_powerline_fonts=1                            " use airline with powerline fonts
let g:airline_theme='badwolf'                              " airline theme
set laststatus=2                                           " always show status line
set statusline=
set statusline+=%-3.3n\                                    " buffer number
set statusline+=%f%{&modified?'+':''}\                     " filename (+ modified)
set statusline+=%h%r%w\                                    " status flags
set statusline+=%=                                         " right align remainder
set statusline+=\[%{strlen(&ft)?&ft:'none'}]\ \ \          " file type
set statusline+=%-14(%l,%c%V%)                             " line, character
set statusline+=%<%P                                       " file position

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

" Our whitespace plugin highlights it by default. Let's turn this off for now:
autocmd BufRead * highlight ExtraWhitespace ctermbg=bg guibg=bg

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
" Custom commands
" ==================

" Handy for testing new .vimrc changes
function! RunCommands()
    exe getline('.')
endfunction
command -range RunCommands <line1>,<line2>call RunCommands()

" Clear the backup dir
command ClearBackups execute "!rm -rf ~/.vim-tmp/*"


" ==================
" Mappings
" ==================

let mapleader = ","                                        " A way to make command mapping shorter; see <leader> throughout this
imap ;; <Esc>

" Paste linewise after with indent
nnoremap <leader>p :put *<cr>`[v`]=

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
nmap <F3> :set nonumber!<CR>

" toggle wordwrap
nmap <F4> :set nowrap!<CR>

" Goyo
let g:goyo_margin_top=1
let g:goyo_margin_bottom=1
map <F5> :Goyo<CR>

" vimrc Hotkey
map <F6> :tabnew<CR><C-L>:e ~/.vimrc<CR>

nnoremap <leader>b :b<space><Tab>

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

" Command-Shift-F for Ack
nnoremap <D-F> :Ack<space>""<Left>
nnoremap <leader>a :Ack<space>""<Left>
nnoremap <leader>A :Ack<cword><CR>
nnoremap <leader>rw :Ack<space>--type=ruby<space><cword><CR>
vmap <leader>A "ry:Ack<space>"<C-r>r"<CR>

" Scroll the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
