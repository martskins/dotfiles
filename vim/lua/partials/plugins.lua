require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' }

  use { 'lewis6991/impatient.nvim' }
  use { 'dstein64/vim-startuptime' }
  use { 'github/copilot.vim' }
  use { 'nvim-treesitter/nvim-treesitter' }
  use { 'ibhagwan/fzf-lua' }
  use { 'vim-test/vim-test', ft = { 'go', 'rust' } }
  use { 'tpope/vim-abolish' }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-commentary' }
  use { 'tpope/vim-repeat' }
  use { 'tpope/vim-projectionist' }
  use { 'tpope/vim-fugitive' }
  use { 'neovim/nvim-lspconfig' }
  use { 'preservim/nerdtree' }
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
    require('gruvbox').load()
  end }
end)
