set nocompatible
filetype off

"{{{ PLUGINS
call plug#begin('~/.vim/plugged')
Plug 'git://github.com/jiangmiao/auto-pairs.git'
Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-vinegar'      "better netrw
Plug 'tpope/vim-abolish'      "toggle casing (snake or camel) with crs and crc
Plug 'tpope/vim-fugitive'     "git commands
Plug 'tpope/vim-dispatch'     "provides :Make and :Start
Plug 'tpope/vim-surround'     "provides mappings to surround stuff with stuff
Plug 'tpope/vim-commentary'   "mappings to comment/uncomment blocks of code
Plug 'tpope/vim-sleuth'       "automagically adjusts tab width
Plug 'tpope/vim-repeat'       "enables repeating commands from plugins
Plug 'ervandew/supertab'
Plug 'ntpeters/vim-better-whitespace'
Plug 'schickling/vim-bufonly'
Plug 'majutsushi/tagbar'
Plug 'machakann/vim-highlightedyank'
Plug 'flazz/vim-colorschemes'

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'ncm2/ncm2'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-neosnippet'
Plug 'majutsushi/tagbar'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }

Plug 'mattn/emmet-vim',           { 'for': ['vue', 'html'] }
Plug 'cespare/vim-toml',          { 'for': 'toml' }
Plug 'davidhalter/jedi-vim',      { 'for': 'python' }
Plug 'digitaltoad/vim-pug',       { 'for': ['pug', 'jade'] }
Plug 'posva/vim-vue',             { 'for': 'vue' }
Plug 'fatih/vim-go',              { 'for': 'go' }
Plug 'rust-lang/rust.vim',        { 'for': 'rust' }
Plug 'leafgarland/typescript-vim',{ 'for': 'typescript' }
Plug 'pangloss/vim-javascript',   { 'for': 'javascript' }
Plug 'dart-lang/dart-vim-plugin', { 'for': 'dart' }


call plug#end()
"}}}

filetype plugin indent on

"{{{ GENERAL
syntax enable
let g:ftplugin_sql_omni_key = '<C-j>'
set encoding=utf-8
set shell=/usr/bin/fish
set cmdheight=2
set number relativenumber
set hid
set colorcolumn=100
set guifont=monospace
set synmaxcol=128
set nobk
set textwidth=100
set noswapfile
if (has("nvim"))
  set wildoptions=pum
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
set lazyredraw
set termguicolors
set t_Co=256
set background=dark
colorscheme badwolf

set signcolumn=yes
set tabstop=2
set shiftwidth=2
set expandtab
set backspace=indent,eol,start
set autoindent
set wrap
set pastetoggle=<leader>z
set clipboard=unnamed
" set showtabline=2
set ignorecase
set history=100
set hlsearch
set showmatch
set wildmenu
set updatetime=100
set autoread
set ttyfast
set t_ut=
set mouse=a
let mapleader = ','

let g:netrw_list_hide= '.*\.swp$,.DS_Store,*/tmp/*,*.so,*.swp,*.swo,*.zip,*.git,^\.\.\=/\=$'
let g:python_host_prog="/usr/bin/python2.7"
let g:python3_host_prog="/usr/bin/python3"

set fdm=expr
set fde=getline(v:lnum)=~‘^\\s\/\/‘?1:getline(prevnonblank(v:lnum))=~‘^\\s\/\/‘?1:getline(nextnonblank(v:lnum))=~‘^\\s*\/\/’?1:0
set foldmethod=expr |
        \ set foldexpr=getline(v:lnum)=~'^\\s*//' |
        \ exe "normal zM``"

augroup netrw_buf_hidden_fix
  autocmd!
  set nohidden
  autocmd BufWinEnter *
        \  if &ft != 'netrw'
        \|     set bufhidden=hide
        \| endif
augroup end
"}}}

" {{{ FUGITIVE
set diffopt+=vertical
" }}}

" {{{ SUPERTAB
let g:SuperTabDefaultCompletionType = "<c-n>"
" }}}

" {{{ FZF
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
nmap <leader><tab> <plug>(fzf-maps-n)

command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".<q-args>, <bang>0)
" }}}

" {{{ ULTISNIPS
let g:UltiSnipsExpandTrigger="<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" }}}

" {{{ BETTER WHITESPACE
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
" }}}

" {{{ AIRLINE
let g:airline#extensions#tabline#enabled = 1
" }}}

"{{{ NCM2
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
"}}}

" {{{ ALE
let g:ale_fixers = {
      \ 'javascript': ['eslint'],
      \ 'dart': ['dartfmt'],
      \ 'python': ['autopep8', 'isort'],
      \ 'cpp': ['clang-format'],
      \ 'css': ['prettier'],
      \ 'ruby': ['rubocop'],
      \ 'c': ['uncrustify'],
      \ 'rust': ['rustfmt'],
      \ 'nim': ['nimpretty'],
      \ 'vue': [],
      \ '*': ['trim_whitespace']
      \}
