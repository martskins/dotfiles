set nocompatible
filetype plugin on

call plug#begin('~/.vim/plugged')
Plug 'git://github.com/jiangmiao/auto-pairs.git'
Plug 'mileszs/ack.vim'

Plug 'ervandew/supertab'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-vinegar'

Plug 'w0rp/ale'

Plug 'posva/vim-vue'

Plug 'morhetz/gruvbox'
call plug#end()

set syntax=on
set nobk
set number relativenumber
set ignorecase
set list
set listchars=tab:>-,trail:~,extends:>,precedes:<
set hidden
set wildmenu
set wrap
set foldmethod=expr foldexpr=getline(v:lnum)=~'^\s*'.&commentstring[0]

set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent

let mapleader=','
let g:SuperTabDefaultCompletionType = "<c-n>"

" CONFIG::ALE
let g:ale_fixers = {
      \ 'vue': ['eslint'],
      \ 'javascript': ['eslint']
      \ }

" COLORS
set background=dark
colorscheme gruvbox
hi Search cterm=NONE ctermfg=black ctermbg=blue guibg=peru guifg=black
hi Comment ctermbg=NONE ctermfg=darkgrey
hi Folded ctermbg=NONE ctermfg=darkgrey

" MAPPINGS
nmap <leader>lg :term lazygit<CR>i
nmap <leader>p :e **/**<left>
nmap <c-p> :Files<CR>
nmap <space><space> :e#<CR>
nmap <leader>ls :ls<CR>:b
nmap <leader>bd :bd<CR>
nmap <leader>ba :bufdo bd<CR>
nmap <tab> :bnext<CR>
nmap <s-tab> :bprev<CR>
nmap <c-v><c-v> 0<c-v>G$
nnoremap 0 ^
nnoremap ^ 0
nmap gev :e ~/.config/nvim/vanilla.vim<CR>
nmap gsv :so ~/.config/nvim/vanilla.vim<CR>
nmap <silent> <F3> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
" MAPPINGS::ALE
nmap <leader>f :ALEFix<CR>

command! W w
command! Q q
command! WQ wq
command! Wq wq
