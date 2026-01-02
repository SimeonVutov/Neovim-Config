local fn = require("config.functions")

-- Run automatically on each start of nvim, so it fixes the DISPLAY var problem
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("TmuxEnvSync", { clear = true }),
    callback = function()
        fn.update_tmux_env()
    end,
})
