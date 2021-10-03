function! defx_settings#my_settings() abort
    call s:DefxOptions()
    call s:mappings()
    call s:denite_mappings()
endfunction

function! s:DefxOptions() abort
    call defx#custom#option('_', {
        \ 'root_marker':': ',
        \ 'direction':'topleft',
        \ 'split':'vertical',
        \ 'winwidth': 40,
	\ 'columns': 'mark:indent:icon:filename',
        \ })

endfunction

function! s:mappings() abort
	  nnoremap <silent><buffer><expr> <CR>
	  \ defx#do_action('open')
	  nnoremap <silent><buffer><expr> c
	  \ defx#do_action('copy')
	  nnoremap <silent><buffer><expr> m
	  \ defx#do_action('move')
	  nnoremap <silent><buffer><expr> p
	  \ defx#do_action('paste')
	  nnoremap <silent><buffer><expr> l
	  \ defx#do_action('open')
	  nnoremap <silent><buffer><expr> o
	  \ defx#do_action('open_or_close_tree')
	  nnoremap <silent><buffer><expr> s
	  \ defx#do_action('open', 'split')
	  nnoremap <silent><buffer><expr> v
	  \ defx#do_action('open', 'vsplit')
	  nnoremap <silent><buffer><expr> q
	  \ defx#do_action('quit')
	  nnoremap <silent><buffer><expr> D
	  \ defx#do_action('new_directory')
	  nnoremap <silent><buffer><expr> N
	  \ defx#do_action('new_file')
	  nnoremap <silent><buffer><expr> M
	  \ defx#do_action('new_multiple_files')
	  nnoremap <silent><buffer><expr> h
	  \ defx#do_action('cd', ['..'])
	  nnoremap <silent><buffer><expr> ~
	  \ defx#do_action('cd')
endfunction

function! s:denite_mappings() abort
	  nnoremap <silent><buffer><expr> g
	  \ defx#do_action('call', 'DefxDeniteGrep')
endfunction


function! DefxDeniteGrep(context) abort
    let dir_path = fnamemodify(a:context.targets[0], ':p:h')
    execute 'Denite grep -no-empty -path=' . dir_path  '-start-filter'
endfunction
