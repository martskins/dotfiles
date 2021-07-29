local map = vim.api.nvim_set_keymap

map('n', 'gev', ':e ~/.config/nvim/init.lua<CR>', { noremap = true })
map('n', 'gsv', ':so ~/.config/nvim/init.lua<CR>', { noremap = true })
map('n', '<C-h>', ':nohlsearch<C-R>=has(\'diff\')?\'<Bar>diffupdate\':\'\'<CR><CR><C-L>', { noremap = true, silent = true })
map('n', '<Up>', ':cprevious<cr>', {})
map('n', '<Down>', ':cnext<cr>', {})
map('n', '<Right>', ':cnext<cr>', {})
map('n', '<Left>', ':cprevious<cr>', {})
map('n', '<tab>', ':bnext<CR>', {})
map('n', '<s-tab>', ':bprevious<CR>', {})
map('n', '<c-f>', ':Rg<space>', {})
map('n', '<leader>ba', ':bufdo bd<CR>', {})
map('n', '<leader>bo', ':BufOnly<CR>', { silent = true })
map('n', '<leader>x', ':%!xxd<CR>', {})
map('n', '<c-s><c-v>', ':vsplit<CR>', {})
map('n', '<c-s><c-h>', ':split<CR>', {})
map('n', '<space><space>', '<C-^>', {})
map('n', '<C-l>', ':Buffers<CR>', {})
map('i', '<C-c>', '<ESC>', { noremap = true })
map('i', '<LeftMouse>', '<NOP>', { noremap = true })
map('n', '<LeftMouse>', '<NOP>', { noremap = true })
map('v', '<leader>pj', ':!python -m json.tool<CR>', { noremap = true })
map('n', ']p', ':pu<CR>', { silent = true })
map('n', '[p', ':pu!<CR>', { silent = true })
map('n', '<leader>tt', ':TestNearest<cr>', {})

map('n', '<F6>',':call DoRequest("normal")<CR>', { noremap = true })
map('v', '<F6>', ':<c-u>call DoRequest("visual")<CR>', { noremap = true })


vim.api.nvim_exec([[
  function! SynGroup()
      let l:s = synID(line('.'), col('.'), 1)
      echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
  endfun
]], false)

vim.api.nvim_exec([[
  function! DoRequest(mode) abort
    :set splitright
    if a:mode == "normal"
      exec "normal mk\"vyip"
    else
      exec "normal gv\"vy"
    endif

    if !exists("g:last_terminal_chan_id")
      vs
      terminal
      let g:last_terminal_chan_id = b:terminal_job_id
      wincmd p
    endif

    if getreg('"v') =~ "^\n"
      call chansend(g:last_terminal_chan_id, expand("%:p")."\n")
    else
      call chansend(g:last_terminal_chan_id, @v)
    endif
    exec "normal `k"
  endfunction

	function! ProfileStart()
		:profile start profile.log
		:profile func *
		:profile file *
	endfunction

	function! ProfileStop()
		:profile stop
	endfunction
]], false)

vim.api.nvim_exec([[
  function! GoAddTags(struct_name, tag_name) abort
    call system('gomodifytags -file ' . expand('%:p') . ' -struct ' . a:struct_name . ' -w -add-tags ' . a:tag_name)
    :e!
  endfunction

  command! -nargs=+ GoAddTags execute GoAddTags(<f-args>)
]], false)
