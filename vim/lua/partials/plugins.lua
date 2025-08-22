vim.g.mapleader = "," -- setting leader before lazy so mappings are correct

local map = vim.api.nvim_set_keymap

return {
    {
        "jbyuki/instant.nvim",
        event = {"VeryLazy"},
        config = function()
            vim.api.nvim_exec([[ let g:instant_username = 'martin' ]], false)
            -- require("instant").setup({})
        end
    },
    {
        "echasnovski/mini.indentscope",
        version = false,
        event = {"VeryLazy"},
        config = require("partials/mini_indentscope").config
    },
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
        "folke/trouble.nvim",
        cmd = {"Trouble"},
        init = require("partials/trouble").init,
        config = require("partials/trouble").config
    },
    {
        "mhartington/formatter.nvim",
        cmd = {"FormatWrite"},
        init = require("partials/formatter").init,
        config = require("partials/formatter").config
    },
    {"dstein64/vim-startuptime", cmd = {"StartupTime"}},
    {
        "github/copilot.vim",
        ft = {"go", "rust", "zig", "cpp", "typescript", "typescriptreact"},
        init = require("partials/copilot").init
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        lazy = true,
        cmd = {"CopilotChat", "CopilotChatModels"},
        dependencies = {
            {"github/copilot.vim"},
            {"nvim-lua/plenary.nvim", branch = "master"} -- for curl, log and async functions
        },
        build = "make tiktoken",
        opts = {
            sticky = {
                "#buffer"
            }
        },
        config = require("partials/copilot_chat").config
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
        init = require("partials/vim_test").init
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
        "stevearc/oil.nvim",
        event = {"VeryLazy"},
        config = require("partials/oil").config
    },
    {
        "schickling/vim-bufonly",
        init = require("partials/vim_bufonly").init,
        cmd = {"BufOnly"}
    },
    {
        "airblade/vim-rooter",
        ft = {"go", "rust", "zig"},
        init = require("partials/vim_rooter").init
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
                        -- Normal = {bg = "#000000"},
                        -- Comment = {fg = "#AB7441"}
                        Comment = {fg = "#fc9403"}
                    }
                }
            )
            vim.cmd([[
              colorscheme gruvbox
            ]])
        end
    },
    {
        "epwalsh/obsidian.nvim",
        version = "*",
        lazy = true,
        ft = "markdown",
        cmd = {
            "ObsidianNew",
            "ObsidianOpen"
        },
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        opts = {
            workspaces = {
                {
                    name = "work",
                    path = "~/Documents/work"
                }
            }
        }
    }
    -- {
    --     "yanskun/gotests.nvim",
    --     event = {"VeryLazy"},
    --     ft = {"go"},
    --     config = function()
    --         require("gotests").setup()
    --     end
    -- }
}
