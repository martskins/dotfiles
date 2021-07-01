function! LCNStatus() abort
	let l:running = LanguageClient#isServerRunning()
	if l:running
		return 'LCN: ✔'
	endif

	return 'LCN: ✘'
endfunction

function! LSPStatus() abort
	let l:status = 'LSP: ✘'
  let l:running = luaeval('vim.lsp.buf.server_ready()')
  if l:running
		let l:status = 'LSP: ✔'
  endif

  return l:status
endfunction

function! CurrentTag() abort
  return tagbar#currenttag('%s ','')
endfunction

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ],
			\ 'right': 	[ [ 'lineinfo' ],
			\ 						[ 'percent' ],
      \             [ 'filetype', 'charvaluehex' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'GitBranch',
      \   'lsp-diagnostics': 'LSPDiagnostics',
      \   'lsp-status': 'LSPStatus',
      \ },
      \ }
