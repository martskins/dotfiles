require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' }

  -- use { 'mfussenegger/nvim-dap' }
  -- use { 'leoluz/nvim-dap-go', ft = { 'go' }, config = function()
  --   require('dap-go').setup()
  -- end }
  use { 'github/copilot.vim' }
  use { 'nvim-treesitter/nvim-treesitter' }
  use { 'junegunn/fzf.vim' }
  use { 'junegunn/fzf', run = vim.fn['fzf#install'] }
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

  use { 'ellisonleao/gruvbox.nvim', config = function()
    require('gruvbox').load()
  end }

  -- use { 'chriskempson/base16-vim', config = function()
  --   vim.cmd [[
  --     let $BAT_THEME = 'zenburn'
  --     colorscheme base16-gruvbox-dark-hard
  --     hi Normal                           ctermbg=black guibg=#101010
  --     hi LspDiagnosticsDefaultError       ctermbg=red guifg=red
  --     hi LspDiagnosticsDefaultWarning     ctermbg=166 guifg=orange
  --     hi LspDiagnosticsUnderlineError     gui=underline
  --     hi LspDiagnosticsUnderlineWarning   gui=underline
  --     hi LspReferenceText                 ctermbg=magenta guibg=#383838
  --     hi LspReferenceRead                 ctermbg=magenta guibg=#383838
  --     hi LspReferenceWrite                ctermbg=magenta guibg=#383838
  --     hi ExtraWhitespace                  ctermbg=red
  --     hi link mkdLineBreak                Pmenu
  --   ]]
  -- end }
end)
