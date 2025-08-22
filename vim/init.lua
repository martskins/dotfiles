vim.pack.add(
    {
        "https://github.com/jbyuki/instant.nvim",
        "https://github.com/echasnovski/mini.indentscope",
        "https://github.com/mfussenegger/nvim-dap",
        "https://github.com/nvim-neotest/nvim-nio", -- dependency for nvim-dap-ui
        "https://github.com/rcarriga/nvim-dap-ui",
        "https://github.com/folke/trouble.nvim",
        "https://github.com/mhartington/formatter.nvim",
        "https://github.com/dstein64/vim-startuptime",
        "https://github.com/github/copilot.vim",
        "https://github.com/nvim-lua/plenary.nvim", -- dependency for CopilotChat.nvim
        "https://github.com/CopilotC-Nvim/CopilotChat.nvim",
        "https://github.com/nvim-treesitter/nvim-treesitter",
        "https://github.com/ibhagwan/fzf-lua",
        "https://github.com/vim-test/vim-test",
        "https://github.com/tpope/vim-abolish",
        "https://github.com/tpope/vim-surround",
        "https://github.com/tpope/vim-repeat",
        "https://github.com/tpope/vim-projectionist",
        "https://github.com/tpope/vim-rhubarb",
        "https://github.com/tpope/vim-fugitive",
        "https://github.com/stevearc/oil.nvim",
        "https://github.com/schickling/vim-bufonly",
        "https://github.com/airblade/vim-rooter",
        "https://github.com/johejo/gomod.vim",
        "https://github.com/rhysd/vim-go-impl",
        "https://github.com/martskins/vim-cargo-search",
        "https://github.com/jparise/vim-graphql",
        "https://github.com/cespare/vim-toml",
        "https://github.com/ellisonleao/gruvbox.nvim",
        -- "https://github.com/maxmx03/solarized.nvim",
        "https://github.com/vim-scripts/dbext.vim"
    }
)

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

vim.cmd [[ colorscheme gruvbox ]]
-- vim.cmd.colorscheme("solarized")

require("partials/settings")
require("partials/mappings")
require("partials/lsp")
require("partials/mini_indentscope")
require("partials/treesitter")
require("partials/tagbar")
require("partials/projectionist")
require("partials/ndap")
require("partials/dapui")
require("partials/fzf")
require("partials/trouble")
require("partials/formatter")
require("partials/copilot")
require("partials/copilot_chat")
require("partials/vim_test")
require("partials/oil")
require("partials/vim_bufonly")
require("partials/vim_rooter")
