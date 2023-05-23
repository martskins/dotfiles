local map = vim.api.nvim_set_keymap

map('n', 'gev', ':e ~/.config/nvim/init.lua<CR>', { noremap = true })
map('n', '<C-h>', ':nohlsearch<C-R>=has(\'diff\')?\'<Bar>diffupdate\':\'\'<CR><CR><C-L>',
  { noremap = true, silent = true })
map('n', '<Up>', ':cprevious<cr>', {})
map('n', '<Down>', ':cnext<cr>', {})
map('n', '<Right>', ':cnext<cr>', {})
map('n', '<Left>', ':cprevious<cr>', {})
map('n', '<tab>', ':bnext<CR>', {})
map('n', '<s-tab>', ':bprevious<CR>', {})
map('n', '<leader>ba', ':bufdo bd<CR>', {})
map('n', '<leader>x', ':%!xxd<CR>', {})
map('n', '<c-s><c-v>', ':vsplit<CR>', {})
map('n', '<c-s><c-h>', ':split<CR>', {})
map('n', '<space><space>', '<C-^>', {})
map('i', '<C-c>', '<ESC>', { noremap = true })
map('i', '<LeftMouse>', '<NOP>', { noremap = true })
map('n', '<LeftMouse>', '<NOP>', { noremap = true })
map('v', '<leader>pj', ':!python -m json.tool<CR>', { noremap = true })
map('n', ']p', ':pu<CR>', { silent = true })
map('n', '[p', ':pu!<CR>', { silent = true })
map('t', '<C-o>', '<C-\\><C-n>', {})

vim.api.nvim_exec([[
  function! SynGroup()
      let l:s = synID(line('.'), col('.'), 1)
      echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
  endfun

	function! ProfileStart()
		:profile start profile.log
		:profile func *
		:profile file *
	endfunction

	function! ProfileStop()
		:profile stop
	endfunction

  function! GoAddTags(struct_name, tag_name) abort
    call system('gomodifytags -file ' . expand('%:p') . ' -struct ' . a:struct_name . ' -w -add-tags ' . a:tag_name)
    :e!
  endfunction

  command! -nargs=+ GoAddTags execute GoAddTags(<f-args>)
  command! PS Lazy sync

  " the macro in f converts a struct field to a cli.Flag
  let @f='0wwcw0wPli 0wi&cli.l~eliFlag{Name:lli"ebyweli"bcrkf"li, EnvVars:[]string{"pbcrsgUweli"}, Destination: &cfg.pbeli, Required: true},'
  let g:rooter_patterns = ['.git', 'Makefile', '*.sln', 'build/env.sh']
  let g:rooter_resolve_links = 0

  function! RangeSearch(direction)
    call inputsave()
    let g:srchstr = input(a:direction)
    call inputrestore()
    if strlen(g:srchstr) > 0
      let g:srchstr = g:srchstr.
            \ '\%>'.(line("'<")-1).'l'.
            \ '\%<'.(line("'>")+1).'l'
    else
      let g:srchstr = ''
    endif
  endfunction
  vnoremap <silent> / :<C-U>call RangeSearch('/')<CR>:if strlen(g:srchstr) > 0\|exec '/'.g:srchstr\|endif<CR>
  vnoremap <silent> ? :<C-U>call RangeSearch('?')<CR>:if strlen(g:srchstr) > 0\|exec '?'.g:srchstr\|endif<CR>
]], false)
