Manpack.load("neovim/nvim-lspconfig", {
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        local servers = vim.deepcopy(require("config.lsp-servers"), true)

        for server, opts in pairs(servers) do
            if not opts.manual_setup then
                opts.capabilities = require("blink-cmp").get_lsp_capabilities(opts.capabilities)
                vim.api.nvim_create_autocmd("FileType", {
                    once = true,
                    group = vim.api.nvim_create_augroup(server .. "-setup", { clear = true }),
                    pattern = opts.filetypes or require("lspconfig.configs." .. server).default_config.filetypes,
                    callback = function(ev)
                        require("lspconfig")[server].setup(opts)
                        vim.defer_fn(function()
                            vim.api.nvim_exec_autocmds("FileType", { buffer = ev.buf })
                        end, 0)
                    end
                })
            end
        end
    end,
})

Manpack.load("folke/lazydev.nvim", {
    filetype = "lua",
    config = function()
        require("lazydev").setup({
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        })
    end
})

return M
