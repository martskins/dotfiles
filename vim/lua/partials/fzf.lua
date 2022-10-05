local map = vim.api.nvim_set_keymap

-- require('fzf-lua').setup {
--   grep_project = {
--     fzf_opts = {
--       ["--nth"] = false
--     }
--   },
--   lines = {
--     fzf_opts = {
--       ["--nth"] = false
--     }
--   }
-- }

map('n', '<c-p>', ':FzfLua files<CR>', {})
map('n', '<c-f>', ':FzfLua grep<CR>', {})
-- map('n', '<c-f>',
--   ':lua require("fzf-lua").grep_project({ fzf_opts = { ["--nth"] = false }, search = "" })<Left><Left><Left><Left>', {})
