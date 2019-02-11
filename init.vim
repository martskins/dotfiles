set nocompatible
filetype off

"{{{ PLUGINS
call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'git://github.com/jiangmiao/auto-pairs.git'
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
Plug 'mattn/emmet-vim'
Plug 'ervandew/supertab'
Plug 'ntpeters/vim-better-whitespace'
Plug 'chriskempson/base16-vim'
Plug 'cespare/vim-toml'

Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-ultisnips'
Plug 'roxma/nvim-yarp'

Plug 'davidhalter/jedi-vim',      { 'for': 'python' }
Plug 'digitaltoad/vim-pug',       { 'for': ['pug', 'jade'] }
Plug 'posva/vim-vue',             { 'for': 'vue' }
Plug 'vim-ruby/vim-ruby',         { 'for': 'ruby' }
Plug 'fatih/vim-go',              { 'for': 'go', 'do': ':GoInstallBinaries' }
Plug 'rust-lang/rust.vim',        { 'for': 'rust' }
Plug 'leafgarland/typescript-vim',{ 'for': 'typescript' }
Plug 'Zaptic/elm-vim',           { 'for': 'elm' }
Plug 'jalvesaq/Nvim-R'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'

Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags', { 'for': 'cpp' }
Plug 'ctrlpvim/ctrlp.vim'

Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': './install.sh' }
Plug 'dbakker/vim-projectroot'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'machakann/vim-highlightedyank'
Plug 'morhetz/gruvbox'

call plug#end()
"}}}

filetype plugin indent on

"{{{ CONFIG
syntax off
syntax enable
let g:ftplugin_sql_omni_key = '<C-j>'
set encoding=utf-8
let $NVIM_PYTHON_LOG_FILE="/tmp/nvim_log"

" shell
set shell=/bin/zsh
set cmdheight=2

" visuals
set number relativenumber
set hid
set colorcolumn=100
set cursorline
set signcolumn=yes
set guifont=Monaco
set termguicolors
set synmaxcol=100
set nobk
set textwidth=80
set lazyredraw

" colors
set background=dark
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
colorscheme gruvbox

" indentation
set tabstop=2
set shiftwidth=2
set expandtab
set backspace=indent,eol,start
set autoindent
set wrap

" pasting
set pastetoggle=<leader>z
set clipboard=unnamed

" search
set ignorecase
set history=100
set hlsearch
set showmatch
set wildmenu
nnoremap <silent> <F3> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

" behavior
set autoread
set ttyfast
set t_ut=
set mouse=a
let mapleader = ','
let g:netrw_list_hide= '.*\.swp$,.DS_Store,*/tmp/*,*.so,*.swp,*.swo,*.zip,*.git,^\.\.\=/\=$'

" folding
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

if has("mac")
  let g:python_host_prog="/usr/local/bin/python"
  let g:python3_host_prog="/usr/local/bin/python3"
else
  let g:python_host_prog="/usr/bin/python"
    let g:python3_host_prog="/usr/bin/python3"
endif

augroup netrw_buf_hidden_fix
  autocmd!
  set nohidden
  autocmd BufWinEnter *
        \  if &ft != 'netrw'
        \|     set bufhidden=hide
        \| endif
augroup end

" supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" ctags
let g:auto_ctags = 1

" ncm2
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

"lightline
let g:lightline#bufferline#show_number  = 1
let g:lightline#bufferline#shorten_path = 1
let g:lightline#bufferline#unnamed      = '[No Name]'

let g:lightline                  = {}
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

set showtabline=2

" ack
let g:ack_use_dispatch = 1

" ctrlp
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|\.git\|target\|web-app'

" ale
let g:ale_fixers = {
      \ 'javascript': ['eslint'],
      \ 'python': ['autopep8', 'isort'],
      \ 'cpp': ['clang-format'],
      \ 'rust': ['rustfmt'],
      \ 'ruby': ['rubocop'],
      \ 'nim': ['nimpretty'],
      \ 'vue': ['eslint'],
      \ '*': ['trim_whitespace']
      \}
let g:ale_fix_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_emit_conflict_warnings = 1
let g:ale_go_gometalinter_options = '--fast'
      " \ 'rust': ['cargo'],
let g:ale_linters = {
      \ 'javascript': ['eslint'],
      \ 'go': ['gometalinter'],
      \ 'python': ['flake8'],
      \ 'cpp': ['clang']
      \}

" better-whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

" jedi
let g:jedi#show_call_signatures=0
let g:jedi#popup_on_dot=0
"}}}

