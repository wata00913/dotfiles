"vi互換を無効
if &compatible
  set nocompatible
endif

function! s:get_dependency_runtimepath(path) abort
    return (has('unix')||has('mac')) ? fnamemodify(a:path, ':p') : a:path
endfunction

"True Color
if has('nvim')
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
	if (has("termguicolors"))
		set termguicolors
	endif
elseif has('patch-7.4.1778')
	set guicolors
endif
if has('unix') || has('mac')
    let g:conf_dir = expand($XDG_CONFIG_HOME. '/nvim')
    let g:pyenv_path = expand($PYENV_ROOT. '/shims/python')
elseif has('win64') || has('win32')
    let g:conf_dir = expand($LOCALAPPDATA. '/nvim')
    let g:pyenv_path = expand($LOCALAPPDATA. '/Programs/Python/Python37/python')
endif
" Add the dein installation directory into runtimepath
let s:dein_cache_path = expand($XDG_CACHE_HOME.'/nvim')
let s:dein_dir = expand(s:dein_cache_path
	\ .'/repos/github.com/Shougo/dein.vim')

if &runtimepath !~# '/dein.vim'
	if !isdirectory(s:dein_dir)
		execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
	endif
	execute 'set runtimepath+=' . s:get_dependency_runtimepath(s:dein_dir)
endif

if &runtimepath !~# '/rplugin/python3'
        let s:dein_plugin_dir = expand(s:dein_dir.'/rplugin/python3')
	execute 'set runtimepath+=' . s:get_dependency_runtimepath(s:dein_plugin_dir)
endif

if dein#load_state(s:dein_cache_path)
  call dein#begin(s:dein_cache_path)

  let s:dein_conf_path = expand(g:conf_dir. '/dein.toml')
  let s:dein_lazy_conf_path = expand(g:conf_dir. '/deinlazy.toml')
  let s:dein_ft_conf_path = expand(g:conf_dir. '/deinft.toml')

  call dein#add(s:dein_dir)
  call dein#load_toml(s:dein_conf_path, {'lazy' : 0})
  call dein#load_toml(s:dein_lazy_conf_path, {'lazy' : 1})
  call dein#load_toml(s:dein_ft_conf_path)
  
  call dein#end()
  call dein#save_state()
endif

let g:python3_host_prog= g:pyenv_path

if dein#check_install()
	call dein#install()
endif

runtime! ./options.rc.vim
runtime! ./keymap.rc.vim
runtime! ./functions.rc.vim

"plugin編集用ファイル
if &runtimepath !~# '/plugins'
        let s:my_plugin_dir = expand(g:conf_dir.'/plugins')
	execute 'set runtimepath+=' . s:get_dependency_runtimepath(s:my_plugin_dir)
endif

"ポップアップ非表示
autocmd FileType python setlocal completeopt-=preview

let s:mysnippetsDir = expand(g:conf_dir . '/UltiSnips')
execute 'set runtimepath+=' . s:mysnippetsDir
filetype plugin indent on
syntax enable

