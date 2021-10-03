function! table_load#start_load() abort
    runtime! plugin/rplugin.vim
    call _table_move_init(0)
    call rpcrequest(g:table#channel_id, 'table_move_mode', '0')
endfunction

