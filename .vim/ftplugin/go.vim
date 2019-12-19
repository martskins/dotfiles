let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 0
let g:go_autodetect_gopath = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_metalinter_enabled = 0
let g:go_metalinter_autosave = 0
let g:go_metalinter_autosave_enabled = ['golint']
let g:go_metalinter_deadline = "5s"
let g:go_list_type = "quickfix"
let g:go_def_reuse_buffer = 1
let g:go_doc_keywordprg_enabled = 0
let g:go_def_mapping_enabled = 0 " leave this to the language server
let g:go_term_enabled = 0
let g:go_code_completion_enabled = 0
let g:go_test_show_name = 1
let g:go_auto_type_info = 0
let g:go_gopls_enabled = 0
" let g:go_addtags_transform = "camelcase"

nmap <leader>c <Plug>(go-coverage)
nmap <leader>ct <Plug>(go-coverage-toggle)
nmap <leader>b <Plug>(go-build)
nmap <leader>t <Plug>(go-test)
nmap <leader>tf <Plug>(go-test-func)
nmap <leader>a <Plug>(go-alternate-edit)
nmap <leader>g <Plug>(go-generate)
inoremap ;err <ESC>:GoIfErr<CR>O

nnoremap <leader>d :silent ! surf 1>/dev/null 2>/dev/null "https://golang.org/search?q=" &<left><left><left>
