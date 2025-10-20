return {
  {
    'godlygeek/tabular',
    cmd = 'Tabularize',
  },
  {
    'plasticboy/vim-markdown',
    ft = 'markdown',
    dependencies = { 'godlygeek/tabular' },
    config = function()
      vim.keymap.set('n', '<Space>mtt', '<cmd>TableFormat<CR>', { silent = true })
    end,
  },
  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    build = 'cd app && yarn install',
    config = function()
      vim.keymap.set('n', 'ms', '<cmd>MarkdownPreview<CR>', { silent = true })
      vim.keymap.set('n', 'mq', '<cmd>MarkdownPreviewStop<CR>', { silent = true })
    end,
  },
}
