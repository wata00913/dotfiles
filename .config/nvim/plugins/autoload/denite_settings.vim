function! denite_settings#my_settings() abort
    call s:DeniteOptions()
endfunction

function! denite_settings#denite_visual_grep() abort
    let l_i = col("'<") - 1
    let r_i = col("'>") - 1

    if line("'<") != line("'>")
        "TODO
        return
    else
        let sub_line = getline('.')[l_i:r_i]
    endif
    execute 'Denite grep:::' . sub_line . ' -buffer-name=search-buffer-denite<CR>'
endfunction

function! s:DeniteOptions() abort
    call denite#custom#source('file/rec', 'matchers',
                \['matcher/fuzzy', 'matcher/ignore_globs'])
    call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
        \['.git/', '.svn/', '.DS_Store', '.metadata/', '*.log', 
        \ 'lib/'])
endfunction

