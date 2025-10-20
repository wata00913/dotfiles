return {
  {
    'skanehira/translate.vim',
    cmd = 'Translate',
  },
  {
    'prettier/vim-prettier',
    build = 'yarn install',
    ft = { 'php', 'python', 'javascript', 'typescript', 'css', 'json', 'markdown' },
  },
  {
    'metakirby5/codi.vim',
    ft = { 'php', 'javascript', 'python' },
    config = function()
      local function new_codi()
        local ft_to_ext = {
          python = 'py',
          javascript = 'js',
          php = 'php',
        }
        local ft = vim.bo.filetype
        if ft_to_ext[ft] then
          vim.cmd('edit $HOME/.codi.' .. ft_to_ext[ft])
          vim.cmd('Codi')
        end
      end
      
      vim.api.nvim_create_user_command('NewCodi', new_codi, {})
      vim.keymap.set('n', '<Space>cdn', '<cmd>NewCodi<CR>', { silent = true })
      
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'python', 'javascript', 'php' },
        callback = function()
          vim.keymap.set('n', '<Space>cdi', '<cmd>Codi<CR>', { buffer = true, silent = true })
          vim.keymap.set('n', '<Space>cdt', '<cmd>Codi!!<CR>', { buffer = true, silent = true })
        end,
      })
    end,
  },
  {
    'Shougo/deol.nvim',
    cmd = 'Deol',
    config = function()
      vim.keymap.set('t', '<C-[>', '<C-\\><C-n>', { silent = true })
      vim.keymap.set('n', '<C-m>s', '<cmd>Deol -edit -split=horizontally<CR>', { silent = true })
      vim.keymap.set('n', '<C-m>v', '<cmd>Deol -edit -split=vertically<CR>', { silent = true })
    end,
  },
}
