vim.keymap.set(
    "i",
    "<C-]>",
    function()
        vim.fn.feedkeys(vim.fn["copilot#Next"](), "")
    end,
    {desc = "Copilot Accept", noremap = true, silent = true}
)
vim.keymap.set(
    "i",
    "<C-l>",
    function()
        vim.fn.feedkeys(vim.fn["copilot#AcceptLine"](), "")
    end,
    {desc = "Copilot Accept", noremap = true, silent = true}
)
vim.keymap.set(
    "i",
    "<C-f>",
    function()
        vim.fn.feedkeys(vim.fn["copilot#Accept"](), "")
    end,
    {desc = "Copilot Accept", noremap = true, silent = true}
)
vim.g.copilot_no_tab_map = true
