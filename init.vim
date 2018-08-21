set nocompatible
filetype off

"{{{ PLUGINS
call plug#begin('~/.vim/plugged')
"{{{ GENERIC
Plug 'VundleVim/Vundle.vim'
Plug 'vim-scripts/VisIncr'
Plug 'vim-airline/vim-airline'
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
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
Plug 'mattn/emmet-vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'digitaltoad/vim-pug'
Plug 'junegunn/vim-github-dashboard'
Plug 'ashisha/image.vim'
Plug 'lkdjiin/vim-foldcomments'
Plug 'ervandew/supertab'
Plug 'majutsushi/tagbar'
Plug 'christoomey/vim-tmux-navigator'
Plug 'godlygeek/tabular'

if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
"}}}
"{{{ PYTHON
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
"}}}
"{{{ RUBY
"Plug 'hackhowtofaq/vim-solargraph'
"}}}
"{{{ GO
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' , 'for': 'go' }
Plug 'zchee/deoplete-go', { 'for': 'go' }
"}}}
"{{{ RUST
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
"}}}
"{{{ GRAILS
Plug 'vim-scripts/grails-vim'
Plug 'sjurgemeyer/vimport'
Plug 'thecodesmith/vim-groovy', { 'for': 'groovy' }
"}}}
"{{{ KOTLIN
Plug 'udalov/kotlin-vim', { 'for': 'kotlin' }
"}}}
" {{{ HASKELL
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
Plug 'parsonsmatt/intero-neovim', { 'for': 'haskell' }
Plug 'neomake/neomake', { 'for': 'haskell' }
" }}}
" {{{ JAVASCRIPT
Plug 'posva/vim-vue', { 'for': 'vue' }
" }}}
"{{{ LSP
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': './install.sh' }
Plug 'dbakker/vim-projectroot'
"}}}
"{{{ NEOSNIPPET
Plug 'Shougo/neosnippet.vim', { 'for': 'go' }
Plug 'Shougo/neosnippet-snippets', { 'for': 'go' }
"}}}
"{{{ COLORSCHEMES
Plug 'hzchirs/vim-material'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline-themes'
Plug 'ayu-theme/ayu-vim'
Plug 'sickill/vim-monokai'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'olivertaylor/vacme'
"}}}
call plug#end()
"}}}
filetype plugin indent on
"{{{ MISC
syntax on
syntax enable

autocmd FileType vim setlocal foldmethod=marker
set shell=/bin/zsh
set hid
set ignorecase
set number relativenumber
set backspace=indent,eol,start
set pastetoggle=<leader>z
set tabstop=2
set shiftwidth=2
set cmdheight=2
set expandtab
set clipboard=unnamed
set colorcolumn=150
set hidden
set history=100
set hlsearch
set showmatch
set signcolumn=yes
set guifont=Monaco
set termguicolors
set autoread          "autoload file changes
set autoindent        "copy indentation from last line on <CR>
set ttyfast
set t_ut=
let mapleader = ','
set noruler
set synmaxcol=150
set cursorcolumn
set cursorline

hi LineNr ctermfg=red
hi LineNr guifg=#050505
set background=dark
"colorscheme vim-material
colorscheme gruvbox
"colorscheme peachpuff

set fdm=expr
set fde=getline(v:lnum)=~‘^\\s\/\/‘?1:getline(prevnonblank(v:lnum))=~‘^\\s\/\/‘?1:getline(nextnonblank(v:lnum))=~‘^\\s*\/\/’?1:0

if has("mac")
    let g:python_host_prog="/usr/local/bin/python"
    let g:python3_host_prog="/usr/local/bin/python3"
else
    let g:python_host_prog="/home/linuxbrew/.linuxbrew/bin/python"
    let g:python3_host_prog="/home/linuxbrew/.linuxbrew/bin/python3.7"
endif

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<F3>', 'n') ==# ''
    nnoremap <silent> <F3> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

function! GrepQuickFix(pat)
    let all = getqflist()
    for d in all
        if bufname(d['bufnr']) !~ a:pat && d['text'] !~ a:pat
            call remove(all, index(all,d))
        endif
    endfor
    call setqflist(all)
endfunction
command! -nargs=* GrepQF call GrepQuickFix(<q-args>)

autocmd FileType ruby,eruby
            \ set foldmethod=expr |
            \ set foldexpr=getline(v:lnum)=~'^\\s*#' |
            \ exe "normal zM``"

autocmd FileType groovy,java,scala,javascript,go
            \ set foldmethod=expr |
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

