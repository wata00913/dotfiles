return {
  {
    'thinca/vim-qfreplace',
    cmd = 'Qfreplace',
  },
  {
    'kana/vim-submode',
    lazy = false,
    config = function()
      vim.opt.background = 'dark'
      vim.fn['submode#enter_with']('window_move', 'n', '', 's>', '<C-w>>')
      vim.fn['submode#enter_with']('window_move', 'n', '', 's<', '<C-w><')
      vim.fn['submode#enter_with']('window_move', 'n', '', 's+', '<C-w>+')
      vim.fn['submode#enter_with']('window_move', 'n', '', 's-', '<C-w>-')
      vim.fn['submode#map']('window_move', 'n', '', '>', '<C-w>>')
      vim.fn['submode#map']('window_move', 'n', '', '<', '<C-w><')
      vim.fn['submode#map']('window_move', 'n', '', '+', '<C-w>+')
      vim.fn['submode#map']('window_move', 'n', '', '-', '<C-w>-')

      vim.fn['submode#enter_with']('bufmove', 'n', '', '<Space>sb', '<Nop>')
      vim.fn['submode#map']('bufmove', 'n', '', 'j', '<C-w>j')
      vim.fn['submode#map']('bufmove', 'n', '', 'k', '<C-w>k')
      vim.fn['submode#map']('bufmove', 'n', '', 'l', '<C-w>l')
      vim.fn['submode#map']('bufmove', 'n', '', 'h', '<C-w>h')

      vim.fn['submode#enter_with']('tabmove', 'n', '', '<Space>st', '<Nop>')
      vim.fn['submode#map']('bufmove', 'n', '', 'n', ':tabnext<CR>')
      vim.fn['submode#map']('bufmove', 'n', '', 'p', ':tabprevious<CR>')
    end,
  },
  {
    'tpope/vim-surround',
    event = 'VeryLazy',
  },
  {
    'scrooloose/nerdcommenter',
    keys = { { '<leader>c', mode = { 'n', 'v' } } },
  },
  {
    'phaazon/hop.nvim',
    branch = 'v2',
    keys = {
      { '<Space>kk', '<cmd>HopWord<CR>', desc = 'Hop Word' },
      { '<Space>kp', '<cmd>HopPattern<CR>', desc = 'Hop Pattern' },
      { '<Space>kc', '<cmd>HopChar1<CR>', desc = 'Hop Char' },
      { '<Space>kl', '<cmd>HopLine<CR>', desc = 'Hop Line' },
    },
    config = function()
      require('hop').setup()
    end,
  },
}
