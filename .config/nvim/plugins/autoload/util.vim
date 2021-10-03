command! -nargs=+ -complete=customlist,util#table_options
    \ CompleteSample
    \ call util#Sample(<f-args>)

function! util#table_options(argLead, cmdLine, cursorPos)
    let l:cmd = split(a:cmdLine)
    let l:len_cmd = len(l:cmd)
    let comp = []

   if a:argLead =~# '^-'
        let comp += map(keys(copy(util#commandList())),
            \ "'-' . v:val . '='")
        return uniq(sort(filter(comp, 'stridx(v:val, a:argLead) == 0')))
    endif

endfunction

function! util#Sample(...) abort
    echo a:000
endfunction

function! util#commandList() abort
    return {
                \ 'pos': v:t_number,
                \ 'num_line': v:t_number,
                \ }
endfunction


