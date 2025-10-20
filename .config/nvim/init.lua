-- vi互換を無効
vim.opt.compatible = false

-- True Color
if vim.fn.has('nvim') == 1 then
  vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
  if vim.fn.has('termguicolors') == 1 then
    vim.opt.termguicolors = true
  end
elseif vim.fn.has('patch-7.4.1778') == 1 then
  vim.opt.guicolors = true
end

-- パス設定
local conf_dir
local pyenv_path

if vim.fn.has('unix') == 1 or vim.fn.has('mac') == 1 then
  conf_dir = vim.fn.expand('$XDG_CONFIG_HOME/nvim')
  pyenv_path = vim.fn.expand('$PYENV_ROOT/shims/python')
elseif vim.fn.has('win64') == 1 or vim.fn.has('win32') == 1 then
  conf_dir = vim.fn.expand('$LOCALAPPDATA/nvim')
  pyenv_path = vim.fn.expand('$LOCALAPPDATA/Programs/Python/Python37/python')
end

vim.g.conf_dir = conf_dir
vim.g.pyenv_path = pyenv_path

-- dein.vim設定
local dein_cache_path = vim.fn.expand('$XDG_CACHE_HOME/nvim')
local dein_dir = dein_cache_path .. '/repos/github.com/Shougo/dein.vim'

local function get_dependency_runtimepath(path)
  if vim.fn.has('unix') == 1 or vim.fn.has('mac') == 1 then
    return vim.fn.fnamemodify(path, ':p')
  else
    return path
  end
end

-- dein.vimのインストールチェック
if not string.match(vim.o.runtimepath, '/dein.vim') then
  if vim.fn.isdirectory(dein_dir) == 0 then
    vim.fn.system('git clone https://github.com/Shougo/dein.vim ' .. dein_dir)
  end
  vim.opt.runtimepath:prepend(get_dependency_runtimepath(dein_dir))
end

-- rpluginパス追加
if not string.match(vim.o.runtimepath, '/rplugin/python3') then
  local dein_plugin_dir = dein_dir .. '/rplugin/python3'
  vim.opt.runtimepath:prepend(get_dependency_runtimepath(dein_plugin_dir))
end

-- dein.vimの初期化
if vim.fn['dein#load_state'](dein_cache_path) == 1 then
  vim.fn['dein#begin'](dein_cache_path)

  local dein_conf_path = conf_dir .. '/dein.toml'
  local dein_lazy_conf_path = conf_dir .. '/deinlazy.toml'
  local dein_ft_conf_path = conf_dir .. '/deinft.toml'

  vim.fn['dein#add'](dein_dir)
  vim.fn['dein#load_toml'](dein_conf_path, {lazy = 0})
  vim.fn['dein#load_toml'](dein_lazy_conf_path, {lazy = 1})
  vim.fn['dein#load_toml'](dein_ft_conf_path)

  vim.fn['dein#end']()
  vim.fn['dein#save_state']()
end

-- Python3ホストプログラム設定
vim.g.python3_host_prog = pyenv_path

-- deinプラグインの自動インストール
if vim.fn['dein#check_install']() == 1 then
  vim.fn['dein#install']()
end

-- 設定ファイルの読み込み
vim.cmd('runtime! ./options.rc.vim')
vim.cmd('runtime! ./keymap.rc.vim')
vim.cmd('runtime! ./functions.rc.vim')

-- 自作プラグインディレクトリの追加
if not string.match(vim.o.runtimepath, '/plugins') then
  local my_plugin_dir = conf_dir .. '/plugins'
  vim.opt.runtimepath:prepend(get_dependency_runtimepath(my_plugin_dir))
end

-- ポップアップ非表示
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    vim.opt_local.completeopt:remove('preview')
  end,
})

-- UltiSnipsディレクトリの追加
local mysnippets_dir = conf_dir .. '/UltiSnips'
vim.opt.runtimepath:prepend(mysnippets_dir)

-- ファイルタイプとシンタックスの有効化
vim.cmd('filetype plugin indent on')
vim.cmd('syntax enable')
