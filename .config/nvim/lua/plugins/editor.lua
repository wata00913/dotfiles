return {
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
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
}
