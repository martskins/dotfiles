vim.g.mapleader = ',' -- setting leader before lazy so mappings are correct

local map = vim.api.nvim_set_keymap
return {
  {
    'echasnovski/mini.statusline',
    event = { 'VeryLazy' },
    config = function()
      require('mini.statusline').setup()
    end
  },
  {
    'folke/trouble.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = { 'VeryLazy' },
    init = function()
      map('n', 'T', ':TroubleToggle<cr>', {})
    end
  },
  { 'mhartington/formatter.nvim',
    event = { 'VeryLazy' },
    cmd = { 'FormatWrite' },
    config = function()
      local group = vim.api.nvim_create_augroup('FormatAutogroup', { clear = true })
      vim.api.nvim_create_autocmd('BufWritePost', {
        group = group,
        command = 'FormatWrite'
      })
      require('formatter').setup {
        filetype = {
          graphql = { require('formatter.filetypes.graphql').prettier },
          dart = { require('formatter.filetypes.dart').dartformat },
          go = { require('formatter.filetypes.go').goimports },
          cpp = { require('formatter.filetypes.cpp').clangformat },
          c = { require('formatter.filetypes.cpp').clangformat },
          zig = { require('formatter.filetypes.zig').zigfmt },
          rust = {
            function()
              return {
                exe = "rustfmt",
                args = {"--emit=stdout"},
                stdin = true
              }
            end
          },
          javascript = { require('formatter.filetypes.javascript').prettier },
          typescript = { require('formatter.filetypes.typescript').prettier },
          javascriptreact = { require('formatter.filetypes.javascript').prettier },
          typescriptreact = { require('formatter.filetypes.typescript').prettier },
        }
      }
    end
  },
	{ 'dstein64/vim-startuptime', cmd = 'StartupTime' },
  { 'github/copilot.vim', ft = { 'go', 'rust', 'zig' } },
  { 'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = require('partials/treesitter').config,
    event = { 'VeryLazy' },
    enabled = true,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects'
    }
  },
  { 'ibhagwan/fzf-lua',
    init = require('partials/fzf').init,
    config = require('partials/fzf').config,
    cmd = { 'FzfLua' },
  },
  { 'vim-test/vim-test',
    ft = { 'go', 'rust' },
    init = function()
      map('n', '<leader>tt', ':TestNearest<cr>', {})
      map('n', '<leader>tT', ':TestFile<cr>', {})
      map('n', '<leader>ta', ':TestSuite<cr>', {})
      vim.api.nvim_exec([[
        let test#strategy = "neovim"
        let test#neovim#start_normal = 1
      ]], false)
    end,
  },
	{ 'tpope/vim-abolish', event = { 'VeryLazy' } },
  { 'tpope/vim-surround', event = { 'VeryLazy' } },
  { 'tpope/vim-commentary', event = { 'VeryLazy' } },
  { 'tpope/vim-repeat', event = { 'VeryLazy' } },
	{ 'tpope/vim-projectionist',
    init = require('partials/projectionist').init,
    config = require('partials/projectionist').config,
		event = { 'VeryLazy' },
  },
  { 'tpope/vim-rhubarb', event = { 'VeryLazy' } },
  { 'tpope/vim-fugitive', event = { 'VeryLazy' } },
  { 'neovim/nvim-lspconfig',
    config = function()
      require('partials/lsp')
    end,
    event = { 'VeryLazy' }, -- this one
    -- lazy = false,
  },
	{ 'nvim-tree/nvim-tree.lua',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		init = require('partials/nvim_tree').init,
		config = require('partials/nvim_tree').config,
		event = { 'VeryLazy' }, -- this one
    -- lazy = false,
	},
  { 'hrsh7th/vim-vsnip-integ', event = { 'VeryLazy' }},
  { 'hrsh7th/vim-vsnip', event = { 'VeryLazy' }},
	{ 'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/cmp-buffer',
    },
    config = require('partials/completion').config,
    event = { 'VeryLazy' } -- this one
    -- lazy = false,
  },
  { 'schickling/vim-bufonly',
    init = function()
      map('n', '<leader>bo', ':BufOnly<CR>', { silent = true })
    end,
    cmd = { 'BufOnly' }
  },
  { 'majutsushi/tagbar',
    init = require('partials/tagbar').init,
    config = require('partials/tagbar').config,
    cmd = { 'TagbarToggle' },
  },
  { 'airblade/vim-rooter', event = { 'VeryLazy' }},
  { 'johejo/gomod.vim', ft = { 'gomod' }},
  { 'rhysd/vim-go-impl', ft = { 'go' }},
  { 'martskins/vim-cargo-search', ft = { 'rust' }},
  { 'jparise/vim-graphql', ft = { 'graphql' }},
  { 'cespare/vim-toml', ft = { 'toml' }},
  { 'ellisonleao/gruvbox.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      require('gruvbox').setup({
        italic = {
          strings = false,
          comments = false,
          operators = false,
          folds = false,
        },
        bold = false,
        contrast = "high"
      })
      require('gruvbox').load()
    end
  },
}
