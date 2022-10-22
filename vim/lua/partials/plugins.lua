_G.__luacache_config = {
  chunks = {
    enable = true,
    path = vim.fn.stdpath('cache')..'/luacache_chunks',
  },
  modpaths = {
    enable = true,
    path = vim.fn.stdpath('cache')..'/luacache_modpaths',
  }
}
require('impatient')

require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' }

  use { 'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require("null-ls").setup({
        sources = {
          require("null-ls").builtins.formatting.prettier,
          require("null-ls").builtins.diagnostics.eslint,
        },
      })
    end,
    requires = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
    },
  }
  use { 'lewis6991/impatient.nvim' }
  use { 'dstein64/vim-startuptime' }
  use { 'github/copilot.vim' }
  use { 'nvim-treesitter/nvim-treesitter' }
  use { 'nvim-treesitter/playground' }
  use { 'ibhagwan/fzf-lua' }
  use { 'vim-test/vim-test', ft = { 'go', 'rust' } }
  use { 'tpope/vim-abolish' }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-commentary' }
  use { 'tpope/vim-repeat' }
  use { 'tpope/vim-projectionist' }
  use { 'tpope/vim-fugitive' }
  use { 'neovim/nvim-lspconfig', config = function()
    vim.api.nvim_exec([[
      hi LspReferenceText guibg=grey guifg=yellow
    ]], false)
  end }
  use { 'nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons' },
  }
  use { 'hrsh7th/vim-vsnip-integ' }
  use { 'hrsh7th/vim-vsnip' }
  use { 'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-vsnip',
    }
  }
  use { 'schickling/vim-bufonly' }
  use { 'majutsushi/tagbar' }
  use { 'airblade/vim-rooter' }
  use { 'rhysd/vim-go-impl', ft = { 'go' } }
  use { 'martskins/vim-cargo-search', ft = { 'rust' } }
  use { 'jparise/vim-graphql', ft = { 'graphql' } }
  use { 'cespare/vim-toml', ft = { 'toml' } }
  use { 'tyru/open-browser-github.vim', requires = { 'tyru/open-browser.vim' } }

  use { 'ellisonleao/gruvbox.nvim', config = function()
    require('gruvbox').setup({
      italic = false
    })
    require('gruvbox').load()
  end }
end)
