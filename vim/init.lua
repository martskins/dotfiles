vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' }
  use { 'junegunn/fzf.vim' }
  use { 'junegunn/fzf', run = vim.fn['fzf#install'] }
  use { 'hoob3rt/lualine.nvim' }
  use { 'neovim/nvim-lspconfig' }
  use { 'vim-test/vim-test' }
  use { 'preservim/nerdtree' }
  use { 'tpope/vim-abolish' }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-commentary' }
  use { 'tpope/vim-repeat' }
  use { 'tpope/vim-projectionist'}
	use { 'tpope/vim-fugitive' }
  use { 'majutsushi/tagbar' }
  use { 'machakann/vim-highlightedyank' }
  use { 'schickling/vim-bufonly' }
  use { 'hrsh7th/nvim-compe' }
  use { 'L3MON4D3/LuaSnip' }
  use { 'cespare/vim-toml', ft = { 'toml' }}
  use { 'davidhalter/jedi-vim', ft = { 'python' }}
  use { 'leafgarland/typescript-vim', ft = { 'typescript' }}
  use { 'peitalin/vim-jsx-typescript', ft = { 'typescript' }}
  use { 'pangloss/vim-javascript', ft = { 'javascript' }}
  use { 'plasticboy/vim-markdown', ft = { 'markdown' }}
  use { 'iamcco/markdown-preview.vim' , ft = { 'markdown' }}
  use { 'martskins/vim-cargo-search', ft = { 'rust' }}
  use { 'jparise/vim-graphql', ft = { 'graphql' }}
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'haze/sitruuna.vim',
		config = function ()
      vim.cmd[[
        colorscheme sitruuna
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
		end
	}
	use { 'kristijanhusak/orgmode.nvim' }
end)

require('partials/settings')
require('partials/mappings')
require('partials/lsp')
require('partials/fzf')
require('partials/completion')
require('partials/lualine')
require('partials/nerdtree')
require('partials/tagbar')
require('partials/projectionist')
require('partials/snips')

vim.cmd[[autocmd FileType lsp_markdown set filetype=markdown]]

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

require('orgmode').setup({
  org_agenda_files = { '~/dev/org/**/*' },
  org_default_notes_file =  '~/dev/org/notes.org' ,
})
