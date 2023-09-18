local module = {}

function module.init()
  local map = vim.api.nvim_set_keymap
  map('n', '<C-l>', ':FzfLua buffers<CR>', {})
  map('n', '<C-f>', ':lua require"fzf-lua".grep({ cmd = "rg --line-number --column --color=always -g\'!{**/*_test.go,**/*mock*,gen/*,vendor/**}\' "})<CR>', {})
  map('n', '<C-g>', ':lua require"fzf-lua".grep({ cmd = "rg --line-number --column --color=always -g\'!{**/*mock*,gen/*,vendor/**}\' "})<CR>', {})
  map('n', '<C-p>', ':lua require"fzf-lua".files({ cmd = "rg --files --follow -g \'!{**/node_modules/*,**/vendor/*}\'" })<CR>', {})
end

return module
