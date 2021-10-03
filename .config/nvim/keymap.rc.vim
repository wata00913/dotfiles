nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
noremap <C-j> 10j
noremap <C-k> 10k
nnoremap ; :
nnoremap : ;

"insert to normal
inoremap <silent> jj <ESC>:<C-u>w<CR>

"TODO leaderが効かない
let g:mapleader = ","

"key mapping
nnoremap [markdownpreview] <Nop>
nmap m [markdownpreview]

nnoremap [ale] <Nop>
nmap <C-a> [ale]

nnoremap [denite] <Nop>
nmap <C-u> [denite]
vnoremap [denite_v] <Nop>
vmap <C-u> [denite_v]

"nerdtreeだとmappingが効かない
nnoremap [nerd] <Nop>
nmap <C-n> [nerd]
"key mapping


autocmd FileType php call s:my_php_mappings()
function! s:my_php_mappings() abort
    nnoremap <silent><C-d> :call <SID>DollarSign()<CR>
endfunction

function! s:DollarSign() abort
    let pos_col = col('.')
    if pos_col != 1
        execute ":normal! b"
    endif
    execute ":normal! i" . '$'
endfunction

command! -nargs=? AddRowTable call table#AddRowTable(<f-args>)
command! -nargs=? AddColTable call table#AddColTable(<f-args>)
"my plugin commmand 
command! -nargs=+ CreateTable call table#CreateTable(<f-args>)
command! -nargs=+ IncRange call increment#IncrementRange(<f-args>)

nnoremap <silent> <Space>mdd :<C-u>call table#DelCell(0)<CR>
vnoremap <silent> <Space>mdd :<C-u>call table#DelCell(1)<CR>
nnoremap <silent> <Leader>mtt :<C-u>call table#ToggleFormat()<CR>
vnoremap <silent> <Space>mjj :<C-u>call table#ViewRow()<CR>
