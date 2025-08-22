require("CopilotChat").setup(
    {
        auto_insert_mode = true,
        sticky = {
            "#buffer"
        },
        mappings = {
            close = {
                normal = "<esc>",
                insert = "<esc>"
            }
        }
    }
)

vim.api.nvim_set_keymap("n", "<leader>cc", ":CopilotChat<cr>", {})
