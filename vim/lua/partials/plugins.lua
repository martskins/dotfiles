vim.g.mapleader = ',' -- setting leader before lazy so mappings are correct

local map = vim.api.nvim_set_keymap
return {
  { 'takac/vim-hardtime',
    event = { 'VeryLazy' },
    init = function()
      -- vim.api.nvim_exec([[ let g:hardtime_default_on = 1 ]], false)
    end
  },
  { 'mfussenegger/nvim-dap',
    cmd = { 'DapContinue', 'DapToggleBreakpoint', 'DapToggleUi' },
    config = require('partials/ndap').config,
    init = require('partials/ndap').init,
    lazy = false,
  },
  { 'rcarriga/nvim-dap-ui',
    cmd = { 'DapContinue', 'DapToggleBreakpoint', 'DapToggleUi' },
    config = require('partials/dapui').config,
    init = require('partials/dapui').init,
    dependencies = {
      'nvim-neotest/nvim-nio'
    },
    lazy = false,
  },
  {
    'nvim-lualine/lualine.nvim',
    event = { 'BufEnter' },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'arkav/lualine-lsp-progress'
    },
    config = require('partials/lualine').config,
  },
  {
    'folke/trouble.nvim',
    cmd = { 'TroubleToggle' },
    init = function()
      map('n', 'T', ':TroubleToggle<cr>', { silent = true })
    end,
    config = function()
      require('trouble').setup {
        icons = false,
        auto_preview = false,
        cycle_results = false,
      }
    end
  },
  { 'mhartington/formatter.nvim',
    cmd = { 'FormatWrite' },
    init = function()
      local group = vim.api.nvim_create_augroup('FormatAutogroup', { clear = true })
      vim.api.nvim_create_autocmd('BufWritePost', {
        group = group,
        command = 'FormatWrite'
      })
    end,
    config = function()
      require('formatter').setup {
        filetype = {
          terraform = { require('formatter.filetypes.terraform').terraformfmt },
          cs = { require('formatter.filetypes.cs').clangformat },
          graphql = { require('formatter.filetypes.graphql').prettier },
          proto = { require('formatter.filetypes.proto').buf_format },
          dart = { require('formatter.filetypes.dart').dartformat },
          go = { require('formatter.filetypes.go').goimports },
          cpp = { require('formatter.filetypes.cpp').clangformat },
          c = { require('formatter.filetypes.cpp').clangformat },
          zig = { require('formatter.filetypes.zig').zigfmt },
          rust = {
            function()
              return {
                exe = "rustfmt",
                args = {"--emit=stdout", '--edition=2021'},
                stdin = true
              }
            end
          },
          javascript = { require('formatter.filetypes.javascript').prettier },
          typescript = { require('formatter.filetypes.typescript').prettier },
          javascriptreact = { require('formatter.filetypes.javascript').prettier },
          typescriptreact = { require('formatter.filetypes.typescript').prettier },
        }
      }
    end
  },
	{ 'dstein64/vim-startuptime', cmd = { 'StartupTime' }},
  { 'github/copilot.vim',
    ft = { 'go', 'rust', 'zig', 'cpp', 'typescript'},
    config = function()
      vim.keymap.set('i', '<C-f>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false
      })
      vim.g.copilot_no_tab_map = true
    end
  },
  { 'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = require('partials/treesitter').config,
    enabled = true,
    event = { 'VeryLazy' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects'
    }
  },
  { 'ibhagwan/fzf-lua',
    init = require('partials/fzf').init,
    config = require('partials/fzf').config,
    cmd = { 'FzfLua' },
  },
  { 'vim-test/vim-test',
    ft = { 'go', 'rust' },
    init = function()
      map('n', '<leader>tt', ':TestNearest<cr>', {})
      map('n', '<leader>tp', ':TestFile<cr>', {})
      map('n', '<leader>ta', ':TestSuite<cr>', {})
      vim.api.nvim_exec([[
        let test#strategy = "neovim"
        let test#neovim#start_normal = 1
      ]], false)
    end,
  },
	{ 'tpope/vim-abolish', event = { 'VeryLazy' } },
  { 'tpope/vim-surround', event = { 'VeryLazy' } },
  { 'tpope/vim-repeat', event = { 'VeryLazy' } },
	{ 'tpope/vim-projectionist',
    init = require('partials/projectionist').init,
    config = require('partials/projectionist').config,
		event = { 'VeryLazy' },
  },
  { 'tpope/vim-rhubarb', event = { 'VeryLazy' } },
  { 'tpope/vim-fugitive', event = { 'VeryLazy' } },
  { 'neovim/nvim-lspconfig',
    config = function()
      require('partials/lsp')
    end,
    event = { 'BufEnter' },
  },
	{ 'nvim-tree/nvim-tree.lua',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		init = require('partials/nvim_tree').init,
		config = require('partials/nvim_tree').config,
		cmd = { 'NvimTreeToggle', 'NvimTreeFindFileToggle' },
	},
  { 'hrsh7th/vim-vsnip-integ', event = { 'VeryLazy' }},
  { 'hrsh7th/vim-vsnip', event = { 'VeryLazy' }},
	{ 'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/cmp-buffer',
    },
    config = require('partials/completion').config,
    event = { 'BufEnter' }
  },
  { 'schickling/vim-bufonly',
    init = function()
      map('n', '<leader>bo', ':BufOnly<CR>', { silent = true })
    end,
    cmd = { 'BufOnly' }
  },
  { 'preservim/tagbar',
    init = require('partials/tagbar').init,
    config = require('partials/tagbar').config,
    cmd = { 'TagbarToggle' },
  },
  { 'airblade/vim-rooter',
    ft = { 'go', 'rust' },
  },
  { 'johejo/gomod.vim', ft = { 'gomod' }},
  { 'rhysd/vim-go-impl', ft = { 'go' }},
  { 'martskins/vim-cargo-search', ft = { 'rust' }},
  { 'jparise/vim-graphql', ft = { 'graphql' }},
  { 'cespare/vim-toml', ft = { 'toml' }},
  -- { 'ellisonleao/gruvbox.nvim',
  --   priority = 1000,
  --   lazy = false,
  --   config = function()
  --     require('gruvbox').setup({
  --       transparent_mode = false,
  --       italic = {
  --         strings = false,
  --         comments = false,
  --         operators = false,
  --         folds = false,
  --       },
  --       bold = false,
  --       contrast = "hard"
  --     })
  --     vim.cmd('colorscheme gruvbox')
  --   end
  -- },
  -- { 'tomasiser/vim-code-dark',
  --   priority = 1000,
  --   lazy = false,
  --   config = function()
  --     vim.cmd([[
  --       let g:codedark_transparent=1
  --       let g:codedark_conservative=1


  --       colorscheme codedark
  --     ]])
  --   end
  -- }
}
