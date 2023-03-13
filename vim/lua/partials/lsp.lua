local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  buf_set_keymap('n', '<leader>sd', '<Cmd>lua vim.diagnostic.setqflist()<CR>', opts)
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', 'R', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('v', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gl', '<cmd>lua vim.lsp.codelens.run()<CR>', opts)
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



  if client.supports_method 'textDocument/codeLens' then
    vim.api.nvim_command('autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()')
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
vim.lsp.handlers['textDocument/implementation'] = vim.lsp.with(filter_quickfix_with_callback(original_on_implementation) , {})

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
capabilities.offsetEncoding = { "utf-8" }

local nvim_lsp = require('lspconfig')
local settings_overrides = {
  lua_ls = {
    Lua = {
      telemetry = { enable = false },
      diagnostics = { globals = {'vim'} },
    },
  },
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
      codelenses = {
        generate = true,
        regenerate_cgo = true,
        tidy = true,
        test = false,
        upgrade_dependency = true,
        vendor = true,
        run_govulncheck = true,
      },
    }
  },
}

local filetypes_overrides = {
  clangd = { 'c', 'cpp', 'objc', 'objcpp' },
}

local servers = { "pyright", "rust_analyzer", "gopls", "lua_ls", "clangd", "yamlls", "terraformls",
  "hls", "vimls", "graphql", "bufls", "tsserver" }
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
