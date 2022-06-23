vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' }

  use { 'github/copilot.vim' }
  use { 'nvim-treesitter/nvim-treesitter' }
  use { 'mfussenegger/nvim-dap' }
  use { 'leoluz/nvim-dap-go' }
  use { 'junegunn/fzf.vim' }
  use { 'junegunn/fzf', run = vim.fn['fzf#install'] }
  use { 'vim-test/vim-test' }
  use { 'tpope/vim-abolish' }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-commentary' }
  use { 'tpope/vim-repeat' }
  use { 'tpope/vim-projectionist'}
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
    },
  }
  use { 'schickling/vim-bufonly' }
  use { 'majutsushi/tagbar' }
  use { 'airblade/vim-rooter' }
  use { 'rhysd/vim-go-impl', ft = { 'go' } }
  use { 'martskins/vim-cargo-search', ft = { 'rust' }}
  use { 'jparise/vim-graphql', ft = { 'graphql' }}
  use { 'cespare/vim-toml', ft = { 'toml' }}
  use { 'chriskempson/base16-vim', config = function()
    vim.cmd [[
      let $BAT_THEME = 'zenburn'
      colorscheme base16-gruvbox-dark-hard
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
  " the macro in f converts a struct field to a cli.Flag
  let @f='0wwcw0wPli 0wi&cli.l~eliFlag{Name:lli"ebyweli"bcrkf"li, EnvVars:[]string{"pbcrsgUweli"}, Destination: &cfg.pbeli, Required: true},'
  let g:rooter_patterns = ['.git', 'Makefile', '*.sln', 'build/env.sh']
  let g:rooter_resolve_links = 0

  function! RangeSearch(direction)
    call inputsave()
    let g:srchstr = input(a:direction)
    call inputrestore()
    if strlen(g:srchstr) > 0
      let g:srchstr = g:srchstr.
            \ '\%>'.(line("'<")-1).'l'.
            \ '\%<'.(line("'>")+1).'l'
    else
      let g:srchstr = ''
    endif
  endfunction
  vnoremap <silent> / :<C-U>call RangeSearch('/')<CR>:if strlen(g:srchstr) > 0\|exec '/'.g:srchstr\|endif<CR>
  vnoremap <silent> ? :<C-U>call RangeSearch('?')<CR>:if strlen(g:srchstr) > 0\|exec '?'.g:srchstr\|endif<CR>
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
require('partials/dap')
require('partials/treesitter')
