set nocompatible
filetype off

"{{{ PLUGINS
call plug#begin('~/.vim/plugged')
Plug 'VundleVim/Vundle.vim'
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
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
Plug 'mattn/emmet-vim'
Plug 'lkdjiin/vim-foldcomments'
Plug 'ervandew/supertab'
Plug 'majutsushi/tagbar'
Plug 'godlygeek/tabular'
Plug 'ntpeters/vim-better-whitespace'
Plug 'unblevable/quick-scope'
Plug 'diepm/vim-rest-console'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-ultisnips'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'ncm2/ncm2-go', { 'for': 'go' }
Plug 'ncm2/ncm2-tern', { 'for': 'javascript' , 'do': 'npm install' }
Plug 'ncm2/ncm2-cssomni', { 'for': 'css' }
Plug 'ncm2/ncm2-jedi', { 'for': 'python' }
Plug 'ncm2/ncm-ruby', { 'for': 'ruby' }

" elixir
Plug 'elixir-editors/vim-elixir', { 'for': 'elixir' }

" pug
Plug 'digitaltoad/vim-pug', { 'for': ['pug', 'jade'] }

" ruby
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }

" go
" Plug 'mdempsky/gocode', { 'rtp': 'nvim', 'do': '~/.vim/plugged/gocode/nvim/symlink.sh' }
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' , 'for': 'go' }

" rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

" jvm
Plug 'vim-scripts/grails-vim', { 'for': ['groovy', 'java', 'kotlin'] }
Plug 'martskins/vimport', { 'for': ['groovy', 'java', 'kotlin'] }
Plug 'thecodesmith/vim-groovy', { 'for': ['groovy', 'java', 'kotlin'] }
Plug 'udalov/kotlin-vim', { 'for': 'kotlin' }

" haskell
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
Plug 'parsonsmatt/intero-neovim', { 'for': 'haskell' }
Plug 'neomake/neomake', { 'for': 'haskell' }

" javascript
Plug 'posva/vim-vue', { 'for': 'vue' }

" completion
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': './install.sh' }
Plug 'dbakker/vim-projectroot'

" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" colorschemes
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'
call plug#end()
"}}}
filetype plugin indent on
"{{{ CONFIG
syntax off
syntax enable

" shell
set shell=/bin/zsh
set cmdheight=2

" visuals
set number relativenumber
set hid
set colorcolumn=128
set signcolumn=yes
set guifont=Monaco
set termguicolors
set cursorcolumn
set cursorline
set synmaxcol=128

hi LineNr ctermfg=red
hi LineNr guifg=#050505
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" colors
set background=dark
colorscheme base16-atelier-dune
highlight ColorColumn ctermbg=red guibg=red

" indentation
set tabstop=2
set shiftwidth=2
set expandtab
set backspace=indent,eol,start
set autoindent

" pasting
set pastetoggle=<leader>z
set clipboard=unnamed

" search
set ignorecase
set history=100
set hlsearch
set showmatch
if maparg('<F3>', 'n') ==# ''
  nnoremap <silent> <F3> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" behavior
set autoread
set ttyfast
set t_ut=
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

  autocmd FileType groovy,java,scala,javascript,go,rs
        \ set foldmethod=expr |
        \ set foldexpr=getline(v:lnum)=~'^\\s*//' |
        \ exe "normal zM``"
augroup end

if has("mac")
  let g:python_host_prog="/usr/local/bin/python"
  let g:python3_host_prog="/usr/local/bin/python3"
else
  let g:python_host_prog="/home/linuxbrew/.linuxbrew/bin/python"
  let g:python3_host_prog="/home/linuxbrew/.linuxbrew/bin/python3.7"
endif

augroup netrw_buf_hidden_fix
  autocmd!
  set nohidden
  autocmd BufWinEnter *
        \  if &ft != 'netrw'
        \|     set bufhidden=hide
        \| endif
augroup end

" neco-ghc
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" tagbar
let g:tagbar_autofocus = 1

" supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" ncm2
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
au User Ncm2PopupOpen set completeopt=noinsert,menuone,noselect
au User Ncm2PopupClose set completeopt=menuone

" ack
let g:ack_use_dispatch = 1

" ctrlp
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|\.git\|target\|web-app'

" airline
let g:airline_theme='base16_default'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" ale
let g:ale_fixers = { 'javascript': ['eslint'], 'haskell': ['brittany'], 'python': ['autopep8', 'isort'], 'cpp': ['clang-format']}
let g:ale_fix_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_emit_conflict_warnings = 0
let g:ale_linters = { 'javascript': ['eslint'], 'go': ['gometalinter'], 'rust': ['cargo'], 'haskell': ['hlint', 'ghc-mod'], 'python': ['flake8'], 'cpp': []}

