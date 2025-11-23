let g:lsp_mapper_lhs_base = 'nnoremap <silent> <Space>l'
let g:lsp_mapper_lhs_actions = {
        \ 'textDocument_definition'        : '[',
        \ 'textDocument_references'        : ']',
        \ 'textDocument_rename'            : 'r',
        \ 'textDocument_documentSymbol'    : 'd',
        \ 'textDocument_documentHighlight' : 'h',
        \ 'textDocument_formatting'        : 'f',
    \ }
let s:lsp_mapper_rhs_base = {
        \ 'func': ':call ',
        \ 'plug': '<Plug>',
        \ 'command': ':'
    \ }
function! lsp_mapper#register(action_to_rhs) abort
    for name in keys(g:lsp_mapper_lhs_actions)
        call s:key_map_settings(name, a:action_to_rhs[name])
    endfor
endfunction

function! s:key_map_settings(name, rhs) abort
    let base_rhs = s:lsp_mapper_rhs_base[a:rhs[0]]
    let commands = [
            \ g:lsp_mapper_lhs_base . g:lsp_mapper_lhs_actions[a:name],
            \ base_rhs . a:rhs[1]
    \ ]
    execute join(commands, ' ')
endfunction

