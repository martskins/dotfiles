local module = {}

function module.config()
    local dap = require("dap")

    dap.configurations.rust = {
        {
            name = "Launch",
            type = "lldb",
            request = "launch",
            program = function()
                -- return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/a.out", "file")
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/a.out", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false
        }
    }

    dap.configurations.c = {
        {
            name = "Launch",
            type = "codelldb",
            request = "launch",
            program = function()
                -- local dirname = vim.fn.substitute(vim.fn.getcwd(), "^.*/", "", "")
                -- return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/" .. dirname, "file")
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/a.out", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = function()
                local args_string = vim.fn.input("Arguments: ")
                return vim.split(args_string, " ")
            end,
            runInTerminal = true
        }
    }

    dap.configurations.cpp = {
        {
            name = "Launch",
            type = "codelldb",
            request = "launch",
            program = function()
                -- local dirname = vim.fn.substitute(vim.fn.getcwd(), "^.*/", "", "")
                -- return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/" .. dirname, "file")
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/a.out", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = function()
                local args_string = vim.fn.input("Arguments: ")
                return vim.split(args_string, " ")
            end,
            runInTerminal = true
        }
    }

    dap.adapters.codelldb = {
        type = "server",
        port = 13000,
        command = "/Users/martinasquino/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/adapter/codelldb",
        executable = {
            command = "/Users/martinasquino/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/adapter/codelldb",
            args = {"--port", "13000"}
        }
    }

    dap.configurations.go = {
        {
            type = "go",
            name = "Debug",
            request = "launch",
            program = "${file}"
        },
        {
            type = "go",
            name = "Debug test",
            request = "launch",
            mode = "test",
            program = "./${relativeFileDirname}"
        }
    }

    dap.adapters.go = {
        type = "server",
        port = "${port}",
        executable = {
            command = "dlv",
            args = {"dap", "-l", "127.0.0.1:" .. "${port}"}
        },
        options = {
            initialize_timeout_sec = 20
        }
    }

    local widgets = require("dap.ui.widgets")
    vim.keymap.set(
        {"n", "v"},
        "<Leader>dh",
        function()
            require("dap.ui.widgets").hover()
        end
    )

    vim.keymap.set(
        {"n", "v"},
        "<Leader>dp",
        function()
            require("dap.ui.widgets").preview()
        end
    )

    vim.keymap.set(
        "n",
        "<Leader>df",
        function()
            widgets.centered_float(widgets.frames)
        end
    )

    vim.keymap.set(
        "n",
        "<Leader>ds",
        function()
            widgets.centered_float(widgets.scopes)
        end
    )
end

function module.init()
    local dap = require("dap")
    vim.keymap.set(
        "n",
        "<Leader>dc",
        function()
            dap.continue()
        end,
        {silent = true}
    )
    vim.keymap.set(
        "n",
        "<down>",
        function()
            dap.step_over()
        end,
        {silent = true}
    )
    vim.keymap.set(
        "n",
        "<Leader>do",
        function()
            dap.step_over()
        end,
        {silent = true}
    )
    vim.keymap.set(
        "n",
        "<right>",
        function()
            dap.step_into()
        end,
        {silent = true}
    )
    vim.keymap.set(
        "n",
        "<Leader>di",
        function()
            dap.step_into()
        end,
        {silent = true}
    )
    vim.keymap.set(
        "n",
        "<left>",
        function()
            dap.step_back()
        end,
        {silent = true}
    )
    vim.keymap.set(
        "n",
        "<Leader>dx",
        function()
            dap.step_out()
        end,
        {silent = true}
    )
    vim.keymap.set(
        "n",
        "<Leader>db",
        function()
            dap.toggle_breakpoint()
        end,
        {silent = true}
    )
    vim.keymap.set("n", "<Leader>dt", ":DapTerminate<CR>", {silent = true})
    vim.keymap.set(
        "n",
        "<Leader>B",
        function()
            dap.set_breakpoint()
        end
    )
    vim.keymap.set(
        "n",
        "<Leader>lp",
        function()
            dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
        end
    )
    vim.keymap.set(
        "n",
        "<Leader>dr",
        function()
            dap.repl.open()
        end
    )
    vim.keymap.set(
        "n",
        "<Leader>dl",
        function()
            dap.run_last()
        end
    )
end

return module
