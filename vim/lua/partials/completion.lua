local o = vim.o
o.completeopt = 'noinsert,menuone,noselect'

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local cmp = require('cmp')
cmp.setup({
  completion = { autocomplete = false },
  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[Latex]",
      })[entry.source.name]
      return vim_item
    end,
  },
  experimental = {
    ghost_text = true,
  },
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-k>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-n>'] = function(fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(t('<C-n>', true, true, true), 'n')
        -- elseif check_back_space() then
        --   vim.fn.feedkeys(t('<C-n>', true, true, true), 'n')
        elseif vim.fn['vsnip#available']() == 1 then
          vim.fn.feedkeys(t('<Plug>(vsnip-expand-or-jump)', true, true, true), '')
        else
          fallback()
        end
      end,
  },

  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  },
})
