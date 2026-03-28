local fn = require("config.functions")

-- Run automatically on each start of nvim, so it fixes the DISPLAY var problem
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("TmuxEnvSync", { clear = true }),
    callback = function()
        fn.update_tmux_env()
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "scala", "sbt" },
    callback = function()
        vim.opt_local.shiftwidth = 4
        vim.opt_local.tabstop = 4
        vim.opt_local.softtabstop = 4
        vim.opt_local.expandtab = true
    end,
})
