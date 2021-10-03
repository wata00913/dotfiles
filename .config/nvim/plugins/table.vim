let s:save_cpo = &cpoptions
set cpoptions&vim

nnoremap <Plug>(test)
  \ :call Test<CR>

let &cpoptions = s:save_cpo
unlet s:save_cpo

function! table#_init() abort
    call table_move_init()
endfunction

function! TableEcho() abort
    let s:message = ''
    call rpcrequest(table#channel_id, "table_move_mode", s:message)
    echo s:message
endfunction

command! -nargs=0 TableEcho call TableEcho()
command! -nargs=0 TableInit call table#_init()
