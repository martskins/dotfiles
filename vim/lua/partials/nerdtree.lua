vim.cmd[[
  let g:nvim_tree_show_icons = { 'git': 0, 'folders': 0, 'files': 0, 'folder_arrows': 0 }
  let g:nvim_tree_respect_buf_cwd = 1
]]

require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = false,
  update_to_buf_dir   = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {}
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = 'left',
    auto_resize = false,
    mappings = {
      custom_only = false,
      list = {}
    },
    number = false,
    relativenumber = false
  },
  trash = {
    cmd = "trash",
    require_confirm = true
  }
}

local map = vim.api.nvim_set_keymap
map('n', '<leader>r', ':NvimTreeFindFile<CR>', { silent = true })
map('n', '<leader>n', ':NvimTreeToggle<CR>', { silent = true })
map('n', '-', ':call ToggleTree()<CR>', { silent = true })

vim.cmd[[
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
