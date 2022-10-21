require('nvim-tree').setup {
  sort_by = "case_sensitive",
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

local map = vim.api.nvim_set_keymap
map('n', '<C-n>', ':NvimTreeToggle<CR>', { silent = true })
map('n', '-', ':NvimTreeFindFile<CR>', { silent = true })
