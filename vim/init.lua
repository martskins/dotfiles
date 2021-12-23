vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' }
  use { 'junegunn/fzf.vim' }
  use { 'junegunn/fzf', run = vim.fn['fzf#install'] }
  use { 'vim-test/vim-test' }
  use { 'rhysd/vim-go-impl', ft = { 'go' } }
  use { 'sk1418/QFGrep' }
  -- use { 'puremourning/vimspector' }
  use { 'tpope/vim-abolish' }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-commentary' }
  use { 'tpope/vim-repeat' }
  use { 'tpope/vim-projectionist'}
	use { 'tpope/vim-fugitive' }
  use { 'neovim/nvim-lspconfig' }
  use { 'tommcdo/vim-exchange' }
  use { 'kyazdani42/nvim-tree.lua',
    config = { nvim_tree_show_icons = { icons = 0 } },
  }
  use { 'hrsh7th/vim-vsnip-integ' }
  use { 'hrsh7th/vim-vsnip' }
  use { 'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
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
  command! PS PackerSync
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

vim.cmd[[
    nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
    nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
    nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
    nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
    nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
    nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
    nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
    nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
    nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>
    ]]
