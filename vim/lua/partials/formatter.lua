require("formatter").setup {
    filetype = {
        lua = {require("formatter.filetypes.lua").luafmt},
        terraform = {require("formatter.filetypes.terraform").terraformfmt},
        cs = {require("formatter.filetypes.cs").clangformat},
        graphql = {require("formatter.filetypes.graphql").prettier},
        proto = {require("formatter.filetypes.proto").buf_format},
        dart = {require("formatter.filetypes.dart").dartformat},
        go = {
            require("formatter.filetypes.go").gofumpt,
            function()
                return {
                    exe = "goimports",
                    stdin = true,
                    args = {"-local", "github.com/utilitywarehouse/cbc-mono"}
                }
            end
        },
        cpp = {require("formatter.filetypes.cpp").clangformat},
        c = {require("formatter.filetypes.cpp").clangformat},
        zig = {require("formatter.filetypes.zig").zigfmt},
        rust = {
            function()
                return {
                    exe = "rustfmt",
                    args = {"--emit=stdout", "--edition=2021"},
                    stdin = true
                }
            end
        },
        javascript = {require("formatter.filetypes.javascript").prettier},
        typescript = {require("formatter.filetypes.typescript").prettier},
        javascriptreact = {require("formatter.filetypes.javascript").prettier},
        typescriptreact = {require("formatter.filetypes.typescript").prettier}
    }
}

local group = vim.api.nvim_create_augroup("FormatAutogroup", {clear = true})
vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        group = group,
        command = "FormatWrite"
    }
)
