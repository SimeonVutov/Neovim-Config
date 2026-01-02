local M = {}

M.update_tmux_env = function()
  if vim.env.TMUX then
    local vars = { "DISPLAY", "WAYLAND_DISPLAY", "XAUTHORITY" }
    for _, var in ipairs(vars) do
      local handle = io.popen("tmux show-env -s " .. var)
      if handle then
        local result = handle:read("*a")
        handle:close()
        local value = result:match(var .. '=(.-);')
        if value then
          vim.env[var] = value
        end
      end
    end
    vim.notify("Tmux environment synced", vim.log.levels.INFO)
  end
end

return M
