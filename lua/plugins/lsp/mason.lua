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

        mason_tool_installer.setup({
            ensure_installed = {
                "stylua",    -- lua formatter
                "eslint_d",  -- js linter
                "prettier",  -- js/html/css formatter
                "isort",     -- python import sorter
                "flake8",    -- python linter
            },
        })
    end,
}
