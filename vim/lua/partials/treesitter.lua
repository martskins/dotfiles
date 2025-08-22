require "nvim-treesitter.configs".setup {
    ensure_installed = {
        "c",
        "cpp",
        "c_sharp",
        "lua",
        "rust",
        "go",
        "gomod",
        "vim",
        "terraform",
        "yaml",
        "proto",
        "toml",
        "graphql",
        "typescript",
        "javascript",
        "sql",
        "make",
        "tsx",
        "json",
        "cmake",
        "glsl"
    },
    sync_install = false,
    ignore_install = {},
    highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = false
    },
    textobjects = {
        enabled = true,
        move = {
            enable = true,
            goto_next_start = {
                ["]]"] = "@function.outer"
            },
            goto_previous_start = {
                ["[["] = "@function.outer"
            }
        }
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm"
        }
    }
}
