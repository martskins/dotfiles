local g = vim.g
g.ftplugin_sql_omni_key = '<C-j>'
g.mapleader = ','
g.loaded_python_provider = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.python3_host_prog = '/usr/local/bin/python3'

local o = vim.o
o.binary = true
o.showmatch = false
o.modeline = false
o.timeoutlen = 1000
o.ttimeoutlen = 0
o.encoding = 'utf-8'
o.shell = '/bin/bash'
o.guifont = 'monospace'
o.backup = false
o.hidden = true
o.swapfile = false
o.belloff = 'all'
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.backspace = 'indent,eol,start'
o.autoindent = true
-- o.pastetoggle = '<leader>z'
-- o.clipboard = 'unnamedplus,unnamed'
o.ignorecase = true
o.history = 100
o.hlsearch = true
o.wildmenu = true
o.updatetime = 300
o.autoread = true
o.ttyfast = true
o.shortmess = 'F'
o.mouse = 'a'
o.completeopt = 'noinsert,menuone,noselect'
o.termguicolors = true
o.background = 'dark'
o.foldenable = false
o.cmdheight = 1
o.cursorline = true
o.smartcase = true
o.colorcolumn='+1'
o.textwidth = 100

local wo = vim.wo
wo.number = true
wo.relativenumber = true
wo.signcolumn = 'yes'

-- disable unnecessary builtin plugins
g.loaded_gzip = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_2html_plugin = 1
g.loaded_matchit = 1
g.loaded_matchparen = 1
g.loaded_logiPat = 1
g.loaded_rrhelper = 1
g.loaded_spellfile_plugin = 1
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_netrwFileHandlers = 1

vim.api.nvim_exec([[
  hi LspReferenceText guibg=grey guifg=red
  hi QuickFixLine guibg=none
  hi ColorColumn guibg=#AA0000

  "colorscheme lunaperche
  syntax off
]], false)
