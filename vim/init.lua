vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' }
  use { 'junegunn/fzf.vim' }
  use { 'junegunn/fzf', run = vim.fn['fzf#install'] }
  use { 'hoob3rt/lualine.nvim' }
  use { 'neovim/nvim-lspconfig' }
  use { 'vim-test/vim-test' }
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = {
      nvim_tree_show_icons = {
          icons = 1,
      }
    }
  }
  use { 'tpope/vim-abolish' }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-commentary' }
  use { 'tpope/vim-repeat' }
  use { 'tpope/vim-projectionist'}
	use { 'tpope/vim-fugitive' }
  use { 'majutsushi/tagbar' }
  use { 'machakann/vim-highlightedyank' }
  use { 'schickling/vim-bufonly' }
  use { 'hrsh7th/vim-vsnip-integ' }
  use { 'hrsh7th/vim-vsnip' }
  use { 'rafamadriz/friendly-snippets' }
  use { 'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-vsnip',
    },
  }
  use { 'cespare/vim-toml', ft = { 'toml' }}
  use { 'leafgarland/typescript-vim', ft = { 'typescript' }}
  use { 'peitalin/vim-jsx-typescript', ft = { 'typescript' }}
  use { 'pangloss/vim-javascript', ft = { 'javascript' }}
  use { 'plasticboy/vim-markdown', ft = { 'markdown' }}
  use { 'iamcco/markdown-preview.vim' , ft = { 'markdown' }}
  use { 'martskins/vim-cargo-search', ft = { 'rust' }}
  use { 'jparise/vim-graphql', ft = { 'graphql' }}
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'airblade/vim-rooter' }
  use { 'chriskempson/base16-vim', config = function()
      -- let $BAT_THEME = 'gruvbox-light'
      -- colorscheme base16-gruvbox-light-hard
    vim.cmd [[
      let $BAT_THEME = 'gruvbox'
      colorscheme base16-gruvbox-dark-hard
      hi LspDiagnosticsDefaultError       guifg=red
      hi LspDiagnosticsDefaultWarning     guifg=orange
      hi LspDiagnosticsUnderlineError     gui=underline
      hi LspDiagnosticsUnderlineWarning   gui=underline
      hi LspReferenceText                 guibg=#383838
      hi LspReferenceRead                 guibg=#383838
      hi LspReferenceWrite                guibg=#383838
      hi ExtraWhitespace                  ctermbg=red
      hi link mkdLineBreak                Pmenu
    ]]
  end }
end)

vim.cmd[[
  let g:rooter_patterns = ['.git', 'Makefile', '*.sln', 'build/env.sh']
  let g:rooter_resolve_links = 1
]]

local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

require('partials/settings')
require('partials/mappings')
require('partials/lsp')
require('partials/fzf')
require('partials/completion')
require('partials/lualine')
require('partials/nerdtree')
require('partials/tagbar')
require('partials/projectionist')
require'nvim-web-devicons'.setup { default = true; }

vim.cmd[[autocmd FileType lsp_markdown set filetype=markdown]]
vim.cmd([[autocmd BufWritePost init.lua source <afile> | PackerCompile]])

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
