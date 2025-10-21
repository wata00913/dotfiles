return {
    {
        "github/copilot.vim",
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "github/copilot.vim" },                 -- or zbirenbaum/copilot.lua
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken",                      -- Only on MacOS or Linux
        opts = {
            -- See Configuration section for options
        },
        -- See Commands section for default commands if you want to lazy load on them
        config = function()
            require('CopilotChat').setup({
                window = {
                    layout = 'replace',
                    width = 80,
                    height = 20,
                    border = 'rounded',
                    title = '🤖 AI Assistant',
                    zindex = 100,
                },

                headers = {
                    user = '👤 You',
                    assistant = '🤖 Copilot',
                    tool = '🔧 Tool',
                },

                separator = '━━',
                auto_fold = true,
            })

            -- キーマップ: 右側にvsplitしてからCopilotChatを開く
            vim.keymap.set('n', '<space>cc', function()
                vim.cmd('vsplit')
                vim.cmd('wincmd l')
                vim.cmd('vertical resize 60')  -- 幅を60列に設定
                vim.cmd('CopilotChat')
            end, { desc = 'Open CopilotChat in right split' })
        end,
    },
}
