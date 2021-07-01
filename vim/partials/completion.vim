set completeopt=noinsert,menuone,noselect
let g:neosnippet#enable_completed_snippet = 1
let g:neosnippet#enable_complete_done = 1

autocmd BufEnter * call ncm2#enable_for_buffer()
let g:ncm2#auto_popup = 1
imap <C-k>     <Plug>(neosnippet_expand_target)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
imap <expr><C-k> pumvisible() ?
	\ ncm2_neosnippet#expand_or("", 'n')
	\ : "\<Plug>(neosnippet_expand_or_jump)"
