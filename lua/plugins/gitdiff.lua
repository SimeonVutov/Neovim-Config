return {
    {
        "sindrets/diffview.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        cmd = {
            "DiffviewOpen",
            "DiffviewClose",
            "DiffviewFileHistory",
            "DiffviewToggleFiles",
            "DiffviewFocusFiles",
            "DiffviewRefresh",
        },
        config = function()
            local actions = require("diffview.config").actions

            require("diffview").setup({
                enhanced_diff_hl = true,

                view = {
                    default = {
                        layout = "diff2_horizontal",
                        winbar_info = true,
                    },
                    file_history = {
                        layout = "diff2_horizontal",
                        winbar_info = true,
                    },
                    merge_tool = {
                        layout = "diff3_horizontal",
                        winbar_info = true,
                    },
                },

                file_panel = {
                    listing_style = "tree",
                    tree_options = {
                        flatten_dirs = true,
                        folder_statuses = "only_folded",
                    },
                    win_config = {
                        type = "split",
                        position = "left",
                        width = 35,
                    },
                },

                keymaps = {
                    view = {
                        -- Move between changed files.
                        ["]f"] = actions.select_next_entry,
                        ["[f"] = actions.select_prev_entry,

                        -- Diffview panel controls.
                        ["<leader>gt"] = actions.toggle_files,
                        ["<leader>ge"] = actions.focus_files,

                        -- Open Git log for current diff range.
                        ["<leader>gl"] = actions.open_commit_log,

                        -- Open the real local file outside Diffview.
                        ["gf"] = actions.goto_file_edit,

                        -- Close Diffview.
                        ["q"] = actions.close,

                        -- Disabled on purpose:
                        -- You said staging/unstaging should stay terminal-only.
                        ["-"] = false,
                        ["S"] = false,
                        ["U"] = false,
                        ["X"] = false,
                    },

                    file_panel = {
                        ["j"] = actions.next_entry,
                        ["k"] = actions.prev_entry,

                        ["]f"] = actions.select_next_entry,
                        ["[f"] = actions.select_prev_entry,

                        ["<cr>"] = actions.select_entry,
                        ["o"] = actions.select_entry,
                        ["l"] = actions.select_entry,
                        ["h"] = actions.toggle_fold,

                        ["s"] = actions.listing_style,
                        ["R"] = actions.refresh_files,
                        ["L"] = actions.open_commit_log,

                        ["zR"] = actions.open_all_folds,
                        ["zM"] = actions.close_all_folds,

                        ["q"] = actions.close,

                        -- Disabled on purpose.
                        ["-"] = false,
                        ["S"] = false,
                        ["U"] = false,
                        ["X"] = false,
                    },

                    file_history_panel = {
                        ["j"] = actions.next_entry,
                        ["k"] = actions.prev_entry,

                        ["]f"] = actions.select_next_entry,
                        ["[f"] = actions.select_prev_entry,

                        -- Move between commits/versions.
                        ["]c"] = actions.select_next_commit,
                        ["[c"] = actions.select_prev_commit,

                        ["<cr>"] = actions.select_entry,
                        ["o"] = actions.select_entry,

                        -- Open selected history entry in normal Diffview.
                        ["O"] = actions.open_in_diffview,

                        -- Toggle git-log options.
                        ["g!"] = actions.options,

                        -- Copy commit hash.
                        ["y"] = actions.copy_hash,

                        ["L"] = actions.open_commit_log,

                        ["zR"] = actions.open_all_folds,
                        ["zM"] = actions.close_all_folds,

                        ["q"] = actions.close,
                    },
                },
            })
        end,
    },
}
