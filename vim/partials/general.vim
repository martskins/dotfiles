syntax on
set binary
set noshowmatch " this doesn't work on OSX, DisableMatchParen achieves the same
set nomodeline
set shortmess+=c
set more
set timeoutlen=1000 ttimeoutlen=0
set encoding=utf-8
set shell=/usr/bin/fish
set number relativenumber
set guifont=monospace
set nobackup
set hidden
set noswapfile
set belloff=all
set signcolumn=yes
set tabstop=2
set shiftwidth=2
set expandtab
set backspace=indent,eol,start
set autoindent
set pastetoggle=<leader>z
set clipboard=unnamed
set ignorecase
set history=100
set hlsearch
set showmatch
set wildmenu
set updatetime=300
set autoread
set ttyfast
set mouse=a
let mapleader = ','
let maplocalleader = "\\"
let g:netrw_silent = 1
let g:ftplugin_sql_omni_key = '<C-j>'
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_node_provider = 0
let g:ruby_host_prog='/home/martin/.gem/ruby/2.7.0/bin/neovim-ruby-host'
let g:python3_host_prog='/usr/bin/python3'
" let g:python2_host_prog='/usr/bin/python'
let netrw_altfile = 1

" match paren is extremely slow on OSX, disable it
function! g:DisableMatchParen ()
    if exists(":NoMatchParen")
        :NoMatchParen
    endif
endfunction

augroup disable_match_paren
    autocmd!
    autocmd VimEnter * call DisableMatchParen()
augroup END

autocmd BufReadPost *.re setlocal filetype=reason
autocmd BufRead,BufNewFile go.mod set filetype=gomod
autocmd BufNewFile,BufRead *.dart setfiletype dart
