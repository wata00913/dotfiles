return {
  {
    'mattn/emmet-vim',
    ft = { 'css', 'html', 'xhtml', 'php' },
    config = function()
      vim.g.user_emmet_mode = 'nv'
      vim.g.user_emmet_settings = {
        variables = {
          lang = 'ja',
        },
      }
    end,
  },
  {
    'gregsexton/MatchTag',
    ft = { 'html', 'xhtml', 'php' },
  },
}
