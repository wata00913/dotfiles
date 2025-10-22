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
  {
    'numToStr/Comment.nvim',
    lazy = false,
    config = function()
      require('Comment').setup()
      vim.keymap.set('n', '<space>cc', '<Plug>(comment_toggle_linewise_current)', { desc = 'Comment toggle current line' })
      vim.keymap.set('v', '<space>cc', '<Plug>(comment_toggle_linewise_visual)', { desc = 'Comment toggle linewise (visual)' })
      vim.keymap.set('n', '<space>cb', '<Plug>(comment_toggle_blockwise_current)', { desc = 'Comment toggle current block' })
      vim.keymap.set('v', '<space>cb', '<Plug>(comment_toggle_blockwise_visual)', { desc = 'Comment toggle blockwise (visual)' })
    end,
  },
}
