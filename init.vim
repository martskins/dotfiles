set nocompatible
filetype off

"{{{ PLUGINS
call plug#begin('~/.vim/plugged')
"{{{ GENERIC
Plug 'VundleVim/Vundle.vim'
Plug 'vim-scripts/VisIncr'
Plug 'scrooloose/nerdTree'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'git://github.com/jiangmiao/auto-pairs.git'
Plug 'mileszs/ack.vim'
Plug 'w0rp/ale'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'airblade/vim-gitgutter'
Plug 'mattn/emmet-vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'dhruvasagar/vim-table-mode'
Plug 'digitaltoad/vim-pug'
Plug 'junegunn/vim-github-dashboard'
Plug 'ashisha/image.vim'
Plug 'jceb/vim-orgmode'
Plug 'lkdjiin/vim-foldcomments'
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
"{{{ LSP
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': './install.sh' }
Plug 'dbakker/vim-projectroot'
"}}}
"{{{ NEOSNIPPET
Plug 'Shougo/neosnippet.vim', { 'for': 'go' }
Plug 'Shougo/neosnippet-snippets', { 'for': 'go' }
"}}}
"{{{ RUBY
"Plug 'hackhowtofaq/vim-solargraph'
"}}}
"{{{ COLORSCHEMES
Plug 'hzchirs/vim-material'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline-themes'
Plug 'ayu-theme/ayu-vim'
Plug 'sickill/vim-monokai'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'dunstontc/vim-vscode-theme'
Plug 'olivertaylor/vacme'
Plug 'mhartington/oceanic-next'
Plug 'ervandew/supertab'
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
Plug 'thecodesmith/vim-groovy'
"}}}
"{{{ KOTLIN
Plug 'udalov/kotlin-vim', { 'for': 'kotlin' }
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
set tabstop=4
set shiftwidth=4
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
set synmaxcol=128
set cursorcolumn
set cursorline
"set nocursorcolumn
"set nocursorline
"set mouse=a


hi LineNr ctermfg=red
hi LineNr guifg=#050505
set background=dark
"colorscheme vacme
colorscheme vim-material
let g:airline_theme='material'

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

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
if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
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

"}}}
"{{{ NERDTREE
nnoremap <Leader>f :NERDTreeToggle<Enter>
let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:nerdtree_tabs_open_on_gui_startup = 0
"}}}
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

function! s:build_go_files()
    let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
        call go#cmd#Test(0, 1)
    elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
    endif
endfunction
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

function! s:toggle_coverage()
    call go#coverage#BufferToggle(!g:go_jump_to_error)
    highlight ColorColumn ctermbg=235
    highlight NonText ctermfg=239
    highlight SpecialKey ctermfg=239
    highlight goSameId term=bold cterm=bold ctermbg=250 ctermfg=239
endfunction

autocmd FileType go nmap <leader>c :<C-u>call <SID>toggle_coverage()<CR>
"}}}
"{{{ RUST
let g:rustfmt_autosave = 1

au FileType rust nmap <leader>d gd

augroup vimrc-rust-autopairs                                                              
    autocmd!
    autocmd FileType rust let g:AutoPairs = {'(':')', '[':']', '{':'}','"':'"', '`':'`'}
augroup END
"}}}
"{{{ ALE
let g:ale_fixers = { 'javascript': ['eslint'] }
let g:ale_fix_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_emit_conflict_warnings = 0
let g:ale_linters = { 'javascript': ['eslint'], 'go': ['gometalinter'], 'rust': ['cargo'] }
"}}}
"{{{ MAPPINGS
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

" BUILD
autocmd FileType cpp nmap <leader>b :!make build<CR>
autocmd FileType go nmap <leader>b <Plug>(go-build)

" RUN
autocmd FileType rust nmap <leader>r :!cargo run<CR>
autocmd FileType cpp nmap <leader>r :!./a.out<CR>
autocmd FileType go nmap <leader>r <Plug>(go-run)

" RENAME
autocmd FileType groovy,scala,java,kotlin,rust,c,cpp nmap <leader>rn :call LanguageClient_textDocument_rename()<CR>
autocmd FileType go     nmap <leader>rn <Plug>(go-rename)

" DEFINITION
autocmd FileType groovy,scala,java,kotlin,rust,c,cpp
            \ nmap <silent> <leader>d :call LanguageClient_textDocument_definition()<CR>
autocmd FileType go     nmap <silent> <Leader>d <Plug>(go-def)

autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <leader>a <Plug>(go-alternate-edit)
autocmd FileType go nmap <leader>g <Plug>(go-generate)

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
"{{{ CTRL-P 
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|\.git\|target\|web-app'
"}}}
"{{{ ACK
let g:ack_use_dispatch = 1

nmap <leader>w :call FindUsages()<CR>
function! FindUsages()
    let wordUnderCursor = expand("<cword>")
    execute ":Ack " . wordUnderCursor
endfunction
"}}}
"{{{ LSP
nnoremap <leader>lcs :LanguageClientStart<CR>

let g:LanguageClient_serverCommands = {
            \ 'rust': ['rustup', 'run', 'stable', 'rls'],
            \ 'cpp' : ['clangd'],
            \ 'javascript': ['flow-language-server', '--stdio'],
            \ 'groovy': ['tcp://127.0.0.1:8890'],
            \ 'kotlin': ['tcp://127.0.0.1:8890'],
            \ 'scala': ['tcp://127.0.0.1:8890'],
            \ 'java': ['tcp://127.0.0.1:8890'] 
            \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>zz
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
noremap <silent> H :call LanguageClient_textDocument_hover()<CR>
noremap <silent> Z :call LanguageClient_textDocument_definition()<CR>
noremap <silent> R :call LanguageClient_textDocument_rename()<CR>
noremap <silent> S :call LanugageClient_textDocument_documentSymbol()<CR>

if executable('clangd')
    augroup lsp_clangd
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'clangd',
                    \ 'cmd': {server_info->['clangd']},
                    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp']
                    \ })
        autocmd FileType c setlocal omnifunc=lsp#complete
        autocmd FileType cpp setlocal omnifunc=lsp#complete
        autocmd FileType objc setlocal omnifunc=lsp#complete
        autocmd FileType objcpp setlocal omnifunc=lsp#complete
    augroup end
endif

autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'intelli-lsp-server',
            \ 'cmd': {server_info->['tcp://127.0.0.1:8890']},
            \ 'whitelist': ['groovy', 'java', 'kotlin', 'scala']
            \ })

let g:LanguageClient_rootMarkers = {
            \ 'grooy': ['.idea'],
            \ 'scala': ['.idea'],
            \ 'java': ['.idea'],
            \ 'kotlin': ['.idea'],
            \  }

let g:LanguageClient_autoStart = 1
"}}}
"{{{ DEOPLETE
let g:deoplete#enable_at_startup = 1
"}}}
"{{{ NEOSNIPPET
au FileType go imap <C-k> <Plug>(neosnippet_expand_or_jump)
au FileType go smap <C-k> <Plug>(neosnippet_expand_or_jump)
au FileType go xmap <C-k> <Plug>(neosnippet_expand_target)
au FileType go set conceallevel=2 concealcursor=niv
"}}}
"{{{ SUPERTAB
let g:SuperTabDefaultCompletionType = "<c-n>"
"}}}
