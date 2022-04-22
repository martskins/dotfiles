local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', 'R', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('v', 'ga', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
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

  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    vim.api.nvim_command('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync(nil, 1000)')
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  client.config.flags.allow_incremental_sync = true
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local nvim_lsp = require('lspconfig')
local configs = require('lspconfig/configs')

configs.vim_language_server = {
  default_config = {
    cmd = {'vim-language-server', '--stdio'};
    filetypes = {'vim'};
    root_dir = function(fname)
      return nvim_lsp.util.find_git_ancestor(fname) or vim.loop.os_homedir()
    end;
    settings = {};
  };
}

local golangcilint = {
  lintCommand = "golangci-lint run --out-format json",
  lintSource = "golanci-lint",
  init_options = { documentFormatting = false }, -- SET HERE
}
configs.efm = {
  default_config = {
    cmd = { 'efm-langserver' },
    root_dir = vim.loop.cwd,
    settings = {
      rootMarkers = {".git/"},
      languages = {
        go = { golangcilint },
      }
    }
  }
}

configs.diagnosticls = {
  default_config = {
    cmd = { 'diagnostic-languageserver', '--stdio' },
    filetypes = { 'go' },
    init_options = {
      filetypes = {
        go = 'golangci-lint',
      },
      linters = {
        ['golangci-lint'] = {
          command = 'golangci-lint',
          rootPatterns = { '.git', 'go.mod' },
          debounce = 100,
          args = { 'run', '--out-format', 'json' },
          sourceName = 'golangci-lint',
          parseJson = {
            sourceName = 'Pos.Filename',
            sourceNameFilter = true,
            errorsRoot = 'Issues',
            line = 'Pos.Line',
            column = 'Pos.Column',
            message = '${Text} [${FromLinter}]',
            security = 'severity',
          },
          offsetLine = 0,
          offsetColumn = 1,
          securities = {
            [''] = 'error',
            undefined = 'error',
          },
        }
      }
    },
  },
}

configs.gopls = {
  default_config = {
    cmd = { 'gopls', 'serve' },
    filetypes = {'go', 'gomod'},
    settings = {
      gopls = {
        ["formatting.gofumpt"] = true,
        usePlaceholders = true,
        ["local"] = "github.com/utilitywarehouse",
        staticcheck = true,
      },
    },
  },
}

local servers = { "pyright", "rust_analyzer", "tsserver", "gopls", "clangd" , "golangci_lint_ls", "sumneko_lua", "yamlls", "terraformls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = function(fname)
			return nvim_lsp.util.find_git_ancestor(fname) or vim.loop.os_homedir()
    end;
    flags = {
      debounce_did_change_notify = 250,
    };
  }
end

nvim_lsp.omnisharp.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { 'omnisharp', '--languageserver', '--hostPID', tostring(vim.fn.getpid()) },
  filetypes = { 'cs', 'vb' },
  init_options = {
    AutomaticWorkspaceInit = true

  },
}
