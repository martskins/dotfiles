require("trouble").setup {
    auto_preview = false,
    cycle_results = false,
    focus = true
}

local map = vim.api.nvim_set_keymap
map("n", "T", ":Trouble diagnostics toggle<cr>", {silent = true})
map("n", ",.", ":Trouble symbols toggle<cr>", {silent = true})
