return {
  {
    'airblade/vim-gitgutter',
    event = { 'BufReadPre', 'BufNewFile' },
  },
  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'Gstatus', 'Gblame', 'Gpush', 'Gpull' },
  },
  {
    'lighttiger2505/gtags.vim',
    event = 'VeryLazy',
    config = function()
      vim.g.Gtags_Auto_Map = 0
      vim.g.Gtags_OpenQuickfixWindow = 1
      
      vim.keymap.set('n', '<Space>g]', function()
        vim.cmd('Gtags ' .. vim.fn.expand('<cword>'))
      end, { silent = true })
      
      vim.keymap.set('n', '<Space>g[', function()
        vim.cmd('Gtags -r ' .. vim.fn.expand('<cword>'))
      end, { silent = true })
    end,
  },
}