" better-whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
"}}}
"{{{ LANGUAGE-SPECIFIC

" lisp
let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"
if (has('tmux'))
  let g:slime_default_config = {"socket_name": split($TMUX, ",")[0], "target_pane": ":.2"}
endif

" ruby
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete

" java
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

augroup custom_hl
  autocmd!
  au FileType groovy syn region groovyComment start="@PropertyHelp" end=")"
augroup end

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

let g:go_gocode_unimported_packages = 1
let g:go_gocode_propose_source = 0

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

  " au FileType go      set conceallevel=2 concealcursor=niv
augroup end

" cpp
augroup filetype_c
  autocmd!
  autocmd FileType c,cpp    nmap <leader>b :!make build<CR>
  autocmd FileType c,cpp    nmap <leader>r :!make build && ./a.out<CR>
augroup end

" rust
let g:rustfmt_autosave = 1

augroup filetype_rust
  autocmd!
  au FileType rust nmap <leader>r :!cargo run<CR>

  "AUTO-PAIRS
  au FileType rust let g:AutoPairs = {'(':')', '[':']', '{':'}','"':'"', '`':'`'}
augroup end
"}}}
"{{{ MAPPINGS
command! WQ wq
command! Wq wq
command! W w
command! Q q
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
nnoremap 0 ^
nnoremap ^ 0
nnoremap Q :norm @q<cr>
nmap <leader>bd :bdelete<CR>
nmap <leader>bq :bdelete!<CR>
nmap <leader>bo :BufOnly<CR>
nmap <Down> :cnext<cr>
nmap <Up> :cprevious<cr>
nnoremap <leader>s :,$s/\<<C-r><C-w>\>//gc<Left><Left><Left>
nnoremap <leader>S :%s/\<<C-r><C-w>\>//gc<Left><Left>
nmap <leader>tab :Tabularize /\|<CR>
nnoremap <leader>pj :norm 0v$,json<CR>
vnoremap <leader>pj :!python -m json.tool<CR>
nmap <space> ,
nmap <space><space> :e#<cr>
vmap <C-c> <ESC>
nmap <C-v><C-v> gg<C-V>G$

nnoremap gev :e $MYVIMRC<CR>
nnoremap gsv :so $MYVIMRC<CR>

nmap <leader>lg :term lazygit<CR>i
nmap <F8> :TagbarToggle<CR>
nmap <leader>. :TagbarToggle<CR>

if has('nvim')
  tnoremap <leader>bd :bd!<CR>
endif

function! FixAccute()
  execute "%s/&aacute;/á/ge"
  execute "%s/&eacute;/é/ge"
  execute "%s/&oacute;/ó/ge"
  execute "%s/&uacute;/ú/ge"
  execute "%s/&iacute;/í/ge"
  execute "%s/&uuml;/ü/ge"
  execute "%s/&ntilde;/ñ/ge"
  execute "%s/&iquest;/¿/ge"
endfunction
command! FixAccute :call FixAccute()

augroup qf
   autocmd!
   autocmd FileType qf set nobuflisted
augroup END

" ultisnips
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"}}}
"{{{ LSP
nnoremap <leader>lcs :LanguageClientStart<CR>
let g:LanguageClient_diagnosticsList = 'Disabled'
let g:LanguageClient_autoStart = 1
let g:LanguageClient_loadSettings = 1
if has('nvim')
  let g:LanguageClient_settingsPath = '~/.config/nvim/settings.json'
else
  let g:LanguageClient_settingsPath = '~/.config/vim/settings.json'
endif

      "\ 'cpp' : ['cquery', '--language-server', '--log-file=/tmp/cqlog.log'],
let g:LanguageClient_serverCommands = {
      \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
      \ 'cpp': ['clangd']
      \ }

" let g:LanguageClient_rootMarkers = {
"      \ 'cpp': ['.cquery', 'compile_commands.json', 'build'],
"      \ }

augroup lsp_langs
  autocmd!
  au FileType rust,c,cpp nnoremap <F5> :call LanguageClient_contextMenu()<CR>
  au FileType rust,c,cpp nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
  au FileType rust,c,cpp nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>zz
  au FileType rust,c,cpp nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
  au FileType rust,c,cpp noremap <silent> H :call LanguageClient_textDocument_hover()<CR>
  au FileType rust,c,cpp noremap <silent> Z :call LanguageClient_textDocument_definition()<CR>
  au FileType rust,c,cpp noremap <silent> R :call LanguageClient_textDocument_rename()<CR>
  au FileType rust,c,cpp noremap <silent> S :call LanugageClient_textDocument_documentSymbol()<CR>
  au FileType rust,c,cpp nmap <leader>rn :call LanguageClient_textDocument_rename()<CR>
  au FileType rust,c,cpp nmap <silent> <leader>d :call LanguageClient_textDocument_definition()<CR>
