local module = {}

function module.config()
  local g = vim.g
  g.tagbar_foldlevel = 0
  g.tagbar_sort = 0
end

function module.init()
  local map = vim.api.nvim_set_keymap
  map('n', ',.', ':TagbarToggle<CR><C-w><C-w>', { silent = true })
end

return module
