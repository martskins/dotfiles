let g:AutoPairs = {'(':')', '[':']', '{':'}','"':'"', '`':'`', '<':'>'}

let g:ale_rust_cargo_use_clippy = 1

nnoremap <leader>d :silent ! surf 1>/dev/null 2>/dev/null "doc.rust-lang.org/std/index.html?search=" &<left><left><left>
