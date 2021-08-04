function! s:SetNoExpand()
	if &ft =~ 'go'
		set noexpandtab
	endif

		set expandtab
endfunction

autocmd FileType * call s:SetNoExpand()
autocmd FileType go nnoremap <leader>d :silent ! open "https://golang.org/search?q=" &<left><left><left>