let g:ale_fix_on_save = 1
let g:ale_lint_on_enter = 1
let g:ale_emit_conflict_warnings = 1
let g:ale_go_gometalinter_options = '--fast'
let g:ale_linters = {
      \ 'rust': ['cargo'],
      \ 'javascript': ['eslint'],
      \ 'typescript': ['tslint'],
      \ 'vue': ['tslint', 'vls'],
      \ 'go': ['vet', 'golint', 'errcheck'],
      \ 'python': ['flake8'],
      \ 'cpp': ['clang']
      \}
"}}}

" {{{ LSP
  set omnifunc=syntaxcomplete#Complete
  let g:LanguageClient_loggingFile = '/home/martin.asquino/Desktop/lsp.log'
  let g:LanguageClient_useFloatingHover = 1
  let g:LanguageClient_hoverPreview = 'Always'
  let g:LanguageClient_diagnosticsList = 'disabled'
  let g:LanguageClient_useVirtualText = 0
  let g:LanguageClient_serverCommands = {
      \ 'ruby': ['solargraph', 'stdio'],
      \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
      \ 'go': ['bingo'],
      \ 'vue': ['vls'],
      \ 'javascript': ['javascript-typescript-stdio'],
      \ 'typescript': ['javascript-typescript-stdio'],
      \ 'javascript.jsx': ['javascript-typescript-stdio'],
      \ 'python': ['/usr/local/bin/pyls'],
      \ 'dart': ['dart_language_server'],
      \ }

  nnoremap <F5> :call LanguageClient_contextMenu()<CR>
  nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
  nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
  nnoremap <silent> gi :call LanguageClient#textDocument_implementation()<CR>
  nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
  nnoremap <silent> R :call LanguageClient#textDocument_rename()<CR>
"}}}

" {{{ NEOSNIPPET
  let g:neosnippet#enable_snipmate_compatibility = 1

  imap <C-k>     <Plug>(neosnippet_expand_or_jump)
  smap <C-k>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>     <Plug>(neosnippet_expand_target)

  imap <expr><TAB>
   \ pumvisible() ? "\<C-n>" :
   \ neosnippet#expandable_or_jumpable() ?
   \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

  if has('conceal')
    set conceallevel=0 concealcursor=niv
  endif
" }}}

" {{{ MAPPINGS
nnoremap <silent> <F3> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
command! WQ wq
command! Wq wq
command! W w
command! Q q
nnoremap <S-F5> ggvG=
nmap <tab> :bnext<CR>
nmap <s-tab> :bprevious<CR>
nmap <c-p> :Files<CR>
nmap <c-f> :Rg<space>
nnoremap Q @q
nnoremap 0 ^
nnoremap ^ 0
nnoremap Q :norm @q<cr>
nmap <leader>o :only<CR>
nmap <leader>bd :bdelete<CR>
nmap <leader>bq :bdelete!<CR>
nmap <leader>ba :bufdo bd<CR>
nmap <leader>bo :BufOnly<CR>
nmap <leader>f :ALEFix<CR>
nmap <leader>S :,$s/\<<C-r><C-w>\>//gc<Left><Left><Left>
nmap <leader>s :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
nmap <leader>w :!surf "duckduckgo.com?q="&<Left><Left>
nmap <leader>pj :norm 0v$,json<CR>
nmap <leader>e :!
nmap <leader>be :!<UP><CR>
nmap <leader>x :%!xxd<CR>
nmap <C-v><C-v> gg<C-V>G$
noremap <Left> <NOP>
noremap <Right> <NOP>
nmap <Down> :cnext<cr>
nmap <Up> :cprevious<cr>
nmap <space> ,
nmap <space><space> :e#<cr>
nnoremap gev :e $MYVIMRC<CR>
nnoremap gsv :so $MYVIMRC<CR>
nnoremap <LeftMouse> <NOP>
inoremap <LeftMouse> <NOP>
nmap <c-s><c-v> :vsplit<CR>
nmap <c-s><c-h> :split<CR>
nmap ,. :TagbarToggle<CR>
nnoremap <leader>ls :buffers<CR>:buffer<Space>

vmap <C-c> <ESC>
vnoremap <leader>pj :!python -m json.tool<CR>

if has('nvim')
  tnoremap <leader>bd :bd!<CR>
endif

augroup qf
   autocmd!
   autocmd FileType qf set nobuflisted
augroup END
"}}}

function! ProfileStart()
  :profile start profile.log
  :profile func *
  :profile file *
endfunction

function! ProfileEnd()
  :profile pause
  :noautocmd qall!
endfunction
