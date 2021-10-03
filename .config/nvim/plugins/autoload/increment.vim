scriptencoding utf-8


function! increment#IncrementRange(...) abort
    let first_pos = getpos(".")
    let row = first_pos[1]
    let col = first_pos[2]

    let val = a:1
    while val <= a:2
        let line = increment#appendVal(getline(row), val, col)
        call setline(row, line)
        let val += 1
        let row += 1
    endwhile
endfunction


function! increment#appendVal(line, val, col) abort
    if a:col == 1
        return a:val . a:line
    endif
    if strlen(a:line) < a:col
        return a:line . s:addSpace((a:col - 1) - strlen(a:line)) . a:val
    elseif strlen(a:line) == a:col
       return a:line[0:a:col-2] . a:val
    else
       return a:line[0:a:col-2] . a:val . a:line[a:col-1:]
    endif
endfunction
         
function! s:addSpace(num) abort
    let spaces = ''

    for i in range(a:num)
        let spaces =  spaces . ' '
    endfor
    return spaces
endfunction

