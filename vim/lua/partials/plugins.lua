vim.g.mapleader = ',' -- setting leader before lazy so mappings are correct

local map = vim.api.nvim_set_keymap
require("lazy").setup({
  { 'mhartington/formatter.nvim', event = { 'VeryLazy' }},
	{ 'dstein64/vim-startuptime', cmd = 'StartupTime' },
  { 'github/copilot.vim', event = { 'VeryLazy' }, },
  { "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = require('partials/treesitter').config,
    event = { 'BufEnter' },
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
  { 'tpope/vim-fugitive', event = { 'VeryLazy' } },
  { 'neovim/nvim-lspconfig',
    config = function()
      require('partials/lsp')

      vim.api.nvim_exec([[
        hi LspReferenceText guibg=grey guifg=yellow
      ]], false)
    end,
    event = { 'VeryLazy' },
  },
	{ 'nvim-tree/nvim-tree.lua',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		init = require('partials/nerdtree').init,
		config = require('partials/nerdtree').config,
		cmd = { 'NvimTreeToggle', 'NvimTreeOpen', 'NvimTreeFindFile' },
    -- commit = 'ba1778e061f25814bc5940be886a7f41d7d7736e',
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
    event = { 'VeryLazy' }
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
  'airblade/vim-rooter',
  { 'johejo/gomod.vim', ft = { 'gomod' }},
  { 'rhysd/vim-go-impl', ft = { 'go' }},
  { 'martskins/vim-cargo-search', ft = { 'rust' }},
  { 'jparise/vim-graphql', ft = { 'graphql' }},
  { 'cespare/vim-toml', ft = { 'toml' }},
  { 'ellisonleao/gruvbox.nvim', lazy = false, config = function()
    require('gruvbox').setup({
      italic = false
    })
    require('gruvbox').load()
  end },
}, {
	defaults = {
		lazy = true
	}
})
