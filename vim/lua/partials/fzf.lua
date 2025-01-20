local module = {}

function module.init()
    local map = vim.api.nvim_set_keymap
    map("n", "<C-s>", ":FzfLua lsp_live_workspace_symbols<CR>", {silent = true})
    map("n", "<C-l>", ":FzfLua buffers<CR>", {silent = true})
    map(
        "n",
        "<C-f>",
        ':lua require"fzf-lua".grep({ cmd = "rg --smart-case --line-number --column --color=always -g\'!{**/*_test.go,**/*mock*,gen/*,vendor/**}\' "})<CR>',
        {silent = true}
    )
    map(
        "n",
        "<C-g>",
        ':lua require"fzf-lua".grep({ cmd = "rg --smart-case --line-number --column --color=always -g\'!{**/*mock*,gen/*,vendor/**}\' "})<CR>',
        {silent = true}
    )
    map(
        "n",
        "<C-p>",
        ':lua require"fzf-lua".files({ cmd = "rg --smart-case --files --follow -g \'!{**/node_modules/*,**/vendor/*}\'" })<CR>',
        {silent = true}
    )
end

function module.config()
    require("fzf-lua").setup {
        keymap = {
            fzf = {
                ["ctrl-a"] = "select-all"
            }
        },
        files = {
            file_icons = false,
            git_icons = false,
            color_icons = false
        }
    }
end

return module
