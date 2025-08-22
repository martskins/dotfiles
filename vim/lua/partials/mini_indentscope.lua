require("mini.indentscope").setup(
    {
        draw = {
            animation = require("mini.indentscope").gen_animation.none()
        },
        options = {
            border = "both",
            indent_at_cursor = true,
            try_as_border = true
        }
    }
)

vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", {fg = "red"})
