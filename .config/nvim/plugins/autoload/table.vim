function! table#CreateTable(...) abort
    if &ft != 'markdown' || a:0 <= 1 && a:0 > 2
        echo 'need to two parameters or to be markdown of filetype'
        return 
    endif

    let first_pos = getpos('.')
    let row_pos = first_pos[1]

    let col = a:1
    let row = a:2
    call s:create_header(col, row_pos)
    call s:create_data(row, col, row_pos + 2)
    call setpos('.', first_pos)
    exe ':TableFormat'
endfunction

function! table#AddRowTable(...) abort
    let row_pos = getpos('.')[1]
    if a:0 == 0
        let row = 1
    elseif a:0 == 1
        let row = a:1
    endif

    let ran = s:search_table(row_pos)

    if ran[1] != 0 && ran[3] != 0
        let next_row = ran[2] + 1
        for i in range(row)
            call s:append_row(next_row, ran[3])
            let next_row += 1
        endfor
    endif
    exe ':TableFormat'
endfunction

"TODO 切り替えできるように
function! table#ToggleFormat() abort
    let ran = s:search_table(getpos('.')[1])
    exe ':' . ran[0] . ',' . ran[2] . 's/\v\|\s+/\|/g'
    exe ':' . ran[0] . ',' . ran[2] . 's/\v\s+\|/\|/g'
endfunction

function! table#AddColTable(...) abort
    let row_pos = getpos('.')[1]
    if a:0 == 0
        let add_col_num = 1
    elseif a:0 == 1
        let add_col_num = a:1
    endif
    let ran = s:search_table(row_pos)

    let cur_cell =  s:find_cur_table()
    if ran[1] != 0 && ran[3] != 0
        let num_row = ran[2] - ran[0] - 1
        for i_col in range(add_col_num)
            let row = ran[0]
            "headerと|--|を含む
            for j in range(num_row + 2)
                let appended_col = s:find_nth_col(getline(row), cur_cell[1]) + (i_col + 1)
                let line  = increment#appendVal(getline(row), '|', appended_col)
                call setline(row, line)
                let row += 1
            endfor
        endfor
    endif

    exe ':TableFormat'

endfunction

function! table#DelCell(isvisual) abort

    let t_cell = []
    if a:isvisual
        let d_range = range(getpos("'<")[1], getpos("'>")[1])
        for i in d_range
            let c_cell_range = s:find_col_cell(getline(i), getpos("'<")[2], getpos("'>")[2])
            call add(t_cell, c_cell_range)
        endfor
    else
        let d_range = [line('.')]
        let c_cell_range = s:find_col_cell(getline('.'), getpos('.')[2])
        call add(t_cell, c_cell_range)
    endif

    for i in range(len(d_range))
        let cell = split(getline(d_range[i]), '|')
        for c_n in t_cell[i]
            let cell[c_n - 1] = ' '
        endfor
        let last_i = len(cell)
        let cell[0] = '|' . cell[0]
        let cell[last_i - 1] = cell[last_i - 1] . '|'
        call setline(d_range[i], join(cell, '|'))
    endfor

    exe ':TableFormat'

endfunction

function table#ViewRow() abort

    let row = []
    let bind_n = []
    let s = getpos("'<")[1]
    let e = getpos("'>")[1]

    for i in range(s, e)
        call add(row, getline(i))
    endfor

    call add(bind_n, bufnr(''))
    setlocal nowrap
    exe 'silent split table-row'
    call add(bind_n, bufnr(''))
    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal noswapfile
    setlocal nobuflisted
    setlocal nomodeline
    for i in range(len(row))
        call append(i, row[i])
    endfor
    setlocal nomodifiable
    setlocal nowrap

    for n in bind_n
        call setwinvar(n, '&cursorbind', 1)
    endfor

    resize 1
    for i in range(len(row) - 1)
        resize +1
    endfor

endfunction

function! s:find_cur_table()
    "test
    let ran = s:search_table(0)

    if ran[1] == 0 && ran[3] == 0
        return []
    endif

    let r_cell = getpos('.')[1] - ran[0] - 1
    let c_cell = s:find_col_cell(getline('.'), getpos('.')[2])[0]

    return [r_cell, c_cell]
endfunction

function! s:find_col_cell(line, ...)
    let col = []
    let k_idx = stridx(a:line, "|")
    let i = 0

    if a:0 == 1
        while k_idx >= 0 && k_idx <= a:1
            let k_idx = stridx(a:line, "|", k_idx + 1)
            let i += 1
            let col = [i]
        endwhile
    else
        while k_idx >= 0 && k_idx <= a:2 
            let k_idx = stridx(a:line, "|", k_idx + 1)
            let i += 1
            if k_idx >= a:1
                call add(col, i)
            endif
        endwhile
    endif

    return col

endfunction

function! s:find_nth_col(line, n)
    let k_idx = stridx(a:line, "|")

    for i in range(a:n)
        let k_idx = stridx(a:line, "|", k_idx + 1)
    endfor

    return k_idx + 1
endfunction

function! s:search_table(row) abort 
    let cur_row = getpos('.')[1]

    "カーソル行含めて探索
    let up_range = s:search_next_line(cur_row, -1)
    let down_range = s:search_next_line(cur_row, 1)

    return up_range + down_range
endfunction

"最後の探索のみを考慮
function! s:search_next_line(row, dir)
    let n_row = a:row
    let num_matches = 0
    let info = [n_row, num_matches]

    while n_row > 0
        let num_matches = len(split(getline(n_row), '|', 1)) - 2
        if num_matches < 2
            break
        endif

        let info = [n_row, num_matches]
        let n_row += a:dir
    endwhile

    return info
endfunction


function! s:init() abort
    let s:first_pos = getpos('.')
endfunction

function! s:create_header(col, cur_row) abort
    call s:append_row(a:cur_row, a:col)
    call s:append_row(a:cur_row + 1, a:col)
endfunction

function s:create_data(row, col, cur_row) abort
    let next_row = a:cur_row
    for i in range(a:row)
        call s:append_row(next_row, a:col)
        let next_row += 1
    endfor
endfunction

function s:append_row(row_pos, col) abort
    let cell = ''
    for i in range(a:col + 1)
        let cell = cell . '|'
    endfor
    call append(a:row_pos - 1, cell)
endfunction
