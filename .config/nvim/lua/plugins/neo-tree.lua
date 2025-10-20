return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    keys = {
      { '<Space>ff', '<cmd>Neotree toggle<CR>', desc = 'Toggle Neo-tree' },
      { '<Space>ge', '<cmd>Neotree float git_status<CR>', desc = 'Neo-tree Git Status' },
    },
    config = function()
      require('neo-tree').setup({
        close_if_last_window = true,
        popup_border_style = 'rounded',
        enable_git_status = true,
        enable_diagnostics = true,
        bind_to_cwd = false,
        default_component_configs = {
          indent = {
            indent_size = 2,
            padding = 1,
            with_markers = true,
            indent_marker = '│',
            last_indent_marker = '└',
            highlight = 'NeoTreeIndentMarker',
          },
          icon = {
            folder_closed = '',
            folder_open = '',
            folder_empty = '',
            default = '',
          },
          git_status = {
            symbols = {
              added = '',
              modified = '',
              deleted = '✖',
              renamed = '➜',
              untracked = '★',
              ignored = '◌',
              unstaged = '✗',
              staged = '✓',
              conflict = '',
            },
          },
        },
        window = {
          position = 'left',
          width = 30,
          mappings = {
            ['<space>'] = 'toggle_node',
            ['<cr>'] = 'open',
            ['<esc>'] = 'revert_preview',
            ['P'] = { 'toggle_preview', config = { use_float = true } },
            ['l'] = 'focus_preview',
            ['s'] = 'open_split',
            ['v'] = 'open_vsplit',
            ['t'] = 'open_tabnew',
            ['C'] = 'close_node',
            ['z'] = 'close_all_nodes',
            ['Z'] = 'expand_all_nodes',
            ['R'] = 'refresh',
            ['a'] = {
              'add',
              config = {
                show_path = 'relative',
              },
            },
            ['A'] = 'add_directory',
            ['d'] = 'delete',
            ['r'] = 'rename',
            ['y'] = 'copy_to_clipboard',
            ['x'] = 'cut_to_clipboard',
            ['p'] = 'paste_from_clipboard',
            ['c'] = 'copy',
            ['m'] = 'move',
            ['q'] = 'close_window',
            ['?'] = 'show_help',
            ['<'] = 'prev_source',
            ['>'] = 'next_source',
            ['cd'] = 'set_root',
            ['u'] = 'navigate_up',
            ['.'] = 'set_root',
            ['<bs>'] = 'navigate_up',
          },
        },
        filesystem = {
          -- ルート変更時にファイルパスがホームディレクトリに変更されないように
          bind_to_cwd = false,
          filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_by_name = {
              '.git',
              '.DS_Store',
            },
            never_show = {
              '.git',
            },
          },
          follow_current_file = {
            enabled = true,
          },
          use_libuv_file_watcher = true,
          window = {
            mappings = {
              ['H'] = 'toggle_hidden',
              ['/'] = 'fuzzy_finder',
              ['f'] = 'filter_on_submit',
              ['<c-x>'] = 'clear_filter',
              ['[g'] = 'prev_git_modified',
              [']g'] = 'next_git_modified',
            },
          },
        },
        buffers = {
          follow_current_file = {
            enabled = true,
          },
        },
        git_status = {
          window = {
            position = 'float',
            mappings = {
              ['A'] = 'git_add_all',
              ['gu'] = 'git_unstage_file',
              ['ga'] = 'git_add_file',
              ['gr'] = 'git_revert_file',
              ['gc'] = 'git_commit',
              ['gp'] = 'git_push',
              ['gg'] = 'git_commit_and_push',
            },
          },
        },
      })
    end,
  },
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
  },
  {
    'MunifTanjim/nui.nvim',
    lazy = true,
  },
}
