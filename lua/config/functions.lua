local M = {}

M.update_tmux_env = function()
  if vim.env.TMUX then
    local vars = { "DISPLAY", "WAYLAND_DISPLAY", "XAUTHORITY", "XDG_RUNTIME_DIR" }
    for _, var in ipairs(vars) do
      local handle = io.popen("tmux show-env -s " .. var .. " 2>/dev/null")
      if handle then
        local result = handle:read("*a")
        handle:close()
        local value = result:match(var .. '="(.-)"') or result:match(var .. '=(.-);')
        if value and value ~= "" then
          vim.env[var] = value
        end
      end
    end
    vim.cmd('runtime autoload/provider/clipboard.vim')
  end
end

return M
