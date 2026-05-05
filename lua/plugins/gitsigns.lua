return {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
        signs = {
            add          = { text = "▎" },
            change       = { text = "▎" },
            delete       = { text = "▸" },
            topdelete    = { text = "▸" },
            changedelete = { text = "▎" },
            untracked    = { text = "▎" },
        },
        signs_staged = {
            add          = { text = "▎" },
            change       = { text = "▎" },
            delete       = { text = "▸" },
            topdelete    = { text = "▸" },
            changedelete = { text = "▎" },
        },
        signs_staged_enable = true,
        current_line_blame = false, -- toggle with <leader>gb
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol",
            delay = 600,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> · <summary>",
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, desc)
                vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
            end

            -- Hunk navigation (overrides diffview's [c/]c in normal buffers)
            map("n", "]h", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "]c", bang = true })
                else
                    gs.nav_hunk("next")
                end
            end, "Git: next hunk")

            map("n", "[h", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "[c", bang = true })
                else
                    gs.nav_hunk("prev")
                end
            end, "Git: prev hunk")

            -- Preview hunk inline (floating popup)
            map("n", "<leader>hp", gs.preview_hunk, "Git: preview hunk")

            -- Inline blame toggle
            map("n", "<leader>gb", gs.toggle_current_line_blame, "Git: toggle inline blame")

            -- Diff current file against index
            map("n", "<leader>hd", gs.diffthis, "Git: diff this file")

            -- Text object: ih = inner hunk (works with c/d/y)
            map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Git: select hunk")
        end,
    },
}
