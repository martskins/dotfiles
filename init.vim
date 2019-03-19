set nocompatible
filetype off

"{{{ PLUGINS
call plug#begin('~/.vim/plugged')
Plug 'git://github.com/jiangmiao/auto-pairs.git'
Plug 'vim-airline/vim-airline'
Plug 'mileszs/ack.vim'
Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-repeat'
Plug 'ervandew/supertab'
Plug 'ntpeters/vim-better-whitespace'
Plug 'ctrlpvim/ctrlp.vim'

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-neosnippet'

Plug 'mattn/emmet-vim',           { 'for': ['vue', 'html'] }
Plug 'cespare/vim-toml',          { 'for': 'toml' }
Plug 'davidhalter/jedi-vim',      { 'for': 'python' }
Plug 'digitaltoad/vim-pug',       { 'for': ['pug', 'jade'] }
Plug 'posva/vim-vue',             { 'for': 'vue' }
Plug 'vim-ruby/vim-ruby',         { 'for': 'ruby' }
Plug 'fatih/vim-go',              { 'for': 'go', 'do': ':GoInstallBinaries' }
Plug 'rust-lang/rust.vim',        { 'for': 'rust' }
Plug 'Zaptic/elm-vim',            { 'for': 'elm' }
Plug 'leafgarland/typescript-vim',{ 'for': 'typescript' }
Plug 'pangloss/vim-javascript',   { 'for': 'javascript' }
Plug 'dart-lang/dart-vim-plugin', { 'for': 'dart' }
Plug 'thosakwe/vim-flutter',      { 'for': 'dart' }

Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }

Plug 'machakann/vim-highlightedyank'
Plug 'morhetz/gruvbox'
Plug 'sonobre/briofita_vim'
Plug 'tomasiser/vim-code-dark'

call plug#end()
"}}}

filetype plugin indent on

"{{{ GENERAL
syntax enable
let g:ftplugin_sql_omni_key = '<C-j>'
set encoding=utf-8
" let $NVIM_PYTHON_LOG_FILE="/tmp/nvim_log"
set shell=/bin/zsh
set cmdheight=2
set number relativenumber
set hid
set colorcolumn=100
set signcolumn=no
set guifont=monospace
set termguicolors
set t_Co=256
set synmaxcol=128
set nobk
set textwidth=100
set lazyredraw
set wildoptions=pum
set pumblend=20
set background=dark
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
colorscheme codedark
set tabstop=2
set shiftwidth=2
set expandtab
set backspace=indent,eol,start
set autoindent
set wrap
set pastetoggle=<leader>z
set clipboard=unnamed
set showtabline=2
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
augroup folding
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType ruby,eruby
        \ set foldmethod=expr |
        \ set foldexpr=getline(v:lnum)=~'^\\s*#' |
        \ exe "normal zM``"
  autocmd FileType groovy,java,scala,javascript,go,rust
        \ set foldmethod=expr |
        \ set foldexpr=getline(v:lnum)=~'^\\s*//' |
        \ exe "normal zM``"
augroup end


augroup netrw_buf_hidden_fix
  autocmd!
  set nohidden
  autocmd BufWinEnter *
        \  if &ft != 'netrw'
        \|     set bufhidden=hide
        \| endif
augroup end
"}}}

" {{{ SUPERTAB
let g:SuperTabDefaultCompletionType = "<c-n>"
" }}}

" {{{ ACK
let g:ack_use_dispatch = 1
" }}}

" {{{ CTRLP
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|\.git\|target\|web-app'
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

" {{{ NCM2
  autocmd BufEnter * call ncm2#enable_for_buffer()
  set completeopt=noinsert,menuone,noselect
" }}}

" {{{ VIM-GO
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

augroup filetype_go
  autocmd!
  au FileType go     nmap <leader>c <Plug>(go-coverage)
  au FileType go     nmap <leader>ct <Plug>(go-coverage-toggle)
  au FileType go     nmap <Leader>d <Plug>(go-def)
  au FileType go     nmap <leader>b <Plug>(go-build)
  au FileType go     nmap <leader>t <Plug>(go-test)
  au FileType go     nmap <leader>a <Plug>(go-alternate-edit)
  au FileType go     nmap <leader>g <Plug>(go-generate)
  au FileType go     inoremap ;err <ESC>:GoIfErr<CR>O
augroup end
"}}}

" {{{ JEDI
let g:jedi#show_call_signatures=0
let g:jedi#popup_on_dot=0
" }}}

" {{{ RUBY
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
"}}}

" {{{ RUST
let g:rustfmt_autosave = 0
augroup filetype_rust
  autocmd!
  au FileType rust let g:AutoPairs = {'(':')', '[':']', '{':'}','"':'"', '`':'`', '<':'>'}
  aut FileType rust nmap <leader>d :!surf "https://doc.rust-lang.org/std/?search="&<Left><Left>
augroup end
"}}}

" {{{ ALE
let g:ale_fixers = {
      \ 'javascript': ['eslint'],
      \ 'dart': ['dartfmt'],
      \ 'python': ['autopep8', 'isort'],
      \ 'cpp': ['clang-format'],
      \ 'c': ['uncrustify'],
      \ 'rust': ['rustfmt'],
      \ 'ruby': ['rubocop'],
      \ 'nim': ['nimpretty'],
      \ 'vue': [],
      \ '*': ['trim_whitespace']
      \}
let g:ale_fix_on_save = 1
let g:ale_lint_on_enter = 1
let g:ale_emit_conflict_warnings = 1
let g:airline#extensions#ale#enabled = 1
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
  set completeopt-=preview
  let g:LanguageClient_diagnosticsList = 'disabled'
  let g:LanguageClient_useVirtualText = 1
  let g:LanguageClient_serverCommands = {
      \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
      \ 'go': ['bingo', '--logfile', '/home/martin/Desktop/binlog.txt', '--trace'],
      \ 'vue': ['vls'],
      \ 'javascript': ['javascript-typescript-stdio'],
      \ 'typescript': ['javascript-typescript-stdio'],
      \ 'javascript.jsx': ['javascript-typescript-stdio'],
      \ 'python': ['/usr/local/bin/pyls'],
      \ 'dart': ['/home/martin/.pub-cache/bin/dart_language_server'],
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
nnoremap Q @q
nnoremap 0 ^
nnoremap ^ 0
nnoremap Q :norm @q<cr>
nmap <leader>o :only<CR>
nmap <leader>bd :bdelete<CR>
nmap <leader>bq :bdelete!<CR>
nmap <leader>ba :bufdo bd<CR>
nmap <leader>bo :BufOnly<CR>
nmap <leader>ls :ls<CR>
nmap <leader>f :ALEFix<CR>
nmap <leader>lg :term lazygit<CR>i
nmap <leader>S :,$s/\<<C-r><C-w>\>//gc<Left><Left><Left>
nmap <leader>s :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
nmap <leader>w :!surf "duckduckgo.com?q="&<Left><Left>
nmap <leader>tab :Tabularize /\|<CR>
nmap <leader>pj :norm 0v$,json<CR>
nmap <leader>. :TagbarToggle<CR>
nmap <leader>e :!
nmap <leader>be :!<UP><CR>
nmap <leader>x :%!xxd<CR>
nmap <F8> :TagbarToggle<CR>
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
