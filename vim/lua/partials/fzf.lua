local module = {}

function module.init()
  local map = vim.api.nvim_set_keymap
  map('n', '<C-l>', ':FzfLua buffers<CR>', {})
  map('n', '<c-f>', ':FzfLua grep<CR>', {})
  map('n', '<c-p>', ':lua require"fzf-lua".files({ cmd = "rg --files --follow -g \'!{**/node_modules/*,**/vendor/*}\'" })<CR>', {})
end

return module
