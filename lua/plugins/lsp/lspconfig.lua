return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local lspconfig = require("lspconfig")
        local mason_lspconfig = require("mason-lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local keymap = vim.keymap

        vim.schedule(function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf, silent = true }

                    -- set keybinds
                    opts.desc = "Show LSP references"
                    keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

                    opts.desc = "Go to declaration"
                    keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

                    opts.desc = "Show LSP definitions"
                    keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

                    opts.desc = "Show LSP implementations"
                    keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

                    opts.desc = "Show LSP type definitions"
                    keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

                    opts.desc = "See available code actions"
                    keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

                    opts.desc = "Smart rename"
                    keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

                    opts.desc = "Show buffer diagnostics"
                    keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

                    opts.desc = "Show line diagnostics"
                    keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

                    opts.desc = "Go to previous diagnostic"
                    keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

                    opts.desc = "Go to next diagnostic"
                    keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

                    opts.desc = "Show documentation for what is under cursor"
                    keymap.set("n", "K", vim.lsp.buf.hover, opts)

                    opts.desc = "Restart LSP"
                    keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

                    opts.desc = "Show workspace diagnostics"
                    keymap.set("n", "<leader>dw", "<cmd>Telescope diagnostics<CR>", opts)
                end,
            })

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

            vim.diagnostic.config({
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = " ",
                        [vim.diagnostic.severity.WARN] = " ",
                        [vim.diagnostic.severity.HINT] = "󰠠 ",
                        [vim.diagnostic.severity.INFO] = " ",
                    },
                },
            })

            local servers = {
                html = { filetypes = { "html", "twig", "hbs" } },
                cssls = {},
                clangd = {
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--clang-tidy",
                        "--header-insertion=iwyu",
                        "--completion-style=detailed",
                        "--function-arg-placeholders",
                        "--fallback-style=llvm",
                        "--offset-encoding=utf-16",
                        "--query-driver=/usr/bin/gcc,/usr/bin/g++",
                    },
                    root_dir = lspconfig.util.root_pattern(
                        "compile_commands.json",
                        "compile_flags.txt",
                        ".git"
                    ),
                },
                pyright = {},
                jdtls = {},
                ts_ls = {},
                eslint = {},
                emmet_ls = {
                    filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
                },
                lua_ls = {
                    settings = {
                        Lua = {
                            completion = { callSnippet = "Replace" },
                        },
                    },
                },
            }

            mason_lspconfig.setup({
                ensure_installed = vim.tbl_keys(servers),
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                        lspconfig[server_name].setup(server)
                    end,
                },
            })
        end)
    end,
}
