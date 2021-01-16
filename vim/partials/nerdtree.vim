let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeAutoDeleteBuffer = 1
map <leader>r :NERDTreeFind<cr>
map <C-n> :NERDTreeToggle<CR>
map <silent>- :call ToggleTree()<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " close vim if nerdtre is only open win

function! ToggleTree()
  if &filetype == ''
    :NERDTreeToggle
  elseif &filetype == 'nerdtree' || exists("g:NERDTree") && g:NERDTree.IsOpen()
    :call nerdtree#ui_glue#upDir(v:true)
  else
		:NERDTreeFind
  endif
endfunction
