local map = vim.api.nvim_set_keymap
map('n', '<leader>aa', ':A<CR>', { silent = true })
map('n', '<leader>av', ':AV<CR>', { silent = true })

vim.api.nvim_exec([[
  augroup projection_extension
    let args = {}
    let args['*.go'] =                  { 'alternate': '{}_test.go' }
    let args['*_test.go'] =             { 'alternate': '{}.go' }
    let args['*.cpp'] =                 { 'alternate': '{}.h' }
    let args['*.h'] =                   { 'alternate': '{}.cpp' }
    let args['*.js'] =                  { 'alternate': '{}.spec.js' }
    let args['*.spec.js'] =             { 'alternate': '{}.js' }
    let args['dev-aws/*'] =             { 'alternate': 'prod-aws/{}' }
    let args['dev-merit/*'] =           { 'alternate': 'prod-aws/{}' }
    let args['dev/cbc/v1/*'] =          { 'alternate': 'prod/cbc/v1/{}' }
    let args['prod/cbc/v1/*'] =         { 'alternate': 'dev/cbc/v1/{}' }
    let args['dev-merit/*'] =           { 'alternate': 'prod-aws/{}' }
    let args['prod-aws/*'] =            { 'alternate': 'dev-merit/{}' }
    let args['*.up.sql'] =              { 'alternate': '{}.down.sql' }
    let args['*.down.sql'] =            { 'alternate': '{}.up.sql' }
    autocmd User ProjectionistDetect call projectionist#append(getcwd(), args)
  augroup END
]], false)
