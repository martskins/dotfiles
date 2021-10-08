local map = vim.api.nvim_set_keymap

map('i', '<c-x><c-k>', '<plug>(fzf-complete-word)', {})
map('i', '<c-x><c-f>', '<plug>(fzf-complete-path)', {})
map('i', '<c-x><c-l>', '<plug>(fzf-complete-line)', {})
map('n', '<leader><tab>', '<plug>(fzf-maps-n)', {})
map('n', '<c-p>', ':Files<CR>', {})
