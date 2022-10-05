_G.__luacache_config = {
  chunks = {
    enable = true,
    path = vim.fn.stdpath('cache') .. '/luacache_chunks',
  },
  modpaths = {
    enable = true,
    path = vim.fn.stdpath('cache') .. '/luacache_modpaths',
  }
}
require('impatient')

require('partials/plugins')
require('partials/settings')
require('partials/fzf')
require('partials/nerdtree')
require('partials/mappings')
require('partials/lsp')
require('partials/projectionist')
require('partials/completion')
require('partials/tagbar')
require('partials/treesitter')
