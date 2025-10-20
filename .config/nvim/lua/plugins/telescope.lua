return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<Space>tf', '<cmd>Telescope find_files<CR>', desc = 'Find files' },
      { '<Space>tg', '<cmd>Telescope grep_string<CR>', desc = 'Grep string' },
      { '<Space>tl', '<cmd>Telescope live_grep<CR>', desc = 'Live grep' },
      { '<Space>tb', '<cmd>Telescope buffers<CR>', desc = 'Buffers' },
    },
  },
  {
    'nvim-lua/plenary.nvim',
    lazy = true,
  },
}