augroup end

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
" {{{ VMATH
" Vim global plugin for math on visual regions
" Maintainer:	Damian Conway
" License:	This file is placed in the public domain.

"######################################################################
"##                                                                  ##
"##  To use:                                                         ##
"##                                                                  ##
"##     vmap <expr>  ++  VMATH_YankAndAnalyse()                      ##
"##     nmap         ++  vip++                                       ##
"##                                                                  ##
"##  (or whatever keys you prefer to remap these actions to)         ##
"##                                                                  ##
"######################################################################


" If already loaded, we're done...
if exists("loaded_vmath")
  finish
endif
let loaded_vmath = 1

" Preserve external compatibility options, then enable full vim compatibility...
let s:save_cpo = &cpo
set cpo&vim

" Grab visual selection and do simple math on it...
function! VMATH_YankAndAnalyse ()
  return "y:call VMATH_Analyse()\<CR>gv"
endfunction

" What to consider a number...
let s:NUM_PAT = '^[+-]\?\d\+\%([.]\d\+\)\?\([eE][+-]\?\d\+\)\?$'

" How widely to space the report components...
let s:REPORT_GAP = 5  "spaces between components

" Do simple math on current yank buffer...
function! VMATH_Analyse ()
  " Extract data from selection...
  let selection = getreg('')
  let raw_numbers = filter(split(selection), 'v:val =~ s:NUM_PAT')
  let numbers = map(copy(raw_numbers), 'str2float(v:val)')

  " Results include a newline if original selection did...
  let newline = selection =~ "\n" ? "\n" : ""

  " Calculate and en-register various interesting metrics...
  let summation = len(numbers) ? join( numbers, ' + ') : '0'
  call setreg('s', s:tidy( eval( summation )      ))   " Sum     --> register s
  call setreg('a',         s:average(raw_numbers)  )   " Average --> register a
  call setreg('x', s:tidy( s:max(numbers)         ))   " Max     --> register x
  call setreg('n', s:tidy( s:min(numbers)         ))   " Min     --> register n
  call setreg('r',         @n . ' to ' . @x        )   " Range   --> register r

  " Default paste buffer should depend on original contents (TODO)
  call setreg('', @s )

  " Report...
  let gap = repeat(" ", s:REPORT_GAP)
  highlight NormalUnderlined term=underline cterm=underline gui=underline
  echohl NormalUnderlined
  echo  's'
  echohl NONE
  echon  'um: ' . @s . gap
  echohl NormalUnderlined
  echon 'a'
  echohl NONE
  echon  'vg: ' . @a . gap
  echon 'mi'
  echohl NormalUnderlined
  echon   'n'
  echohl NONE
  echon    ': ' . @n . gap
  echon 'ma'
  echohl NormalUnderlined
  echon   'x'
  echohl NONE
  echon    ': ' . @x . gap

endfunction

" Prettify numbers...
function! s:tidy (number)
  let tidied = printf('%g', a:number)
  return substitute(tidied, '[.]0\+$', '', '')
endfunction

" Compute average with meaningful number of decimal places...
function! s:average (numbers)
  " Compute average...
  let summation = eval( len(a:numbers) ? join( a:numbers, ' + ') : '0' )
  let avg = 1.0 * summation / s:max([len(a:numbers), 1])

  " Determine significant figures...
  let min_decimals = 15
  for num in a:numbers
    let decimals = strlen(matchstr(num, '[.]\d\+$')) - 1
    if decimals < min_decimals
      let min_decimals = decimals
    endif
  endfor

  " Adjust answer...
  return min_decimals > 0 ? printf('%0.'.min_decimals.'f', avg)
        \                       : string(avg)
endfunction

" Reimplement these because the builtins don't handle floats (!!!)
function! s:max (numbers)
  if !len(a:numbers)
    return 0
  endif
  let numbers = copy(a:numbers)
  let maxnum = numbers[0]
  for nextnum in numbers[1:]
    if nextnum > maxnum
      let maxnum = nextnum
    endif
  endfor
  return maxnum
endfunction

function! s:min (numbers)
  if !len(a:numbers)
    return 0
  endif
  let numbers = copy(a:numbers)
  let minnum = numbers[0]
  for nextnum in numbers[1:]
    if nextnum < minnum
      let minnum = nextnum
    endif
  endfor
  return minnum
endfunction


" Restore previous external compatibility options
let &cpo = s:save_cpo

xnoremap <expr> ++ VMATH_YankAndAnalyse()
nmap ++  vip++
" }}}
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

let g:ftplugin_sql_omni_key = '<C-j>'
set encoding=utf-8

let $NVIM_PYTHON_LOG_FILE="/tmp/nvim_log"
