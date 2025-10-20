return {
  {
    'neoclide/coc.nvim',
    branch = 'release',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      if vim.fn.exists('*coc_settings#run') == 1 then
        vim.fn['coc_settings#run']()
      end
    end,
  },
  {
    'antoinemadec/coc-fzf',
    dependencies = { 'neoclide/coc.nvim' },
    cmd = { 'CocFzfList', 'CocFzfListResume' },
  },
  {
    'honza/vim-snippets',
    event = 'InsertEnter',
  },
  {
    'SirVer/ultisnips',
    event = 'InsertEnter',
    config = function()
      vim.g.UltiSnipsExpandTrigger = '<C-t>'
      vim.g.UltiSnipsJumpForwardTrigger = '<C-j>'
      vim.g.UltiSnipsJumpBackwardTrigger = '<C-k>'
      
      local mysnippets_dir = vim.g.conf_dir .. '/mycoolsnippets'
      vim.g.UltiSnipsSnippetDirectories = { mysnippets_dir, 'UltiSnips' }
      vim.opt.runtimepath:prepend(mysnippets_dir)
    end,
  },
  {
    'deoplete-plugins/deoplete-zsh',
    ft = 'zsh',
  },
}
