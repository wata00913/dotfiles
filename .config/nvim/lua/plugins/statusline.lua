return {
  {
    'vim-airline/vim-airline',
    lazy = false,
    config = function()
      vim.g['airline#extensions#tabline#buffer_idx_mode'] = 1
      vim.g['airline#extensions#tabline#enabled'] = 1
      
      vim.keymap.set('n', '<Space>1', '<Plug>AirlineSelectTab1')
      vim.keymap.set('n', '<Space>2', '<Plug>AirlineSelectTab2')
      vim.keymap.set('n', '<Space>3', '<Plug>AirlineSelectTab3')
      vim.keymap.set('n', '<Space>4', '<Plug>AirlineSelectTab4')
      vim.keymap.set('n', '<Space>5', '<Plug>AirlineSelectTab5')
      vim.keymap.set('n', '<Space>6', '<Plug>AirlineSelectTab6')
      vim.keymap.set('n', '<Space>7', '<Plug>AirlineSelectTab7')
      vim.keymap.set('n', '<Space>8', '<Plug>AirlineSelectTab8')
      vim.keymap.set('n', '<Space>9', '<Plug>AirlineSelectTab9')
      vim.keymap.set('n', '<Space>h', '<Plug>AirlineSelectPrevTab')
      vim.keymap.set('n', '<Space>l', '<Plug>AirlineSelectNextTab')
    end,
  },
}
