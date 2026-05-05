vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

local git_diff = require("config.git_diff")

git_diff.setup_commands()

-- Diffview / MR review
vim.keymap.set("n", "<leader>gv", git_diff.toggle_diffview, {
    desc = "Git diff: toggle Diffview",
})

vim.keymap.set("n", "<leader>gm", git_diff.review_mr_select_target, {
    desc = "Git diff: review MR against target",
})

vim.keymap.set("n", "<leader>gM", git_diff.review_mr_select_target_and_source, {
    desc = "Git diff: review MR target vs source",
})

vim.keymap.set("n", "<leader>gc", git_diff.review_mr_commits_select, {
    desc = "Git diff: review MR commit by commit",
})

vim.keymap.set("n", "<leader>gw", git_diff.open_working_tree, {
    desc = "Git diff: unstaged changes",
})

vim.keymap.set("n", "<leader>gW", git_diff.open_all_local_changes, {
    desc = "Git diff: all local changes vs HEAD",
})

vim.keymap.set("n", "<leader>gs", git_diff.open_staged_changes, {
    desc = "Git diff: staged changes",
})

vim.keymap.set("n", "<leader>gf", git_diff.open_current_file_history, {
    desc = "Git diff: current file history",
})

vim.keymap.set("n", "<leader>gF", git_diff.open_repo_history, {
    desc = "Git diff: repo history",
})

vim.keymap.set("n", "<leader>gx", git_diff.open_stash_history, {
    desc = "Git diff: stash history",
})

vim.keymap.set("n", "<leader>gt", "<cmd>DiffviewToggleFiles<CR>", {
    desc = "Git diff: toggle files panel",
})

vim.keymap.set("n", "<leader>ge", "<cmd>DiffviewFocusFiles<CR>", {
    desc = "Git diff: focus files panel",
})

vim.keymap.set("n", "<leader>gr", "<cmd>DiffviewRefresh<CR>", {
    desc = "Git diff: refresh",
})

vim.keymap.set("n", "<leader>gq", "<cmd>DiffviewClose<CR>", {
    desc = "Git diff: close",
})
