local g = vim.g
g.tagbar_foldlevel = 0
g.tagbar_sort = 0

local map = vim.api.nvim_set_keymap
map('n', ',.', ':TagbarToggle<CR><C-w><C-w>', { silent = true })
