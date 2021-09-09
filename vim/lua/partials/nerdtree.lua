local map = vim.api.nvim_set_keymap
map('n', '<leader>r', ':NvimTreeFindFile<CR>', { silent = true })
map('n', '<leader>n', ':NvimTreeToggle<CR>', { silent = true })
map('n', '-', ':call ToggleTree()<CR>', { silent = true })

vim.cmd[[
  let g:nvim_tree_auto_close = 1 "closes the tree when it's the last window
  let g:nvim_tree_quit_on_open = 1 "closes the tree when you open a file
  let g:nvim_tree_indent_markers = 1 "this option shows indent markers when folders are open
  let g:nvim_tree_show_icons = { 'git': 0, 'folders': 0, 'files': 0, 'folder_arrows': 1 }
]]

vim.api.nvim_exec([[
  function! ToggleTree()
    if &filetype == ''
      :NvimTreeToggle
    elseif &filetype != 'NvimTree'
      :NvimTreeFindFile
    endif
  endfunction
]], false)
