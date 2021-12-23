local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local cmp = require('cmp')
cmp.setup({
  -- completion = { autocomplete = true },
  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]", vsnip = "[VSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[Latex]",
      })[entry.source.name]
      return vim_item
    end,
  },
  experimental = {
    -- ghost_text = true,
  },
  sorting = {
    comparators = {
      require('cmp.config.compare').order
    }
  },
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-k>'] = cmp.mapping(function(fallback)
        -- if vim.fn.pumvisible() == 1 and vim.fn.complete_info().selected ~= -1 then
        if cmp.visible() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true });
        elseif vim.fn["vsnip#available"]() == 1 then
          feedkey("<Plug>(vsnip-expand-or-jump)", "")
        else
          fallback()
        end
      end, { 'i', 's' }),
  },

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
  }),
})
