return {
  {
    'junegunn/fzf.vim',
    dependencies = {
      {
        'junegunn/fzf',
        build = function()
          vim.fn['fzf#install']()
        end,
      },
    },
    keys = {
      { '<Space>uf', '<cmd>FzfFiles<cr>', desc = 'FZF Files' },
      { '<Space>ub', '<cmd>FzfBuffers<cr>', desc = 'FZF Buffers' },
      { '<Space>uw', '<cmd>FzfWindows<cr>', desc = 'FZF Windows' },
      { '<Space>uh', '<cmd>FzfHistory:<cr>', desc = 'FZF Command History' },
      { '<Space>u/', '<cmd>FzfHistory/<cr>', desc = 'FZF Search History' },
      { '<Space>uc', '<cmd>FzfCommits<cr>', desc = 'FZF Commits' },
      { '<Space>uv', '<cmd>FzfBCommits<cr>', desc = 'FZF Buffer Commits' },
    },
    init = function()
      vim.g.fzf_command_prefix = 'Fzf'
    end,
    config = function()
      vim.g.fzf_action = {
        ['ctrl-t'] = 'select-all',
        ['ctrl-s'] = 'split',
        ['ctrl-e'] = function(lines)
          vim.fn.setqflist(vim.tbl_map(function(val)
            return { filename = val }
          end, lines))
          vim.cmd('copen')
          vim.cmd('cc')
        end,
        ['ctrl-l'] = function(lines)
          vim.fn.setreg('', vim.fn.substitute(lines[1], '\n', '', 'g'))
        end,
        ['ctrl-y'] = function(lines)
          vim.fn.setreg('*', table.concat(lines, '\n'))
        end,
      }
      
      vim.api.nvim_create_user_command('FzfLines', function()
        local query = vim.fn.input('Pattern>')
        vim.cmd('FzfLines ' .. query)
      end, {})
      
      vim.keymap.set('n', '<Space>ul', '<cmd>FzfLines<cr>', { silent = true })
      
      vim.api.nvim_create_user_command('FzfAg', function(opts)
        local query = opts.args ~= '' and opts.args or vim.fn.input('Pattern>')
        vim.fn['fzf#vim#ag'](query, { options = '--bind ctrl-a:select-all,ctrl-d:deselect-all' })
      end, { nargs = '?' })
      
      vim.keymap.set('n', '<Space>ug', '<cmd>FzfAg<cr>', { silent = true })
      vim.keymap.set('n', '<Space>ur', function()
        vim.cmd('FzfAg ' .. vim.fn.expand('<cword>'))
      end, { silent = true })
      
      vim.api.nvim_create_user_command('FzfGitDiff', function()
        vim.cmd('GitGutterQuickFix')
        local qflist = vim.fn.getqflist()
        local lines = vim.tbl_map(function(val)
          return table.concat({
            vim.fn.bufname(val.bufnr),
            val.lnum,
            val.text
          }, ':')
        end, qflist)
        
        vim.fn['fzf#run'](vim.fn['fzf#wrap']({
          source = lines,
          sink = function(line)
            local parsed = vim.split(line, ':')
            vim.cmd('e ' .. parsed[1])
            vim.fn.cursor(tonumber(parsed[2]), 1)
          end,
        }))
      end, {})
      
      vim.keymap.set('n', '<Space>uu', '<cmd>FzfGitDiff<cr>', { silent = true })
    end,
  },
}
