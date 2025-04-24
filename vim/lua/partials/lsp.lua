local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    local opts = {noremap = true, silent = true}
    buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "R", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("v", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("n", "gl", "<cmd>lua vim.lsp.codelens.run()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "E", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    buf_set_keymap("n", "<C-s><C-s>", "<cmd>lua vim.lsp.buf.document_highlight()<CR>", opts)
    buf_set_keymap("n", "<C-s><C-h>", "<cmd>lua vim.lsp.buf.clear_references()<CR>", opts)
    buf_set_keymap("n", "<leader>ws", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", opts)
    buf_set_keymap("n", "<leader>ds", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", opts)
    buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    buf_set_keymap("n", "Q", "<cmd>lua vim.diagnostic.setloclist({open_loclist = true, workspace = true})<CR>", opts)
    buf_set_keymap(
        "n",
        "<leader>h",
        "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>",
        opts
    )

    if client.supports_method "textDocument/codeLens" then
        vim.api.nvim_command(
            "autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh({ bufnr = 0 })"
        )
    end

    if client.supports_method "textDocument/completion" then
        vim.lsp.completion.enable(
            true,
            client.id,
            bufnr,
            {
                autotrigger = true,
                convert = function(item)
                    return {abbr = item.label:gsub("%b()", "")}
                end
            }
        )
    end

    -- client.config.flags.allow_incremental_sync = true
    -- client.server_capabilities.semanticTokensProvider = nil

    -- if client.server_capabilities.inlayHintProvider then
    --   vim.lsp.inlay_hint(bufnr, true)
    -- end
end

local pummaps = {
    ["<C-k>"] = "<C-y>"
}
for insertKmap, pumKmap in pairs(pummaps) do
    vim.keymap.set(
        "i",
        insertKmap,
        function()
            return vim.fn.pumvisible() == 1 and pumKmap or insertKmap
        end,
        {expr = true}
    )
end

-- local implementation = vim.lsp.buf.implementation
-- vim.lsp.buf.implementation = function(opts)
--     implementation(
--         {
--             on_list = function(opts)
--                 for k, v in ipairs(opts) do
--                     print(k, v)
--                 end
--             end
--         }
--     )
-- end

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
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.offsetEncoding = {"utf-8"}

vim.lsp.config.gopls = {
    cmd = {"gopls"},
    filetypes = {"go", "gomod", "gowork"},
    on_attach = on_attach,
    settings = {
        ["local"] = get_current_gomod(),
        gofumpt = true,
        staticcheck = true,
        usePlaceholders = true,
        hints = {
            assignVariableTypes = false,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = false,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true
        },
        analyses = {
            modernize = true
        },
        codelenses = {
            generate = true,
            gc_details = true,
            references = true,
            regenerate_cgo = true,
            tidy = true,
            test = false,
            upgrade_dependency = true,
            vendor = true,
            run_govulncheck = true
        }
    }
}
vim.lsp.enable("gopls")

vim.lsp.config.typescript = {
    cmd = {"typescript-language-server", "--stdio"},
    on_attach = on_attach,
    filetypes = {"typescriptreact", "tsx"}
}
vim.lsp.enable("typescript")

vim.lsp.config.rust = {
    cmd = {"rust-analyzer"},
    on_attach = on_attach,
    filetypes = {"rust"}
}
vim.lsp.enable("rust")

vim.lsp.config.clangd = {
    cmd = {"clangd"},
    on_attach = on_attach,
    filetypes = {"cpp", "c"}
}
vim.lsp.enable("clangd")

vim.lsp.config.luals = {
    cmd = {"lua-language-server"},
    on_attach = on_attach,
    filetypes = {"lua"},
    settings = {
        Lua = {
            telemetry = {enable = false},
            diagnostics = {globals = {"vim"}}
        }
    }
}
vim.lsp.enable("luals")

vim.diagnostic.config({virtual_text = {current_line = true}})
