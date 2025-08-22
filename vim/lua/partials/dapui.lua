local dapui = require("dapui")
dapui.setup()

local dap = require("dap")
dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end

dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end

dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end

dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end

vim.api.nvim_create_user_command("DapToggleUi", 'lua require("dapui").toggle()', {})
vim.keymap.set("v", "<leader>k", require("dapui").eval)
