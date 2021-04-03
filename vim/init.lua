vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' }
  use { 'junegunn/fzf', run = vim.fn['fzf#install'] }
  use { 'junegunn/fzf.vim' }
  use { 'hoob3rt/lualine.nvim' }
  use { 'neovim/nvim-lspconfig' }
  use { 'vim-test/vim-test' }
  use { 'preservim/nerdtree' }
  use { 'tpope/vim-abolish' }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-commentary' }
  use { 'tpope/vim-repeat' }
  use { 'majutsushi/tagbar' }
  use { 'tpope/vim-projectionist'}
  use { 'machakann/vim-highlightedyank' }
  use { 'schickling/vim-bufonly' }
  use { 'hrsh7th/nvim-compe' }
  use { 'hrsh7th/vim-vsnip' }
  use { 'hrsh7th/vim-vsnip-integ' }
  use { 'chriskempson/base16-vim',
    config = function()
      vim.cmd[[
        colorscheme base16-gruvbox-dark-hard
        hi Pmenu                            guibg=#333333 guifg=white
        hi Normal                           guibg=#131313
        hi Todo                             ctermbg=none ctermfg=yellow guibg=none guifg=#fabd2f
        hi Error                            ctermbg=none ctermfg=red guibg=none guifg=red
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
  use { 'cespare/vim-toml', ft = { 'toml' }}
  use { 'davidhalter/jedi-vim', ft = { 'python' }}
  use { 'leafgarland/typescript-vim', ft = { 'typescript' }}
  use { 'peitalin/vim-jsx-typescript', ft = { 'typescript' }}
  use { 'pangloss/vim-javascript', ft = { 'javascript' }}
  use { 'plasticboy/vim-markdown', ft = { 'markdown' }}
  use { 'iamcco/markdown-preview.vim' , ft = { 'markdown' }}
  use { 'martskins/vim-cargo-search', ft = { 'rust' }}
  use { 'jparise/vim-graphql', ft = { 'graphql' }}
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

vim.cmd[[autocmd FileType lsp_markdown set filetype=markdown]]
