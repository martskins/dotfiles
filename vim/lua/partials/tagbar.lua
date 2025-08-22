local g = vim.g
g.tagbar_autofocus = 1
g.tagbar_compact = 1
g.tagbar_expand = 0
g.tagbar_sort = 0
g.tagbar_foldlevel = 0

vim.api.nvim_set_keymap("n", ",.", ":TagbarToggle<CR>", {silent = true})
