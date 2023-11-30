local module = {}

function module.config()
  local lualine = require('lualine')

  -- remove bold fonts and set a better colour for normal mode
  local theme = require('lualine.themes.gruvbox')
  theme.normal.a = { bg = '#666666', fg = '#ebdbb2' }
  theme.insert.a.gui = ''
  theme.command.a.gui = ''
  theme.visual.a.gui = ''

  lualine.setup {
    options = {
      icons_enabled = true,
      theme = theme,
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = true,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      }
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {{'filename', path = 1}, 'lsp_progress'},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
  }
end

return module
