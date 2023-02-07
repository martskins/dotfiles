local module = {}

function module.config()
  local g = vim.g
  g.tagbar_autofocus = 1
  g.tagbar_compact = 1
  g.tagbar_expand = 1
  g.tagbar_sort = 0
end

function module.init()
  local map = vim.api.nvim_set_keymap
  map('n', ',.', ':TagbarToggle<CR>', { silent = true })
end

return module