" ==== NECO-GHC
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
" ==== TAGBAR
let g:tagbar_autofocus = 1
" ==== SUPERTAB
let g:SuperTabDefaultCompletionType = "<c-n>"
" ==== DEOPLETE
let g:deoplete#enable_at_startup = 1
set completeopt-=preview
" ==== ACK
let g:ack_use_dispatch = 1
" ==== CTRLP
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|\.git\|target\|web-app'
" ==== AIRLINE
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" ==== ALE
let g:ale_fixers = { 'javascript': ['eslint'], 'haskell': ['brittany'], 'python': ['autopep8', 'isort']}
let g:ale_fix_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_emit_conflict_warnings = 0
let g:ale_linters = { 'javascript': ['eslint'], 'go': ['gometalinter'], 'rust': ['cargo'], 'haskell': ['hlint', 'ghc-mod'], 'python': ['flake8']}
"}}}
"{{{ LANGUAGE-SPECIFIC
"{{{ JAVA
let g:JavaImpPaths = $HOME . "/Projects/billing"
let g:JavaImpDataDir = $HOME . "/vim/JavaImp"

function! Patch()
    execute "e application.properties | g/app\.version"
    execute ":normal $"
    execute ":normal \<C-a>"
    execute ":w"
    execute ":bd"
endfunction
command! Patch :call Patch()

function! Minor()
    execute "e application.properties | g/app\.version"
    execute ":normal $"
    execute ":normal cw0"
    execute ":normal $bb"
    execute ":normal \<C-a>"
    execute ":w"
    execute ":bd"
endfunction
command! Minor :call Minor()

au FileType groovy syn region groovyComment start="@PropertyHelp" end=")"
"}}}
"{{{ GO
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

augroup filetype_go
    autocmd!

    "VIM-GO
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

    "NEOSNIPPET CONFIG
    au FileType go      imap <C-k> <Plug>(neosnippet_expand_or_jump)
    au FileType go      smap <C-k> <Plug>(neosnippet_expand_or_jump)
    au FileType go      xmap <C-k> <Plug>(neosnippet_expand_target)<c-w><c-w>
    au FileType go      set conceallevel=2 concealcursor=niv
augroup END
"}}}
"{{{ CPP
augroup filetype_c
    autocmd!
    autocmd FileType c,cpp,objc    nmap <leader>b :!make build<CR>
    autocmd FileType c,cpp,objc    nmap <leader>r :!make build && ./a.out<CR>
augroup END
"}}}
"{{{ RUST
let g:rustfmt_autosave = 1

augroup filetype_rust
    autocmd!
    au FileType rust nmap <leader>r :!cargo run<CR>

    "AUTO-PAIRS
    au FileType rust let g:AutoPairs = {'(':')', '[':']', '{':'}','"':'"', '`':'`'}
augroup END
"}}}
"}}}
"{{{ MAPPINGS
nmap <c-p> :Files<CR>
nmap <leader>o :only<CR>
nnoremap <S-F5> ggvG=
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
nmap <tab> :bnext<CR>
nmap <s-tab> :bprevious<CR>
nnoremap Q @q
nnoremap Q :norm @q<cr>
nmap <leader>bd :bdelete<CR>
nmap <leader>bq :bdelete!<CR>
nmap <leader>bo :BufOnly<CR>
nmap <Down> :cnext<cr>
nmap <Up> :cprevious<cr>

nmap <leader>lg :term lazygit<CR>i
nmap <F8> :TagbarToggle<CR>
nmap <leader>. :TagbarToggle<CR>

if has('nvim')
    tnoremap <leader>bd :bd!<CR>
endif

function! UncommitedChanges()
    let files=split(system("git diff --name-only"), '\n')
    for f in files
        execute ":e " . f
    endfor
endfunction
command! UncommitedChanges :call UncommitedChanges()
"}}}
"{{{ LSP
nnoremap <leader>lcs :LanguageClientStart<CR>

let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
            \ 'rust': ['rustup', 'run', 'stable', 'rls'],
            \ 'cpp' : ['clangd'],
            \ 'javascript': ['flow-language-server', '--stdio'],
            \ 'groovy': ['tcp://127.0.0.1:8888'],
            \ 'kotlin': ['tcp://127.0.0.1:8888'],
            \ 'scala': ['tcp://127.0.0.1:8888'],
            \ 'java': ['tcp://127.0.0.1:8888'] 
            \ }

