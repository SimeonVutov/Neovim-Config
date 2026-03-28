return {
    "scalameta/nvim-metals",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    ft = { "scala", "sbt" },
    config = function()
        local metals_config = require("metals").bare_config()

        -- 1. Setup nvim-cmp capabilities for Metals
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

        -- 2. Metals settings & UI integration (optimized for noice.nvim)
        metals_config.init_options.statusBarProvider = "off"
        metals_config.settings = {
            showImplicitArguments = true,
            showInferredType = true,
            excludedPackages = { "akka.actor.typed.javadsl" },
        }

        -- 3. Metals-specific keymaps
        -- Note: Your standard LSP keys (gd, K, etc.) from lspconfig.lua
        -- will still attach automatically via your UserLspConfig autocmd!
        metals_config.on_attach = function(client, bufnr)
            local map = vim.keymap.set
            local opts = { buffer = bufnr, silent = true }

            opts.desc = "Metals Commands (Menu)"
            map("n", "<leader>mc", function() require("metals").commands() end, opts)

            opts.desc = "Metals Import Build"
            map("n", "<leader>mi", function() require("metals").import_build() end, opts)
        end

        -- 4. Autocmd to initialize Metals only on Scala/SBT files
        local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "scala", "sbt" },
            callback = function()
                require("metals").initialize_or_attach(metals_config)
            end,
            group = nvim_metals_group,
        })
    end
}
