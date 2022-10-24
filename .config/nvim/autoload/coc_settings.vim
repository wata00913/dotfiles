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
    let g:coc_data_home='~/lsp/coc'
endfunction

function! s:completion_settings() abort
    " color schema
    " 既存のカラーコマンドをロードする際にハイライト設定がクリアされるので、
    " autocmd ColorSchemeを使う
    " https://github.com/neoclide/coc.nvim/wiki/F.A.Q#some-highlight-groups-not-work-after-colorscheme-command
    autocmd ColorScheme * call s:completion_highlight()

    " 補完の初期表示時に未選択状態にする設定は`suggest.noselect`で行う
    inoremap <silent><expr> <C-n>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
    inoremap <expr><C-p> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
    inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    inoremap <silent><expr> <C-k> coc#refresh()
    
    nnoremap <Space>ls :CocStart<CR>
endfunction

function! s:completion_highlight() abort
    hi CocSearch ctermfg=white guifg=white
    hi CocMenuSel ctermbg=gray guibg=gray
endfunction

function! CheckBackspace() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:action_settings() abort
    let action_to_rhs = {
         \ 'textDocument_definition'        :['plug', '(coc-definition)'],
         \ 'textDocument_references'        :['plug', '(coc-references)'],
         \ 'textDocument_rename'            :['plug', '(coc-rename)'],
         \ 'textDocument_documentSymbol'    :['command', 'CocFzfList outline<CR>'],
         \ 'textDocument_documentHighlight' :['func', "CocAction('highlight')<CR>"],
         \ 'textDocument_formatting'        :['plug', '(coc-format)']
    \}

    call lsp_mapper#register(action_to_rhs)
endfunction
