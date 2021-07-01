let g:LanguageClient_loggingLevel = 'ERROR'
let g:LanguageClient_selectionUI = 'LocationList'
" let g:LanguageClient_serverCommands = {}
" let g:LanguageClient_serverCommands.go = { 'name': 'gopls', 'command': ['gopls'], 'handlers': { 'textDocument/didSave': 'Log' } }
" let g:LanguageClient_serverCommands.rust = ['rust-analyzer']
let g:lcn_settings#format_on_save = ['go', 'rust']
