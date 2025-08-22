local map = vim.api.nvim_set_keymap
map("n", "<leader>tt", ":TestNearest<cr>", {})
map("n", "<leader>tp", ":TestFile<cr>", {})
map("n", "<leader>ta", ":TestSuite<cr>", {})
vim.api.nvim_exec([[
  let test#strategy = "neovim"
  let test#neovim#start_normal = 1
]], false)
