set number
set cursorline
set showmatch

"編集中でのファイル開示
set hidden

"検索，置換
set hlsearch "検索文字列ハイライト
set incsearch 
set ignorecase "大文字小文字の区別しない
set smartcase "大文字，小文字の混在のみ区別

"tab,indent
set expandtab "タブ入力を複数の空白入力に置き換え
set tabstop=2
set shiftwidth=4
set autoindent
set smartindent
set relativenumber "相対行表示

"カラースキーム
syntax on
colorscheme challenger_deep

"fzf
if has('mac')
    execute 'set runtimepath+=' . fnamemodify('/usr/local/opt/fzf', ':p')
elseif has('unix')
    execute 'set runtimepath+=' . fnamemodify('~/.fzf', ':p')
endif
 
    
