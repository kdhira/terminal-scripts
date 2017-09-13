" Author: Kevin Hira
" Adapted from script by Max Lay
" Taken from https://github.com/kalda341/dotfiles/blob/master/editors/vim/vimrc

syntax on
set nocompatible

set mouse=a

filetype on
filetype plugin on

set backspace=indent,eol,start

set shell=/bin/bash

"Easy ways of getting into normal mode
inoremap kk <ESC>
inoremap jj <ESC>
let mapleader = "\\"

" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!mkdir -p ~/.vim/autoload'
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    :qall
endif

call plug#begin()
"Git plugins
Plug 'mattn/webapi-vim' | Plug 'mattn/gist-vim', { 'on': 'Gist' }
Plug 'tpope/vim-fugitive'
"Nord Theme
Plug 'arcticicestudio/nord-vim'
"Tender Themes
Plug 'jacoborus/tender.vim'
""Autocompletion of quotes, brackets, etc
Plug 'Raimondi/delimitMate'
"File browser
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
"For commenting lines
Plug 'scrooloose/nerdcommenter'
"Autocomplete
Plug 'Valloric/YouCompleteMe'
"Easy file and buffer selection
Plug 'ctrlpvim/ctrlp.vim'
"For dealing with surrounds
Plug 'tpope/vim-surround'
"Need to find time to configure. For . key
Plug 'tpope/vim-repeat'
""Handy plugin for moving through camel case words
"Plug 'camelcasemotion'
"Show errors, marks, etc in margin
"Plug 'quickfixsigns'
"Map , to the last motion
"Plug 'repeat-motion'
"Manage TODOs
"Plug 'TaskList.vim'
"Syntax checker
Plug 'neomake/neomake'
"For easily moving through a file
"Plug 'EasyMotion'
"Integration with tmux windows
Plug 'christoomey/vim-tmux-navigator'
"The silver searcher
Plug 'rking/ag.vim'
"For working with Ctags
Plug 'majutsushi/tagbar'
"For swapping positions of text objects
Plug 'tommcdo/vim-exchange'
"Run tmux commands from vim
Plug 'benmills/vimux'
"Smart find and replace
Plug 'tpope/vim-abolish'
"Traverse the undo/redo tree
Plug 'sjl/gundo.vim'
"Helps with tab alignment
Plug 'godlygeek/tabular'
"ReplaceWithRegister
Plug 'vim-scripts/ReplaceWithRegister'
"Args on own line
Plug 'FooSoft/vim-argwrap'
"Reference docs
Plug 'thinca/vim-ref'
"Line diff symbols
Plug 'airblade/vim-gitgutter'
"Bottom status
Plug 'itchyny/lightline.vim'

"Erlang
Plug 'vim-erlang/vim-erlang-tags', { 'for': 'erlang' }
Plug 'vim-erlang/vim-erlang-compiler', { 'for': 'erlang' }
Plug 'vim-erlang/vim-erlang-omnicomplete', { 'for': 'erlang' }
Plug 'vim-erlang/vim-erlang-runtime', { 'for': 'erlang' }
Plug 'vim-erlang/erlang-motions.vim', { 'for': 'erlang' }
Plug 'vim-erlang/vim-dialyzer', { 'for': 'erlang' }
Plug 'vim-erlang/vim-rebar', { 'for': 'erlang' }

"Text objects
Plug 'kana/vim-textobj-user'
Plug 'b4winckler/vim-angry'
Plug 'wellle/targets.vim'

"Ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

call plug#end()

set history=200

"Indentation and tabs
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set smarttab smartindent
set autoindent
map <Leader>rt :%retab!<CR>
map <Leader>ut :set noexpandtab<CR>
map <Leader>u<space> :set expandtab<CR>

"Indent entire document
map <Leader><C-i> mzgg=G'z

"Reload file if edits happen somewhere else
set autoread

"Statusline stuff
"Display status line always
set laststatus=2
set ruler
set showcmd
set ch=1

"Ignore some file types
set wildmenu                    " Cool cmd completion
set wildignorecase
"%% is directory containing current file
cabbr <expr> %% expand('%:p:h')
set wildignore+=.hg,.git,.svn   " Version control
set wildignore+=*.pyc           " Python byte code
set wildignore+=*.beam           " Erlang byte code
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.class,*.o

"Display whitespace
set showbreak=↪\ 
set listchars=tab:→\ ,trail:·,extends:>,precedes:<,eol:¬,nbsp:·
set list
"Line numbers and limits
set number                      " Show line numbers
set cc=120                       " Ver line in 80 column
set cursorline

