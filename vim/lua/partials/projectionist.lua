local module = {}

function module.init()
  local map = vim.api.nvim_set_keymap
  map('n', '<leader>aa', ':A<CR>', { silent = true })
  map('n', '<leader>av', ':AV<CR>', { silent = true })
end

function module.config()
  vim.api.nvim_exec([[
    augroup projection_extension
      let args = {}
      let args['*.go'] =                                { 'alternate': ['{}_test.go', '{}_integration_test.go'] }
      let args['*_test.go'] =                           { 'alternate': '{}.go' }
      let args['*_integration_test.go'] =               { 'alternate': '{}.go' }
      let args['*.cpp'] =                               { 'alternate': ['{}.h', '{}.hpp'] }
      let args['*.hpp'] =                               { 'alternate': ['{}.c', '{}.cpp'] }
      let args['*.h'] =                                 { 'alternate': ['{}.c', '{}.cpp'] }
      let args['*.c'] =                                 { 'alternate': ['{}.h', '{}.hpp'] }
      let args['*.js'] =                                { 'alternate': '{}.spec.js' }
      let args['*.spec.js'] =                           { 'alternate': '{}.js' }
      let args['dev-aws/*'] =                           { 'alternate': 'prod-aws/{}' }
      let args['dev-merit/*'] =                         { 'alternate': 'prod-aws/{}' }
      let args['dev/cbc/v1/*'] =                        { 'alternate': ['prod/cbc/v1/{}'] }
      let args['prod/cbc/v1/*'] =                       { 'alternate': ['dev/cbc/v1/{}'] }
      let args['dev-merit/*'] =                         { 'alternate': 'prod-aws/{}' }
      let args['prod-aws/*'] =                          { 'alternate': 'dev-merit/{}' }
      let args['*.up.sql'] =                            { 'alternate': '{}.down.sql' }
      let args['*.down.sql'] =                          { 'alternate': '{}.up.sql' }
      let args['okta/enterprise-prod/uw-cbc/*'] =       { 'alternate': 'okta/enterprise-dev/uw-cbc/{}' }
      let args['okta/enterprise-dev/uw-cbc/*']  =       { 'alternate': 'okta/enterprise-prod/uw-cbc/{}' }
      autocmd User ProjectionistDetect call projectionist#append(getcwd(), args)
    augroup END
  ]], false)
end

return module