"{{{ LANGUAGE-SPECIFIC

" ruby
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete

" go
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
  au FileType go     nmap R <Plug>(go-rename)
  au FileType go     nmap <leader>b <Plug>(go-build)
  au FileType go     nmap <leader>t <Plug>(go-test)
  au FileType go     nmap <leader>a <Plug>(go-alternate-edit)
  au FileType go     nmap <leader>g <Plug>(go-generate)
  au FileType go     inoremap ;err <ESC>:GoIfErr<CR>O
  " au FileType go     inoremap :err <ESC>:GoIfErr<CR>O
augroup end

" cpp
augroup filetype_c
  autocmd!
  autocmd FileType c,cpp    nmap <leader>b :!make build<CR>
augroup end

" rust
let g:rustfmt_autosave = 0
augroup filetype_rust
  autocmd!
  au FileType rust let g:AutoPairs = {'(':')', '[':']', '{':'}','"':'"', '`':'`'}
augroup end
"}}}

"{{{ MAPPINGS
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
nmap <leader>s :%s/\<<C-r><C-w>\>//gc<Left><Left>
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

" ultisnips
let g:UltiSnipsExpandTrigger="<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent> <expr> <CR> pumvisible() ? ncm2_ultisnips#expand_or("\<CR>", 'n') : "\<CR>"
"}}}

"{{{ LSP
nnoremap <leader>lcs :LanguageClientStart<CR>
let g:LanguageClient_diagnosticsList = 'Disabled'
let g:LanguageClient_loadSettings = 0
let g:LanguageClient_loggingFile = "/home/martin.asquino/Desktop/languageclient-neovim.log"
let g:LanguageClient_autoStart = 1
let g:LanguageClient_selectionUI = "fzf"
let g:LanguageClient_hasClientSupport = 0

      " \ 'go': ['golsp', '-mode', 'stdio'],
let g:LanguageClient_serverCommands = {
      \ 'rust': ['rustup', 'run', 'stable', 'rls'],
      \ 'cpp': ['cquery', '--init={"cacheDirectory":"/tmp/cquery/", "std": "c++14"}'],
      \ 'ruby': ['solargraph', 'stdio'],
      \ 'nim': ['/home/martin.asquino/Projects/nimlsp/nimlsp'],
      \ 'go': ['bingo'],
      \ 'javascript': ['tcp://127.0.0.1:61606']
      \ }

augroup lsp_langs
  autocmd!
  au FileType ruby,nim,rust,c,cpp nnoremap            <F5> :call LanguageClient_contextMenu()<CR>
  au FileType ruby,nim,rust,c,cpp nnoremap  <silent>  K :call LanguageClient#textDocument_hover()<CR>
  au FileType ruby,nim,rust,c,cpp nnoremap  <silent>  gd :call LanguageClient#textDocument_definition()<CR>zz
  au FileType ruby,nim,rust,c,cpp noremap   <silent>  H :call LanguageClient_textDocument_hover()<CR>
  au FileType ruby,nim,rust,c,cpp noremap   <silent>  Z :call LanguageClient_textDocument_definition()<CR>
  au FileType ruby,nim,rust,c,cpp noremap   <silent>  R :call LanguageClient_textDocument_rename()<CR>
  au FileType ruby,nim,rust,c,cpp nmap      <silent>  <leader>d :call LanguageClient_textDocument_definition()<CR>
augroup end

augroup ctags
  autocmd!
  au FileType elm nnoremap gd <C-]>
augroup end

"}}}

" {{{ NEGATE
function! Negate()
  let s:list = {
        \'false':'true', 'true':'false', 'False': 'True', 'True': 'False',
        \'0': '1', '1': '0', '==':'!=', '!=':'==', '>': '<', '<': '>', '&&': '||', '||': '&&'
        \}
  let s:keys = keys(s:list)
  if index(s:keys, expand("<cword>")) == -1
    call search(join(s:keys, '\|'), 'e', line('.'))
  endif

  let s:current_word = expand("<cword>")
  echo s:current_word
  let s:new_word = get(s:list, s:current_word)
  if s:new_word == "0"
    return
  endif
  echo s:current_word
  execute ":s/".s:current_word."/".s:new_word."/"
endfunction
command! Negate :call Negate()
nmap !! :Negate<CR>
" }}}

function! ProfileStart()
  :profile start profile.log
  :profile func *
  :profile file *
endfunction

function! ProfileEnd()
  :profile pause
  :noautocmd qall!
endfunction
