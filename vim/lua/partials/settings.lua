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
-- o.more = true
o.timeoutlen = 1000
o.ttimeoutlen = 0
o.encoding = 'utf-8'
o.shell = '/usr/local/bin/fish'
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
o.pastetoggle = '<leader>z'
o.clipboard = 'unnamedplus,unnamed'
o.ignorecase = true
o.history = 100
o.hlsearch = true
o.showmatch = true
o.wildmenu = true
o.updatetime = 300
o.autoread = true
o.ttyfast = true
o.termguicolors = true
o.background = 'dark'
o.shortmess = 'F'
o.mouse = 'a'

local wo = vim.wo
wo.number = true
wo.relativenumber = true
wo.signcolumn = 'yes'
