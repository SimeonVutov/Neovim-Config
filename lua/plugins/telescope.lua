return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
    },
    cmd = "Telescope",
    keys = {
        { "<leader>ff", "<cmd>Telescope find_files<cr>",  desc = "Fuzzy find files" },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>",    desc = "Fuzzy find recent files" },
        { "<C-p>",      "<cmd>Telescope git_files<cr>",   desc = "Find git files" },
        { "<leader>vh", "<cmd>Telescope help_tags<cr>",   desc = "Find help" },
        -- Grep String (find word under cursor)
        { "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Find string under cursor" },
        -- Grep String (find BIG WORD under cursor)
        {
            "<leader>fS",
            function()
                require("telescope.builtin").grep_string({ search = vim.fn.expand("<cWORD>") })
            end,
            desc = "Find WORD under cursor"
        },
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                path_display = { "filename_first" },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                        ["<C-j>"] = actions.move_selection_next,     -- move to next result
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    },
                },
            },
        })

        telescope.load_extension("fzf")
    end,
}
