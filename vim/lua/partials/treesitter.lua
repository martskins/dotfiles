local module = {}

function module.config()
  require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = { "c", "cpp", "lua", "rust", "go", "vim", "terraform" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- List of parsers to ignore installing (for "all")
    ignore_install = { },

    highlight = {
      -- `false` will disable the whole extension
      enable = true,

      -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
      -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
      -- the name of the parser)
      -- list of language that will be disabled
      disable = { },

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },

    textobjects = {
      enabled = true,
      move = {
        enable = true,
        goto_next_start = {
          [']]'] = '@function.outer',
        },
        goto_previous_start = {
          ['[['] = '@function.outer',
        },
      },
    },
    incremental_selection = {
      enable = false,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
  }

  local ts_utils = require'nvim-treesitter.ts_utils'

  local function get_struct_name()
    local current_node = ts_utils.get_node_at_cursor()

    if not current_node then return "" end

    local expr = current_node

    while expr do
        if expr:type() == 'type_declaration' then
            break
        end
        expr = expr:parent()
    end

    if not expr then return "" end

    local struct_name = ''

    for line in vim.treesitter.get_node_text(expr:child(1), 0):gmatch("([^\n]*)\n?") do
      if string.find(line, "struct {" ) then
        struct_name = string.gsub(line, "struct {", "")
        break
      end
    end

    return struct_name
  end

  local function explode_string(div,str)
      if (div=='') then return false end
      local pos,arr = 0,{}
      for st,sp in function() return string.find(str,div,pos,true) end do
          table.insert(arr,string.sub(str,pos,st-1))
          pos = sp + 1
      end
      table.insert(arr,string.sub(str,pos))
      return arr
  end

  function GoAddTags(opts)
    local args = explode_string(' ', opts.args)
    if not args then
      return
    end

    if not args[1] then
      print('Need at least one argument indicating the tag name to add')
      return
    end

    local tag_name = args[1]

    local transformation = 'snakecase'
    if #args > 1 then
      transformation = args[2]
    end

    local opt = ''
    if #args > 2 then
      opt = args[3]
    end

    local filename = vim.fn.expand('%p')
    local struct_name = get_struct_name()

    if opt == "omitempty" then
      vim.fn.system('gomodifytags -file ' .. filename .. ' -struct ' .. struct_name .. ' -w -add-tags ' .. tag_name .. ' -transform ' .. transformation .. ' --skip-unexported' .. ' -add-options json=omitempty')
    else
      vim.fn.system('gomodifytags -file ' .. filename .. ' -struct ' .. struct_name .. ' -w -add-tags ' .. tag_name .. ' -transform ' .. transformation .. ' --skip-unexported')
    end

    vim.cmd('edit!')
  end

  vim.api.nvim_create_user_command('GoAddTags', GoAddTags, { nargs = '?'})

end

return module
