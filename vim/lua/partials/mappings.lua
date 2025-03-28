local map = vim.api.nvim_set_keymap

map("n", "gev", ":e ~/.config/nvim/init.lua<CR>", {noremap = true})
map("n", "<C-h>", ':let @/=""""<CR>', {noremap = true, silent = true})
-- map('n', '<C-h>', ':nohlsearch<C-R>=has(\'diff\')?\'<Bar>diffupdate\':\'\'<CR><CR><C-L>', { noremap = true, silent = true })
map("n", "<c-[>", ":cprevious<cr>", {})
map("n", "<c-]>", ":cnext<cr>", {})
map("n", "<tab>", ":bnext<CR>", {})
map("n", "<s-tab>", ":bprevious<CR>", {})
map("n", "<leader>ba", ":bufdo bd<CR>", {})
map("n", "<leader>x", ":%!xxd<CR>", {})
map("n", "<c-s><c-v>", ":vsplit<CR>", {})
map("n", "<c-s><c-h>", ":split<CR>", {})
map("n", "<space><space>", "<C-^>", {})
map("i", "<C-c>", "<ESC>", {noremap = true})
map("i", "<LeftMouse>", "<NOP>", {noremap = true})
map("n", "<LeftMouse>", "<NOP>", {noremap = true})
map("v", "<leader>pj", ":!python3 -m json.tool<CR>", {noremap = true})
map("n", "]p", ":pu<CR>", {silent = true})
map("n", "[p", ":pu!<CR>", {silent = true})
map("t", "<C-o>", "<C-\\><C-n>", {})

vim.api.nvim_exec(
    [[
	function! ProfileStart()
		:profile start profile.log
		:profile func *
		:profile file *
	endfunction

	function! ProfileStop()
		:profile stop
	endfunction

  " the macro in f converts a struct field to a cli.Flag
  let @f='0wwdw0wPli 0wi&cli.lvUeliFlag{Name:lli"ebyweli"bcrkf"li, EnvVars:[]string{"pbcrsgUweli"}, Destination: &cfg.pbeli, Required: true},'
  let g:rooter_patterns = ['.git', '*.sln', 'build/env.sh']
  let g:rooter_resolve_links = 0

  function! RangeSearch(direction)
    call inputsave()
    let g:srchstr = input(a:direction)
    call inputrestore()
    if strlen(g:srchstr) > 0
      let g:srchstr = g:srchstr.
            \ '\%>'.(line("'<")-1).'l'.
            \ '\%<'.(line("'>")+1).'l'
    else
      let g:srchstr = ''
    endif
  endfunction
  vnoremap <silent> ? :<C-U>call RangeSearch('/')<CR>:if strlen(g:srchstr) > 0\|exec '/'.g:srchstr\|endif<CR>
  " vnoremap <silent> ? :<C-U>call RangeSearch('?')<CR>:if strlen(g:srchstr) > 0\|exec '?'.g:srchstr\|endif<CR>

  " fugitive config
  command! -nargs=1 Browse silent execute '!open' shellescape(<q-args>,1)
  nnoremap <leader>gb :GBrowse<CR>
]],
    false
)

vim.api.nvim_create_user_command("PS", "Lazy sync", {})
vim.api.nvim_create_user_command("ProfileStart", "call ProfileStart()", {})
vim.api.nvim_create_user_command("ProfileStop", "call ProfileStop()", {})

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
        print("Need at least two arguments indicating the struct naem and the tag name to add")
        return
    end

    if not args[2] then
        print("Need at least one argument indicating the tag name to add")
        return
    end

    local struct_name = args[1]
    local tag_name = args[2]

    local transformation = "snakecase"
    if #args > 2 then
        transformation = args[3]
    end

    local opt = ""
    if #args > 3 then
        opt = args[4]
    end

    local filename = vim.fn.expand("%p")

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
