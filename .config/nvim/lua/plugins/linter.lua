return {
  {
    'w0rp/ale',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      vim.keymap.set('n', '<C-a>p', '<Plug>(ale_previous_error)', { silent = true })
      vim.keymap.set('n', '<C-a>n', '<Plug>(ale_next_error)', { silent = true })
      
      vim.g.ale_lint_on_text_changed = 0
      vim.g.ale_sign_error = '✖'
      vim.g.ale_sign_warning = '⚠'
      vim.g.ale_fix_on_save = 1
      vim.g.ale_fixers = {
        java = { 'google_java_format' },
      }
      
      local php_bin_path = ''
      if vim.fn.has('unix') == 1 then
        php_bin_path = vim.fn.expand('$HOME/.composer/vendor/bin')
      end
      
      vim.g.ale_php_phpmd_executable = php_bin_path .. '/phpmd'
      vim.g.ale_php_phpcs_executable = php_bin_path .. '/phpcs'
      vim.g.ale_linters = {
        python = { 'flake8' },
        php = { 'phpcs', 'phpmd', 'php' },
      }
    end,
  },
}
