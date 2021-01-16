set background=dark
colorscheme base16-gruvbox-dark-hard
if has('nvim')
  set termguicolors
endif

" hi Normal                 guibg=#0B0B0B
hi Normal                 guibg=#171413
hi Todo                   ctermbg=none ctermfg=yellow guibg=none guifg=#fabd2f
hi Error                  ctermbg=none ctermfg=red guibg=none guifg=red
hi LCNCodeLens            ctermfg=14 ctermbg=none guibg=none guifg=#00D7FF
hi ExtraWhitespace        ctermbg=red

" match ExtraWhitespace /\s\+$/
" augroup whitespace
"   autocmd!
"   autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
"   autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
"   autocmd InsertLeave * match ExtraWhitespace /\s\+$/
"   autocmd BufWinLeave * call clearmatches()
" augroup END
