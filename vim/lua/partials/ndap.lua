local module = {}

function module.config()
  local dap = require('dap')
  local widgets = require('dap.ui.widgets')

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

  vim.keymap.set('n', '<Leader>dc', function() require('dap').continue() end)
  vim.keymap.set('n', '<Leader>do', function() require('dap').step_over() end)
  vim.keymap.set('n', '<Leader>di', function() require('dap').step_into() end)
  vim.keymap.set('n', '<Leader>dx', function() require('dap').step_out() end)
  vim.keymap.set('n', '<Leader>db', function() require('dap').toggle_breakpoint() end)
  vim.keymap.set('n', '<Leader>dt', function() require('dap').terminate() end)
  vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
  vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
  vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
  vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
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

return module
