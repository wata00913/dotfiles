function! coc_settings#run() abort
    call s:common_settings()
    call s:completion_settings()
    call s:action_settings()
endfunction

function! s:common_settings() abort
    "詳細はcoc.nvimのREADMEを参照
    set nobackup
    set nowritebackup
    set updatetime=300
    set signcolumn=yes

    let g:coc_config_home='~/lsp/coc'
endfunction

function! s:completion_settings() abort
    inoremap <silent><expr> <C-n>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
    inoremap <expr><C-p> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
    inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    inoremap <silent><expr> <C-k> coc#refresh()
endfunction

function! CheckBackspace() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:action_settings() abort
    let action_to_func = {
         \ 'textDocument_definition'        :"CocActionAsync('jumpDefinition')",
         \ 'textDocument_references'        :"CocActionAsync('references')",
         \ 'textDocument_rename'            :"CocActionAsync('rename')",
         \ 'textDocument_documentSymbol'    :"CocActionAsync('diagnosticInfo')",
         \ 'textDocument_documentHighlight' :"CocActionAsync('highlight')",
         \ 'textDocument_formatting'        :"CocActionAsync('format')"
    \}

    autocmd CursorHold * silent call CocActionAsync('highlight')

    call lsp_mapper#register(action_to_func)
endfunction
