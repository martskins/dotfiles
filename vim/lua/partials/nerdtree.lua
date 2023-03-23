local module = {}

function module.config()
  require('nvim-tree').setup {
    sort_by = "case_sensitive",
    hijack_cursor = true,
    diagnostics = {
      enable = true,
    },
    view = {
      adaptive_size = true,
      mappings = {
        list = {
          { key = "u", action = "dir_up" },
        },
      },
    },
    renderer = {
      group_empty = true,
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
      },
    },
    filters = {
      dotfiles = true,
    },
    actions = {
      open_file = {
        quit_on_open = true,
      }
    }
  }
end

function module.init()
  local map = vim.api.nvim_set_keymap
  map('n', '<C-n>', ':NvimTreeToggle<CR>', { silent = true })
  map('n', '-', ':NvimTreeFindFileToggle<CR>', { silent = true })
end

return module
