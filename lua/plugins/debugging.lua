return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        "theHamsta/nvim-dap-virtual-text",
    },
    
    -- LAZY LOADING: This file will NOT load on startup.
    -- It loads only when you press a debug key.
    keys = {
        { "<F5>", function() require("dap").continue() end, desc = "Debug: Start/Continue" },
        { "<F10>", function() require("dap").step_over() end, desc = "Debug: Step Over" },
        { "<F11>", function() require("dap").step_into() end, desc = "Debug: Step Into" },
        { "<F12>", function() require("dap").step_out() end, desc = "Debug: Step Out" },
        
        { "<leader>b", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
        { "<leader>B", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Debug: Set Breakpoint" },
        
        -- UI Toggles
        { "<leader>bt", function() require("dapui").toggle() end, desc = "Debug: Toggle UI" },
    },

    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        local mason_dap = require("mason-nvim-dap")

        -- 1. Setup UI & Virtual Text
        dapui.setup()
        require("nvim-dap-virtual-text").setup({})

        -- 2. MASON INTEGRATION (The "Magic" Part)
        -- This tells Mason to install 'codelldb' (for C/C++) and 'python' (debugpy)
        -- 'handlers = {}' tells it to automatically set up the adapters for us.
        mason_dap.setup({
            ensure_installed = { "codelldb" },
            handlers = {}, 
        })

        -- 3. Auto-Open UI Listeners
        dap.listeners.before.attach.dapui_config = function() dapui.open() end
        dap.listeners.before.launch.dapui_config = function() dapui.open() end
        dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
        dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

        -- 4. C / C++ Configuration
        -- Note: We use 'codelldb' as the adapter. It works perfectly with GCC-compiled binaries.
        dap.configurations.cpp = {
            {
                name = "Launch file",
                type = "codelldb", -- matches the adapter name from Mason
                request = "launch",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
            },
        }
        -- Apply the same config to C and Rust
        dap.configurations.c = dap.configurations.cpp
        dap.configurations.rust = dap.configurations.cpp
    end,
}
