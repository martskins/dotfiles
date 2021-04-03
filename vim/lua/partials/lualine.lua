require('lualine').setup{
  options = {
    theme = 'gruvbox',
  },
  sections = {
    lualine_y = {
      {
        'diagnostics',
        sources = { 'nvim_lsp' },
        color_error = '#FF3333',
        symbols = {
          error = 'E',
          warn = 'W',
          info = 'I',
        },
      }
    },
    lualine_x = { 'filetype' }
  },
  extensions = { 'fzf', 'nerdtree' },
}
