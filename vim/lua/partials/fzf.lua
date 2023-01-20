local map = vim.api.nvim_set_keymap

-- map('n', '<c-p>', ':FzfLua files<CR>', {})
map('n', '<c-f>', ':FzfLua grep<CR>', {})
map('n', '<c-p>', ':lua require"fzf-lua".files({ cmd = "rg --files --follow -g \'!{**/node_modules/*,**/vendor/*}\'" })<CR>', {})
