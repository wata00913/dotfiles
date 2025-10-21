return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('gitsigns').setup({
        signs = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signcolumn = true,
        numhl      = false,
        linehl     = false,
        word_diff  = false,
        watch_gitdir = {
          follow_files = true
        },
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol',
          delay = 1000,
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, {expr=true})

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, {expr=true})

          -- Actions
          map('n', '<Space>hh', gs.stage_hunk)
          map('n', '<Space>hu', gs.undo_stage_hunk)
          map('n', '<Space>hs', gs.stage_buffer) -- バッファ全体をステージング
          map('n', '<Space>hU', gs.reset_buffer_index) -- ステージング全体を取り消し
          map('n', '<Space>hr', gs.reset_hunk)
          map('n', '<Space>hR', gs.reset_buffer)
          map('v', '<Space>hh', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
          map('v', '<Space>hu', function() gs.undo_stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
          map('v', '<Space>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
          map('n', '<Space>hp', gs.preview_hunk)
          map('n', '<Space>hb', function() gs.blame_line{full=true} end)
          map('n', '<Space>tb', gs.toggle_current_line_blame)
          map('n', '<Space>hd', gs.diffthis)
          map('n', '<Space>hD', function() gs.diffthis('~') end)
          map('n', '<Space>td', gs.toggle_deleted)

          -- Text object
          map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
      })
    end,
  },
}
