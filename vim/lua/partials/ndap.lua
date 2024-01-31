local module = {}

function module.config()
  local dap = require('dap')

  dap.configurations.cpp = {
    {
        name = "Launch",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
        runInTerminal = true,
    }
  }

  dap.adapters.codelldb = {
    type = 'server',
    port = 13000,
    command = '/Users/martinasquino/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/adapter/codelldb',
    executable = {
      command = '/Users/martinasquino/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/adapter/codelldb',
      args = { '--port', '13000' }
    }
  }

  dap.configurations.go = {
    {
      type = "go",
      name = "Debug",
      request = "launch",
      program = "${file}",
    },
    {
      type = "go",
      name = "Debug test",
      request = "launch",
      mode = "test",
      program = "./${relativeFileDirname}",
    },
  }

  dap.adapters.go = {
    type = "server",
    port = "${port}",
    executable = {
      command = "dlv",
      args = { "dap", "-l", "127.0.0.1:" .. "${port}" }
    },
    options = {
      initialize_timeout_sec = 20
    }
  }

  local widgets = require('dap.ui.widgets')
  vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
    require('dap.ui.widgets').hover()
  end)

  vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
    require('dap.ui.widgets').preview()
  end)

  vim.keymap.set('n', '<Leader>df', function()
    widgets.centered_float(widgets.frames)
  end)

  vim.keymap.set('n', '<Leader>ds', function()
    widgets.centered_float(widgets.scopes)
  end)
end

function module.init()
  vim.keymap.set('n', '<Leader>dc', ':DapContinue<CR>', { silent = true })
  vim.keymap.set('n', '<Leader>do', ':DapStepOver<CR>', { silent = true })
  vim.keymap.set('n', '<Leader>di', ':DapStepInto<CR>', { silent = true })
  vim.keymap.set('n', '<Leader>dx', ':DapStepOut<CR>', { silent = true })
  vim.keymap.set('n', '<Leader>db', ':DapToggleBreakpoint<CR>', { silent = true })
  vim.keymap.set('n', '<Leader>dt', ':DapTerminate<CR>', { silent = true })
  vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
  vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
  vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
  vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)

end

return module
