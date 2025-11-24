return {
    'williamboman/mason.nvim',
    dependencies = {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    cmd = "Mason",
    -- keys = { { "<leader>m", "<cmd>Mason<cr>", desc = "Mason" } },
    config = function()
        local mason = require('mason')
        local mason_tool_installer = require('mason-tool-installer')

        mason.setup({
            ui = {
                icons = {
                    package_installed = '✓',
                    package_pending = '➜',
                    package_uninstalled = '✗',
                },
            },
        })
        
        vim.defer_fn(function()
            mason_tool_installer.setup({
                ensure_installed = {
                    "stylua",
                    "eslint_d",
                },
            })
        end, 5000)
    end,
}
