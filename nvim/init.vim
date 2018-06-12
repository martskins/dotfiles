set nocompatible
filetype off
set rtp+=~/.config/nvim/bundle/Vundle.vim

"{{{ PLUGINS
  call vundle#begin()
  "{{{ GENERIC
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'scrooloose/nerdTree'
    "Plugin 'jistr/vim-nerdtree-tabs'
    Plugin 'scrooloose/nerdcommenter'
    Plugin 'vim-airline/vim-airline'
    Plugin 'git://github.com/jiangmiao/auto-pairs.git'
    Plugin 'SirVer/ultisnips'
    Plugin 'mileszs/ack.vim'
    Plugin 'ervandew/supertab'
    Plugin 'w0rp/ale'
    "Plugin 'majutsushi/tagbar'
    "Plugin 'szw/vim-tags'
    Plugin 'kien/ctrlp.vim'
    "Plugin 'tpope/vim-unimpaired.git'
    Plugin 'tpope/vim-abolish'
    Plugin 'tpope/vim-fugitive'
  "}}}
  "{{{ COLOR SCHEMES
    Plugin 'tomasr/molokai'
    Plugin 'tomasiser/vim-code-dark'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'ayu-theme/ayu-vim'
    Plugin 'sickill/vim-monokai'
    Plugin 'drewtempelmeyer/palenight.vim'
    Plugin 'tyrannicaltoucan/vim-quantum'
    Plugin 'rafi/awesome-vim-colorschemes'
    Plugin 'dunstontc/vim-vscode-theme'
    Plugin 'olivertaylor/vacme'
    Plugin 'mhartington/oceanic-next'
  "}}}
  "{{{ GO
    Plugin 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
    Plugin 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plugin 'zchee/deoplete-go', { 'do': 'make'}
  "}}}
  "{{{ RUST
    Plugin 'sebastianmarkow/deoplete-rust'
    Plugin 'rust-lang/rust.vim'
    Plugin 'racer-rust/vim-racer'
  "}}}
  call vundle#end()
"}}}
filetype plugin indent on
"{{{ MISC
  syntax on
  syntax enable

  autocmd FileType vim setlocal foldmethod=marker
  set shell=/bin/zsh
  set ignorecase
  set number relativenumber
  set backspace=indent,eol,start
  set pastetoggle=<leader>z
  set tabstop=2
  set shiftwidth=2
  set cmdheight=2
  set expandtab
  set clipboard=unnamed
  set cursorcolumn
  set colorcolumn=150
  set hidden
  set history=100
  set hlsearch
  set showmatch
  set signcolumn=yes
  set guifont=Monaco
  set termguicolors
  set ttyfast
  let mapleader = ','

  hi LineNr ctermfg=red
  hi LineNr guifg=#050505
  set background=dark
  colorscheme molokayo

  let g:airline#extensions#tabline#enabled = 1
  let g:airline_powerline_fonts = 1

  set fdm=expr
  set fde=getline(v:lnum)=~‘^\\s\/\/‘?1:getline(prevnonblank(v:lnum))=~‘^\\s\/\/‘?1:getline(nextnonblank(v:lnum))=~‘^\\s*\/\/’?1:0

  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
"}}}
"{{{ NERDTREE
  nnoremap <Leader>f :NERDTreeToggle<Enter>
  let NERDTreeQuitOnOpen = 1
  let NERDTreeMinimalUI = 1
  let NERDTreeDirArrows = 1
  let g:nerdtree_tabs_open_on_gui_startup = 0
"}}}
"{{{ DEOPLETE
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#sources#rust#racer_binary='/Users/martin/.cargo/bin/racer'
  let g:deoplete#sources#rust#show_duplicates=1
  let g:deoplete#sources#rust#rust_source_path='/Users/martin/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src'
"}}}
"{{{ JAVA
  autocmd FileType java setlocal omnifunc=javacomplete#Complete
"}}}
"{{{ GO
  let g:go_fmt_command = "goimports"
  let g:go_autodetect_gopath = 1
  let g:go_highlight_types = 1
  let g:go_highlight_fields = 1
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

  let g:deoplete#sources#go#gocode_binary = '/Users/martin/go/bin/gocode'
  let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

  autocmd FileType go nmap <silent> <Leader>d <Plug>(go-def)
  autocmd FileType go nmap <leader>r <Plug>(go-run)
  autocmd FileType go nmap <leader>t <Plug>(go-test)
  autocmd FileType go nmap <leader>a <Plug>(go-alternate-edit)
  autocmd FileType go nmap <leader>g <Plug>(go-generate)
  autocmd FileType go nmap <leader>b <Plug>(go-build)

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
"{{{ ALE
  let g:ale_fixers = { 'javascript': ['eslint'] }
  let g:ale_fix_on_save = 1
  let g:ale_emit_conflict_warnings = 0
  let g:ale_linters = { 'javascript': ['eslint'], 'go': ['goimports', 'govet']}
"}}}
"{{{ ULTISNIPS
  let g:UltiSnipsSnippetsDir="~/.config/nvim/UltiSnips"
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
  nmap <leader>. :TagbarToggle<CR>
  nmap <leader>bd :bdelete<CR>
  nmap <leader>bq :bdelete!<CR>
  nmap <leader>bo :BufOnly<CR>

  nmap <Down> :cnext<cr>
  nmap <Up> :cprevious<cr>
"}}}
"{{{ SUPERTAB
  let g:SuperTabDefaultCompletionType = "<c-n>"
"}}}
"{{{ CTRL-P 
  let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|\.git\|target\|web-app'
"}}}
"{{{ ACK
  nmap <leader>w :call FindUsages()<CR>
  function! FindUsages()
   let wordUnderCursor = expand("<cword>")
   execute ":Ack " . wordUnderCursor
  endfunction
"}}}
