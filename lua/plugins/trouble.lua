return {
    "folke/trouble.nvim",
    enabled = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    keys = {
        {
            "<leader>xx",
            "<cmd>Trouble diagnostics toggle<CR>",
            desc = "Trouble: workspace diagnostics",
        },
        {
            "<leader>xX",
            "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
            desc = "Trouble: buffer diagnostics",
        },
        {
            "<leader>xq",
            "<cmd>Trouble qflist toggle<CR>",
            desc = "Trouble: quickfix list",
        },
        {
            "<leader>xl",
            "<cmd>Trouble loclist toggle<CR>",
            desc = "Trouble: location list",
        },
        {
            "<leader>cs",
            "<cmd>Trouble symbols toggle focus=false<CR>",
            desc = "Trouble: document symbols",
        },
        {
            "<leader>cl",
            "<cmd>Trouble lsp toggle focus=false win.position=right<CR>",
            desc = "Trouble: LSP definitions/references",
        },
    },
    opts = {
        focus = true,
    },
}