augroup lsp_langs
    autocmd!
    au FileType groovy,scala,java,kotlin,rust,c,cpp nnoremap <F5> :call LanguageClient_contextMenu()<CR>
    au FileType groovy,scala,java,kotlin,rust,c,cpp nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
    au FileType groovy,scala,java,kotlin,rust,c,cpp nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>zz
    au FileType groovy,scala,java,kotlin,rust,c,cpp nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
    au FileType groovy,scala,java,kotlin,rust,c,cpp noremap <silent> H :call LanguageClient_textDocument_hover()<CR>
    au FileType groovy,scala,java,kotlin,rust,c,cpp noremap <silent> Z :call LanguageClient_textDocument_definition()<CR>
    au FileType groovy,scala,java,kotlin,rust,c,cpp noremap <silent> R :call LanguageClient_textDocument_rename()<CR>
    au FileType groovy,scala,java,kotlin,rust,c,cpp noremap <silent> S :call LanugageClient_textDocument_documentSymbol()<CR>
    au FileType groovy,scala,java,kotlin,rust,c,cpp nmap <leader>rn :call LanguageClient_textDocument_rename()<CR>
    au FileType groovy,scala,java,kotlin,rust,c,cpp nmap <silent> <leader>d :call LanguageClient_textDocument_definition()<CR>
    au User lsp_setup call lsp#register_server({
            \ 'name': 'intelli-lsp-server',
            \ 'cmd': {server_info->['tcp://127.0.0.1:8888']},
            \ 'whitelist': ['groovy', 'java', 'kotlin', 'scala']
            \ })
augroup END

if executable('clangd')
    augroup lsp_clangd
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'clangd',
                    \ 'cmd': {server_info->['clangd']},
                    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp']
                    \ })
        autocmd FileType c,cpp,objc,objcpp setlocal omnifunc=lsp#complete
    augroup end
endif

let g:LanguageClient_rootMarkers = {
            \ 'grooy': ['.idea'],
            \ 'scala': ['.idea'],
            \ 'java': ['.idea'],
            \ 'kotlin': ['.idea'],
            \  }
"}}}
"{{{ CTAGS
let g:tagbar_type_groovy = {
    \ 'ctagstype' : 'groovy',
    \ 'kinds'     : [
        \ 'p:package:1',
        \ 'c:classes',
        \ 'i:interfaces',
        \ 't:traits',
        \ 'e:enums',
        \ 'm:methods',
        \ 'f:fields:1'
    \ ]
\ }

let g:tagbar_type_typescript = {
  \ 'ctagstype': 'typescript',
  \ 'kinds': [
    \ 'c:classes',
    \ 'n:modules',
    \ 'f:functions',
    \ 'v:variables',
    \ 'v:varlambdas',
    \ 'm:members',
    \ 'i:interfaces',
    \ 'e:enums',
  \ ]
\ }

let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type'
    \ },
    \ 'scope2kind' : {
        \ 'module' : 'm',
        \ 'class'  : 'c',
        \ 'data'   : 'd',
        \ 'type'   : 't'
    \ }
\ }
"}}}
" {{{ INTERO
augroup interoMaps
  au!
  " Maps for intero. Restrict to Haskell buffers so the bindings don't collide.

  " Background process and window management
  au FileType haskell nnoremap <silent> <leader>is :InteroStart<CR>
  au FileType haskell nnoremap <silent> <leader>ik :InteroKill<CR>

  " Open intero/GHCi split horizontally
  au FileType haskell nnoremap <silent> <leader>io :InteroOpen<CR>
  " Open intero/GHCi split vertically
  au FileType haskell nnoremap <silent> <leader>iov :InteroOpen<CR><C-W>H
  au FileType haskell nnoremap <silent> <leader>ih :InteroHide<CR>

  " Reloading (pick one)
  " Automatically reload on save
  au BufWritePost *.hs InteroReload
  " Manually save and reload
  au FileType haskell nnoremap <silent> <leader>wr :w \| :InteroReload<CR>

  " Load individual modules
  au FileType haskell nnoremap <silent> <leader>il :InteroLoadCurrentModule<CR>
  au FileType haskell nnoremap <silent> <leader>if :InteroLoadCurrentFile<CR>

  " Type-related information
  " Heads up! These next two differ from the rest.
  au FileType haskell map <silent> <leader>t <Plug>InteroGenericType
  au FileType haskell map <silent> <leader>T <Plug>InteroType
  au FileType haskell nnoremap <silent> <leader>it :InteroTypeInsert<CR>

  " Navigation
  au FileType haskell nnoremap <silent> <leader>jd :InteroGoToDef<CR>

  " Managing targets
  " Prompts you to enter targets (no silent):
  au FileType haskell nnoremap <leader>ist :InteroSetTargets<SPACE>
augroup END

" Intero starts automatically. Set this if you'd like to prevent that.
let g:intero_start_immediately = 1

" Enable type information on hover (when holding cursor at point for ~1 second).
let g:intero_type_on_hover = 1

" Change the intero window size; default is 10.
let g:intero_window_size = 15

" Sets the intero window to split vertically; default is horizontal
let g:intero_vertical_split = 1

" OPTIONAL: Make the update time shorter, so the type info will trigger faster.
set updatetime=1000
" }}}
