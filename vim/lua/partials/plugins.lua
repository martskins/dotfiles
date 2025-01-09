vim.g.mapleader = "," -- setting leader before lazy so mappings are correct

local map = vim.api.nvim_set_keymap
return {
    {
        "mfussenegger/nvim-dap",
        cmd = {"DapContinue", "DapToggleBreakpoint", "DapToggleUi"},
        config = require("partials/ndap").config,
        init = require("partials/ndap").init
    },
    {
        "rcarriga/nvim-dap-ui",
        cmd = {"DapContinue", "DapToggleBreakpoint", "DapToggleUi"},
        config = require("partials/dapui").config,
        init = require("partials/dapui").init,
        dependencies = {
            "nvim-neotest/nvim-nio"
        }
    },
    {
        "nvim-lualine/lualine.nvim",
        event = {"BufEnter"},
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "arkav/lualine-lsp-progress"
        },
        config = require("partials/lualine").config
    },
    {
        "folke/trouble.nvim",
        cmd = {"Trouble"},
        init = function()
            map("n", "T", ":Trouble diagnostics toggle<cr>", {silent = true})
            map("n", ",.", ":Trouble symbols toggle<cr>", {silent = true})
        end,
        config = function()
            require("trouble").setup {
                auto_preview = false,
                cycle_results = false,
                focus = true
            }
        end
    },
    {
        "mhartington/formatter.nvim",
        cmd = {"FormatWrite"},
        init = function()
            local group = vim.api.nvim_create_augroup("FormatAutogroup", {clear = true})
            vim.api.nvim_create_autocmd(
                "BufWritePost",
                {
                    group = group,
                    command = "FormatWrite"
                }
            )
        end,
        config = function()
            require("formatter").setup {
                filetype = {
                    lua = {require("formatter.filetypes.lua").luafmt},
                    terraform = {require("formatter.filetypes.terraform").terraformfmt},
                    cs = {require("formatter.filetypes.cs").clangformat},
                    graphql = {require("formatter.filetypes.graphql").prettier},
                    proto = {require("formatter.filetypes.proto").buf_format},
                    dart = {require("formatter.filetypes.dart").dartformat},
                    go = {require("formatter.filetypes.go").goimports},
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
        end
    },
    {"dstein64/vim-startuptime", cmd = {"StartupTime"}},
    {
        "github/copilot.vim",
        ft = {"go", "rust", "zig", "cpp", "typescript"},
        config = function()
            vim.keymap.set(
                "i",
                "<C-f>",
                'copilot#Accept("\\<CR>")',
                {
                    expr = true,
                    replace_keycodes = false
                }
            )
            vim.g.copilot_no_tab_map = true
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = require("partials/treesitter").config,
        enabled = true,
        event = {"VeryLazy"},
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects"
        }
    },
    {
        "ibhagwan/fzf-lua",
        init = require("partials/fzf").init,
        config = require("partials/fzf").config,
        cmd = {"FzfLua"}
    },
    {
        "vim-test/vim-test",
        ft = {"go", "rust", "zig", "cpp"},
        init = function()
            map("n", "<leader>tt", ":TestNearest<cr>", {})
            map("n", "<leader>tp", ":TestFile<cr>", {})
            map("n", "<leader>ta", ":TestSuite<cr>", {})
            vim.api.nvim_exec(
                [[
           let test#strategy = "neovim"
           let test#neovim#start_normal = 1
         ]],
                false
            )
        end
    },
    {"tpope/vim-abolish", event = {"VeryLazy"}},
    {"tpope/vim-surround", event = {"VeryLazy"}},
    {"tpope/vim-repeat", event = {"VeryLazy"}},
    {
        "tpope/vim-projectionist",
        init = require("partials/projectionist").init,
        config = require("partials/projectionist").config,
        event = {"VeryLazy"}
    },
    {"tpope/vim-rhubarb", event = {"VeryLazy"}},
    {"tpope/vim-fugitive", event = {"VeryLazy"}},
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("partials/lsp")
        end,
        event = {"BufEnter"}
    },
    {
        "stevearc/oil.nvim",
        event = {"VeryLazy"},
        config = function()
            require("oil").setup(
                {
                    delete_to_trash = true
                }
            )
            vim.keymap.set("n", "-", "<CMD>Oil<CR>", {desc = "Open parent directory"})
        end
    },
    {"hrsh7th/vim-vsnip-integ", event = {"VeryLazy"}},
    {"hrsh7th/vim-vsnip", event = {"VeryLazy"}},
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/cmp-buffer"
        },
        config = require("partials/completion").config,
        event = {"BufEnter"}
    },
    {
        "schickling/vim-bufonly",
        init = function()
            map("n", "<leader>bo", ":BufOnly<CR>", {silent = true})
        end,
        cmd = {"BufOnly"}
    },
    {
        "preservim/tagbar",
        init = require("partials/tagbar").init,
        config = require("partials/tagbar").config,
        cmd = {"TagbarToggle"}
    },
    {
        "airblade/vim-rooter",
        ft = {"go", "rust", "zig"}
    },
    {"johejo/gomod.vim", ft = {"gomod"}},
    {"rhysd/vim-go-impl", ft = {"go"}},
    {"martskins/vim-cargo-search", ft = {"rust"}},
    {"jparise/vim-graphql", ft = {"graphql"}},
    {"cespare/vim-toml", ft = {"toml"}},
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        lazy = false,
        config = function()
            require("gruvbox").setup(
                {
                    transparent_mode = false,
                    italic = {
                        strings = false,
                        comments = false,
                        operators = false,
                        folds = false
                    },
                    bold = false,
                    contrast = "hard",
                    overrides = {
                        Normal = {bg = "#000000"}
                    }
                }
            )
            vim.cmd([[
        colorscheme gruvbox
      ]])
        end
    }
}
