require("lazy").setup({
  'mhartington/formatter.nvim',
  'lewis6991/impatient.nvim',
  'dstein64/vim-startuptime',
  'github/copilot.vim',
  { "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "c", "lua", "rust", "go", "vim" },
        highlight = { enable = true, }
      }
    end
  },
  'ibhagwan/fzf-lua',
  { 'vim-test/vim-test', ft = { 'go', 'rust' }},
  'tpope/vim-abolish',
  'tpope/vim-surround',
  'tpope/vim-commentary',
  'tpope/vim-repeat',
  'tpope/vim-projectionist',
  'tpope/vim-fugitive',
  { 'neovim/nvim-lspconfig', config = function()
    vim.api.nvim_exec([[
      hi LspReferenceText guibg=grey guifg=yellow
    ]], false)
  end },
  'nvim-tree/nvim-tree.lua',
    'nvim-tree/nvim-web-devicons',
  'hrsh7th/vim-vsnip-integ',
  'hrsh7th/vim-vsnip',
  'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/cmp-buffer',
  'schickling/vim-bufonly',
  'majutsushi/tagbar',
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
})
