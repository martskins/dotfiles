local function table_print(tt, indent, done)
  done = done or {}
  indent = indent or 0
  print(type(tt))
  if type(tt) == "table" then
    local sb = {}
    for key, value in pairs(tt) do
      table.insert(sb, string.rep(" ", indent)) -- indent it
      if type(value) == "table" and not done[value] then
        done[value] = true
        table.insert(sb, key .. " = {\n");
        table.insert(sb, table_print(value, indent + 2, done))
        table.insert(sb, string.rep(" ", indent)) -- indent it
        table.insert(sb, "}\n");
      elseif "number" == type(key) then
        table.insert(sb, string.format("\"%s\"\n", tostring(value)))
      else
        table.insert(sb, string.format(
          "%s = \"%s\"\n", tostring(key), tostring(value)))
      end
    end
    return table.concat(sb)
  else
    return tt .. "\n"
  end
end

local function to_string(tbl)
  if "nil" == type(tbl) then
    return tostring(nil)
  elseif "table" == type(tbl) then
    return table_print(tbl)
  elseif "string" == type(tbl) then
    return tbl
  else
    return tostring(tbl)
  end
end

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', 'R', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('v', 'ga', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'E', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '<C-s><C-s>', '<cmd>lua vim.lsp.buf.document_highlight()<CR>', opts)
  buf_set_keymap('n', '<C-s><C-h>', '<cmd>lua vim.lsp.buf.clear_references()<CR>', opts)
  buf_set_keymap('n', '<leader>ws', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
  buf_set_keymap('n', '<leader>ds', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', 'Q', '<cmd>lua vim.diagnostic.setloclist({open_loclist = true, workspace = true})<CR>', opts)

  if client.supports_method 'textDocument/formatting' then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
    vim.api.nvim_command('autocmd BufWritePre <buffer> lua vim.lsp.buf.format(nil, 1000)')
  elseif client.supports_method 'textDocument/rangeFormatting' then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  client.config.flags.allow_incremental_sync = true
end

-- do not include test or mocks files in Go
local original_on_references = vim.lsp.handlers['textDocument/references']
local original_on_implementation = vim.lsp.handlers['textDocument/implementation']

local filter_quickfix_with_callback = function(callback)
  return function(a, results, ctx, config)
    if results == nil then
      return callback(a, results, ctx, config)
    end

    local out = {}
    for _, v in pairs(results) do
      local filename = v['uri']
      if not string.find(filename, '_test.go') and not string.match(filename, "../mocks/") then
        table.insert(out, v)
      end
    end
    callback(a, out, ctx, config)
  end
end
vim.lsp.handlers['textDocument/references'] = vim.lsp.with(filter_quickfix_with_callback(original_on_references), {})
vim.lsp.handlers['textDocument/implementation'] = vim.lsp.with(filter_quickfix_with_callback(original_on_implementation)
  , {})

local get_current_gomod = function()
  local file = io.open("go.mod", "r")
  if file == nil then
    return nil
  end

  local first_line = file:read()
  local mod_name = first_line:gsub("module ", "")
  file:close()
  return mod_name
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.offsetEncodings = "utf-8"

local nvim_lsp = require('lspconfig')
local settings_overrides = {
  gopls = {
    gopls = {
      ['local'] = get_current_gomod(),
      gofumpt = true,
      staticcheck = true,
      usePlaceholders = true,
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
      },
    }
  },
  sumneko_lua = {
    Lua = { diagnostics = { globals = { 'vim' } } }
  },
}

local filetypes_overrides = {
  clangd = { 'c', 'cpp', 'objc', 'objcpp' },
}

local servers = { "pyright", "rust_analyzer", "gopls", "sumneko_lua", "clangd", "yamlls", "terraformls",
  "hls", "vimls", "graphql", "bufls" }
for _, lsp in ipairs(servers) do
  local settings = {}
  if settings_overrides[lsp] then
    settings = settings_overrides[lsp]
  end

  local setup = {
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = function(fname)
      return nvim_lsp.util.find_git_ancestor(fname) or vim.loop.os_homedir()
    end;
    flags = {
      debounce_did_change_notify = 250,
    };
    settings = settings,
  }

  if filetypes_overrides[lsp] then
    setup.filetypes = filetypes_overrides[lsp]
  end

  nvim_lsp[lsp].setup(setup)
end

nvim_lsp.tsserver.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    on_attach(client, bufnr)
    vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.format()')
  end
}
