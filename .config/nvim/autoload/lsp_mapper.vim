let g:lsp_mapper_lhs_base = 'nnoremap <silent> <Space>l'
let g:lsp_mapper_lhs_actions = {
        \ 'textDocument_definition'        : '[',
        \ 'textDocument_references'        : ']',
        \ 'textDocument_rename'            : 'r',
        \ 'textDocument_documentSymbol'    : 'd',
        \ 'textDocument_documentHighlight' : 'h',
        \ 'textDocument_formatting'        : 'f',
    \ }
function! lsp_mapper#register(action_to_func) abort
    for name in keys(g:lsp_mapper_lhs_actions)
        call s:key_map_settings(name, a:action_to_func[name])
    endfor
endfunction

function! s:key_map_settings(name, func) abort
    let commands = [
            \ g:lsp_mapper_lhs_base . g:lsp_mapper_lhs_actions[a:name],
            \ ':call',
            \ a:func . '<CR>'
    \ ]
    execute join(commands, ' ')
endfunction

