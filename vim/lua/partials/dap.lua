local widgets = require('dap.ui.widgets')

function _G.dap_open_frames()
  widgets.sidebar(widgets.frames).open()
end

function _G.dap_open_scopes()
  widgets.sidebar(widgets.scopes).open()
end

local map = vim.api.nvim_set_keymap
map('n', '<leader>db', ":lua require'dap'.toggle_breakpoint()<CR>", { silent = true })
map('n', '<leader>dc', ":lua require'dap'.continue()<CR>", { silent = true })
map('n', '<leader>di', ":lua dap_open_scopes()<CR>", { silent = true })
map('n', '<leader>df', ":lua dap_open_frames()<CR>", { silent = true })
