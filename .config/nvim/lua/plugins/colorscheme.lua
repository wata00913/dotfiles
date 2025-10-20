return {
  {
    'tomasr/molokai',
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.background = 'dark'
      vim.cmd('colorscheme molokai')
    end,
  },
  {
    'challenger-deep-theme/vim',
    lazy = true,
  },
  {
    'doums/darcula',
    lazy = true,
  },
}
