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

-- Python3ホストプログラム設定
vim.g.python3_host_prog = pyenv_path

-- lazy.nvim設定
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

-- lazy.nvimでプラグインを読み込み
require('lazy').setup('plugins', {
  defaults = {
    lazy = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})

-- 設定ファイルの読み込み
vim.cmd('runtime! ./options.rc.vim')
vim.cmd('runtime! ./keymap.rc.vim')
vim.cmd('runtime! ./functions.rc.vim')

-- 自作プラグインディレクトリの追加
local function get_dependency_runtimepath(path)
  if vim.fn.has('unix') == 1 or vim.fn.has('mac') == 1 then
    return vim.fn.fnamemodify(path, ':p')
  else
    return path
  end
end

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
