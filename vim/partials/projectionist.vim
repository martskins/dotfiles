nmap <silent><leader>aa :A<CR>
nmap <silent><leader>av :AV<CR>

augroup projection_extension
  autocmd User ProjectionistDetect
  \ call projectionist#append(getcwd(),
  \ {
  \    '*.go':      { 'alternate': '{}_test.go' },
  \    '*_test.go': { 'alternate': '{}.go' },
  \    '*.cpp':     { 'alternate': '{}.h' },
  \    '*.h':       { 'alternate': '{}.cpp' },
  \    '*.js':      { 'alternate': '{}.spec.js' },
  \    '*.spec.js': { 'alternate': '{}.js' },
  \    'dev-aws/*':      { 'alternate': 'prod-aws/{}' },
  \    'prod-aws/*':      { 'alternate': 'dev-aws/{}' },
  \ })
augroup END