"Movement
set scrolloff=10                 " Start scrolling n lines before border
"Scroll wrapped lines normally
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj

"End of line
inoremap <C-e> <C-o>$
"Start of line
inoremap <C-a> <C-o>^

"Search
set hlsearch                    " Highlight searches
set incsearch                   " Highlight dynamically as pattern is typed
set ignorecase                  " Ignore case of searches
nmap <Leader>/ :nohlsearch<CR>

"Allows undo after file is closed
if exists("&undodir")
    set undofile
    set undodir=/tmp
endif
"Swap files and backup are super annoying. I save often
set noswapfile
set nobackup

"Lightline config
let g:lightline = {
    \ 'colorscheme': 'tender',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch' , 'readonly', 'modified' ],
    \             [ 'filepathAbbreviated' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head',
    \   'filepathAbbreviated': 'LightLineFilename'
    \ },
    \ }

let g:lightline.tabline = {
    \ 'left': [ [ 'tabs' ] ],
    \ 'right': [ ] }

let g:lightline.tab = {
    \ 'active': [ 'tabnum', 'filename', 'modified' ],
    \ 'inactive': [ 'filename', 'modified' ] }

"Taken from https://github.com/itchyny/lightline.vim/issues/87
function! LightLineFilename()
  let name = ""
    let subs = split(expand('%'), "/")
    let i = 1
    for s in subs
        let parent = name
        if  i == len(subs)
            if i == 1
                let name = s
            else
                let name = parent . '/' . s
            endif
        elseif i == 1
            let name = s
        else
            let name = parent . '/' . strpart(s, 0, 2)
        endif
        let i += 1
    endfor
  return name
endfunction

"Theme
set noshowmode
"set background=dark
set t_Co=256
colorscheme tender
"colorscheme nord

"Set cursorcolumn
nmap <Leader>scc :set cuc<CR>
nmap <Leader>Scc :set nocuc<CR>

"Buffers
noremap <silent><Leader>bp :bprevious<CR>
noremap <silent><Leader>bn :bnext<CR>
noremap <silent><Leader>bc :bd<CR>

"Tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

"Changlist
noremap <silent><Leader>cp :cprev<CR>
noremap <silent><Leader>cn :cnext<CR>

"Quickfix
noremap <Leader>q :copen<CR>
noremap <Leader>Q :cclose<CR>

"FileTypes
"web
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html,hbs set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType html,htmldjango setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd BufEnter *html map <F11> :setfiletype htmldjango<CR>
autocmd BufEnter *html map <S-F11> :setfiletype django<CR>
"Python
let python_highlight_all = 1
"Fix double indentation
let g:pyindent_open_paren = '&sw'
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python nnoremap <F5> :w<CR>:!python %<CR>
autocmd FileType python setlocal complete-=i
autocmd FileType python setlocal complete-=i
autocmd FileType python setlocal dictionary=~/.vim/dict/python
autocmd FileType python setlocal complete+=k
autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4
"Remove trailing whitespace upon saving python file
autocmd BufWritePre *.py :%s/\s\+$//e

"Make it easier to navigate windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"Vimrc stuff
nmap <silent> <Leader>ev :tabe ~/.vimrc<CR>
nmap <silent> <Leader>sv :so ~/.vimrc<CR>
nmap <silent> <Leader>bi :BundleInstall<CR>

"Newline
map <Leader>o o<Esc>
map <Leader>O O<Esc>

"Copy, paste and cut to system clipboard
map <Leader>y "+y
map <Leader>x "+d
map <Leader>p :set paste<CR>"+p:set nopaste<CR>
map <Leader>P :set paste<CR>"+P:set nopaste<CR>
"Copy to end of line
noremap Y y$

"Repeat motion
let repmo_key=","
let repmo_revkey="\\"

"Use ; as :
nnoremap ; :

"Saving
nmap <Leader>w :w!<cr>
"Sudo write
cmap w!! w !sudo tee % >/dev/null

"cd
map <Leader>cd :cd %:p:h<cr>:pwd<cr>

"Use local config if available
if filereadable("~/.vimrc.local")
    so ~/.vimrc.local
endif

"Highlight trailing whitespace - http://vim.wikia.com/wiki/Highlight_unwanted_spaces
:highlight ExtraWhitespace ctermbg=darkred guibg=darkred
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
map <Leader>rw :s/\s\+$/<CR>

nmap mm :!mvn package<cr>
