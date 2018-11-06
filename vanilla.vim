set nocompatible
filetype plugin on

call plug#begin('~/.vim/plugged')
Plug 'git://github.com/jiangmiao/auto-pairs.git'
Plug 'mileszs/ack.vim'

Plug 'ervandew/supertab'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'

Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-ultisnips'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'ncm2/ncm2-go', { 'for': 'go' }
Plug 'ncm2/ncm2-tern', { 'for': 'javascript' , 'do': 'npm install' }
Plug 'ncm2/ncm2-cssomni', { 'for': 'css' }

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-abolish', { 'commit': '40b8e97' }

Plug 'w0rp/ale'

Plug 'posva/vim-vue'
Plug 'fatih/vim-go'

Plug 'morhetz/gruvbox'
call plug#end()

set syntax=on
set nobk
set number relativenumber
set ignorecase
" set list
" set listchars=tab:>-,trail:~,extends:>,precedes:<
set hidden
set wildmenu
set wrap
set foldmethod=expr foldexpr=getline(v:lnum)=~'^\s*'.&commentstring[0]
set termguicolors

set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set signcolumn=yes

let mapleader=','
let g:SuperTabDefaultCompletionType = "<c-n>"

" CONFIG::VIM-GO
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 0
let g:go_metalinter_autosave_enabled = ['golint']
let g:go_metalinter_deadline = "5s"
let g:go_list_type = "quickfix"
let g:go_def_reuse_buffer = 1
let g:go_addtags_transform = "camelcase"

let g:go_gocode_unimported_packages = 1
let g:go_gocode_propose_source = 0

augroup filetype_go
  autocmd!
  au FileType go     nmap <leader>c <Plug>(go-coverage)
  au FileType go     nmap <leader>ct <Plug>(go-coverage-toggle)
  au FileType go     nmap <Leader>d <Plug>(go-def)
  au FileType go     nmap <leader>rn <Plug>(go-rename)
  au FileType go     nmap <leader>r <Plug>(go-run)
  au FileType go     nmap <leader>b <Plug>(go-build)
  au FileType go     nmap <leader>t <Plug>(go-test)
  au FileType go     nmap <leader>a <Plug>(go-alternate-edit)
  au FileType go     nmap <leader>g <Plug>(go-generate)
  au FileType go     inoremap ;err <ESC>:GoIfErr<CR>O
augroup end


" CONFIG::ALE
let g:ale_fixers = {
      \ 'vue': ['eslint'],
      \ 'javascript': ['eslint']
      \ }

" COLORS
set background=dark
colorscheme gruvbox
hi Search cterm=NONE ctermfg=yellow ctermbg=black guibg=black guifg=orange
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
nmap <leader>o :only<CR>
nmap <leader>bo :BufOnly<CR>
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
