return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      local cmp_nvim_lsp = require('cmp_nvim_lsp')

      -- document_symbolをkindでフィルタリングする共通関数
      local function filter_document_symbols(kinds, title)
        vim.lsp.buf.document_symbol({
          on_list = function(options)
            local items = {}
            for _, item in ipairs(options.items) do
              for _, kind in ipairs(kinds) do
                if item.kind == kind then
                  table.insert(items, item)
                  break
                end
              end
            end
            vim.fn.setqflist({}, 'r', { title = title, items = items })
            vim.cmd('copen')
          end
        })
      end

      -- LSPのキーマップ設定
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local bufnr = args.buf
          local opts = { noremap = true, silent = true, buffer = bufnr }

          vim.keymap.set('n', '<space>l[', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', '<space>l]', vim.lsp.buf.references, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<space>lr', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<space>la', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<space>ld', vim.lsp.buf.document_symbol, opts)
          vim.keymap.set('n', '<space>lh', vim.lsp.buf.document_highlight, opts)
          vim.keymap.set('n', '<space>lf', function()
            vim.lsp.buf.format({ async = true })
          end, opts)
          vim.keymap.set('n', '<C-h>', vim.diagnostic.goto_prev, opts)
          vim.keymap.set('n', '<C-l>', vim.diagnostic.goto_next, opts)
          vim.keymap.set('n', ':', vim.diagnostic.open_float, opts)
          vim.keymap.set('n', '<space>le', vim.diagnostic.setloclist, opts)

          -- Methodだけを抽出してquickfixに追加
          vim.keymap.set('n', '<space>lm', function()
            filter_document_symbols({ 'Method' }, 'Methods')  -- 6 = Method
          end, opts)
        end,
      })

      -- 診断表示の設定
      vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = 'rounded',
          source = 'always',
        },
      })

      -- virtual_textの表示/非表示を切り替える関数
      local virtual_text_enabled = false
      local function toggle_virtual_text()
        virtual_text_enabled = not virtual_text_enabled
        vim.diagnostic.config({
          virtual_text = virtual_text_enabled and {
            prefix = '●',
          } or false,
        })
        print('Virtual text ' .. (virtual_text_enabled and 'enabled' or 'disabled'))
      end

      -- キーマップを設定
      vim.keymap.set('n', '<space>lv', toggle_virtual_text, { noremap = true, silent = true, desc = 'Toggle diagnostics virtual text' })

      -- 診断記号の設定
      local signs = { Error = '✖', Warn = '⚠', Hint = '', Info = '' }
      for type, icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      -- LSPの機能を補完に統合
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- Lua用の特別な設定
      vim.lsp.config('lua_ls', {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      -- -- efm-langserver用の設定
      local eslint = {
        lintCommand = 'yarn eslint -f visualstudio --stdin --stdin-filename ${INPUT}',
        lintStdin = true,
        lintFormats = { '%f(%l,%c): %tarning %m', '%f(%l,%c): %rror %m' },
        lintIgnoreExitCode = true,
        formatCommand = 'eslint_d --fix-to-stdout --stdin --stdin-filename ${INPUT}',
        formatStdin = true,
        init_options = {
          documentFormatting = false,
          documentRangeFormatting = false,
        },
      }

      local prettier = {
        formatCommand = 'yarn prettier --stdin-filepath ${INPUT}',
        formatStdin = true,
        rootMarkers = {
          '.prettierrc',
          '.prettierrc.json',
          '.prettierrc.js',
          '.prettierrc.yml',
          '.prettierrc.yaml',
          '.prettierrc.json5',
          '.prettierrc.mjs',
          '.prettierrc.cjs',
          '.prettierrc.toml',
        },
        init_options = {
          documentFormatting = true,
          documentRangeFormatting = true,
        },
      }

      vim.lsp.config('efm-lsp', {
        cmd = { 'efm-langserver' },
        capabilities = capabilities,
        filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'json', 'html', 'css', 'scss', 'markdown' },
        init_options = {
         documentFormatting = true,
         documentRangeFormatting = true,
        }   ,
         settings = {
           rootMarkers = { '.git/', 'package.json' },
           languages = {
             javascript = { eslint, prettier },
             javascriptreact = { eslint, prettier },
             typescript = { eslint, prettier },
             typescriptreact = { eslint, prettier },
             vue = { eslint, prettier },
             json = { prettier },
             html = { prettier },
             css = { prettier },
             scss = { prettier },
             markdown = { prettier },
           },
         },
       })

      vim.lsp.config('ts', {
        cmd = { 'typescript-language-server --stdio' },
        init_options = {
          documentFormatting = false,
          documentRangeFormatting = false,
        },
      })

      -- 各言語サーバーにcapabilitiesを設定
      local servers = {
        'ts',
        'pyright',
        'solargraph',
        'intelephense',
        'gopls',
        'rust_analyzer',
        'html',
        'cssls',
        'jsonls',
        'efm-lsp'
      }

      for _, server in ipairs(servers) do
        vim.lsp.config(server, {
          capabilities = capabilities,
        })
      end

      -- 各言語サーバーを有効化
      vim.lsp.enable('ts_ls')
      vim.lsp.enable('pyright')
      vim.lsp.enable('solargraph')
      vim.lsp.enable('lua_ls')
      vim.lsp.enable('intelephense')
      vim.lsp.enable('gopls')
      vim.lsp.enable('rust_analyzer')
      vim.lsp.enable('html')
      vim.lsp.enable('cssls')
      vim.lsp.enable('jsonls')
      vim.lsp.enable('efm-lsp')
    end,
  },
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    keys = { { '<leader>m', '<cmd>Mason<cr>', desc = 'Mason' } },
    build = ':MasonUpdate',
    config = function()
      require('mason').setup({
        ui = {
          border = 'rounded',
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
          },
        },
      })
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'pyright',
          'lua_ls',
          'intelephense',
          'gopls',
          'rust_analyzer',
          'html',
          'cssls',
          'jsonls',
        },
        automatic_installation = true,
      })
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-j>'] = cmp.mapping.scroll_docs(-4),
          ['<C-k>'] = cmp.mapping.scroll_docs(4),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        }),
        formatting = {
          format = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = '[LSP]',
              luasnip = '[Snippet]',
              buffer = '[Buffer]',
              path = '[Path]',
            })[entry.source.name]
            return vim_item
          end,
        },
      })

      -- コマンドライン補完
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
          { name = 'cmdline' },
        }),
      })

      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })
    end,
  },
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    build = 'make install_jsregexp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },
  {
    'rafamadriz/friendly-snippets',
    lazy = true,
  },
}
