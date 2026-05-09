return {
    "folke/todo-comments.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
    opts = {
        signs = true,
    },
    keys = {
        {
            "]t",
            function()
                require("todo-comments").jump_next()
            end,
            desc = "Todo: next",
        },
        {
            "[t",
            function()
                require("todo-comments").jump_prev()
            end,
            desc = "Todo: previous",
        },
        {
            "<leader>xt",
            "<cmd>Trouble todo<CR>",
            desc = "Trouble: todos",
        },
        {
            "<leader>xT",
            "<cmd>TodoTelescope<CR>",
            desc = "Telescope: todos",
        },
        {
            "<leader>xF",
            "<cmd>TodoTelescope keywords=TODO,FIX,FIXME,BUG<CR>",
            desc = "Telescope: TODO/FIX/BUG",
        },
    },
}
