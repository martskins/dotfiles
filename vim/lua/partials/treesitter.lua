local module = {}

function module.config()
    require "nvim-treesitter.configs".setup {
        ensure_installed = {
            "c",
            "cpp",
            "c_sharp",
            "lua",
            "rust",
            "go",
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
            enable = false,
            keymaps = {
                init_selection = "gnn",
                node_incremental = "grn",
                scope_incremental = "grc",
                node_decremental = "grm"
            }
        }
    }

    local ts_utils = require "nvim-treesitter.ts_utils"

    local function get_struct_name()
        local current_node = ts_utils.get_node_at_cursor()

        if not current_node then
            return ""
        end

        local expr = current_node

        while expr do
            if expr:type() == "type_declaration" then
                break
            end
            expr = expr:parent()
        end

        if not expr then
            return ""
        end

        local struct_name = ""

        for line in vim.treesitter.get_node_text(expr:child(1), 0):gmatch("([^\n]*)\n?") do
            if string.find(line, "struct {") then
                struct_name = string.gsub(line, "struct {", "")
                break
            end
        end

        return struct_name
    end

    local function explode_string(div, str)
        if (div == "") then
            return false
        end
        local pos, arr = 0, {}
        for st, sp in function()
            return string.find(str, div, pos, true)
        end do
            table.insert(arr, string.sub(str, pos, st - 1))
            pos = sp + 1
        end
        table.insert(arr, string.sub(str, pos))
        return arr
    end

    function GoAddTags(opts)
        local args = explode_string(" ", opts.args)
        if not args then
            return
        end

        if not args[1] then
            print("Need at least one argument indicating the tag name to add")
            return
        end

        local tag_name = args[1]

        local transformation = "snakecase"
        if #args > 1 then
            transformation = args[2]
        end

        local opt = ""
        if #args > 2 then
            opt = args[3]
        end

        local filename = vim.fn.expand("%p")
        local struct_name = get_struct_name()

        if opt == "omitempty" then
            vim.fn.system(
                "gomodifytags -file " ..
                    filename ..
                        " -struct " ..
                            struct_name ..
                                " -w -add-tags " ..
                                    tag_name ..
                                        " -transform " ..
                                            transformation .. " --skip-unexported" .. " -add-options json=omitempty"
            )
        else
            vim.fn.system(
                "gomodifytags -file " ..
                    filename ..
                        " -struct " ..
                            struct_name ..
                                " -w -add-tags " .. tag_name .. " -transform " .. transformation .. " --skip-unexported"
            )
        end

        vim.cmd("edit!")
    end

    vim.api.nvim_create_user_command("GoAddTags", GoAddTags, {nargs = "?"})
end

return module
