vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' }
  use { 'junegunn/fzf.vim' }
  use { 'junegunn/fzf', run = vim.fn['fzf#install'] }
  use { 'vim-test/vim-test' }
  use { 'rhysd/vim-go-impl', ft = { 'go' } }
  use { 'sk1418/QFGrep' }
  use { 'tpope/vim-abolish' }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-commentary' }
  use { 'tpope/vim-repeat' }
  use { 'tpope/vim-projectionist'}
	use { 'tpope/vim-fugitive' }
  use { 'neovim/nvim-lspconfig' }
  use { 'kyazdani42/nvim-tree.lua' }
  use { 'hrsh7th/vim-vsnip-integ' }
  use { 'hrsh7th/vim-vsnip' }
  use { 'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-vsnip',
    },
  }
  use { 'schickling/vim-bufonly' }
  use { 'majutsushi/tagbar' }
  use { 'martskins/vim-cargo-search', ft = { 'rust' }}
  use { 'jparise/vim-graphql', ft = { 'graphql' }}
  use { 'airblade/vim-rooter' }
  use { 'cespare/vim-toml', ft = { 'toml' }}
  use { 'chriskempson/base16-vim', config = function()
    vim.cmd [[
      let $BAT_THEME = 'zenburn'
      colorscheme peachpuff
      hi Search                           ctermfg=black ctermbg=178 guibg=yellow
      hi Type                             ctermfg=28 guibg=red
      hi Special                          ctermfg=red guibg=red
      hi Title                            ctermfg=red guibg=red
      hi Pmenu                            ctermbg=darkgrey guibg=darkgrey
      hi Normal                           ctermbg=black guibg=#101010
      hi LspDiagnosticsDefaultError       ctermbg=red guifg=red
      hi LspDiagnosticsDefaultWarning     ctermbg=166 guifg=orange
      hi LspDiagnosticsUnderlineError     gui=underline
      hi LspDiagnosticsUnderlineWarning   gui=underline
      hi LspReferenceText                 ctermbg=magenta guibg=#383838
      hi LspReferenceRead                 ctermbg=magenta guibg=#383838
      hi LspReferenceWrite                ctermbg=magenta guibg=#383838
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
require('partials/fzf')
require('partials/nerdtree')
require('partials/mappings')
require('partials/lsp')
require('partials/projectionist')
require('partials/completion')
require('partials/tagbar')
