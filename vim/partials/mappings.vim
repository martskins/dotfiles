command! WQ wq
command! Wq wq
command! W w
command! Q q
command! ProfileStart :call ProfileStart()
command! ProfileStop :call ProfileStop()
command! Gblame normal!:let @a=expand('%')<CR>:let @b=line('.')<CR>:80vnew<CR>:set bt=nofile<CR>:set nowrap<CR>:%!git blame -wM <C-R>a<CR>:<C-R>b<CR>
command! SynGroup :call SynGroup()

nnoremap <silent> <C-h> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
nnoremap gev :e ~/.config/nvim/init.vim<CR>
nnoremap gsv :so ~/.config/nvim/init.vim<CR>
nmap <Up> :cprevious<cr>
nmap <Down> :cnext<cr>
nmap <Right> :cnext<cr>
nmap <Left> :cprevious<cr>
nmap <tab> :bnext<CR>
nmap <s-tab> :bprevious<CR>
nmap <c-f> :Rg<space>
nmap <leader>ba :bufdo bd<CR>
nmap <silent><leader>bo :BufOnly<CR>
nmap <leader>x :%!xxd<CR>
nmap <C-v><C-v> gg<C-V>G$
nmap <c-s><c-v> :vsplit<CR>
nmap <c-s><c-h> :split<CR>
nmap <space><space> <C-^>
nmap <C-l> :Buffers<CR>
inoremap <C-c> <ESC>
inoremap <LeftMouse> <NOP>
vnoremap <leader>pj :!python -m json.tool<CR>
nmap <silent> ]p :pu<CR>
nmap <silent> [p :pu!<CR>

function! ProfileStart()
  :profile start profile.log
  :profile func *
  :profile file *
endfunction

function! ProfileStop()
  :profile stop
endfunction

function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
