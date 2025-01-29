Manpack.load("williamboman/mason-lspconfig.nvim")

Manpack.load("williamboman/mason.nvim", {
    config = function()
        require("mason").setup({
            ui = {
                icons = {
                    package_pending = " ",
                    package_installed = " ",
                    package_uninstalled = " ",
                },
                height = 0.8,
            },
        })
        require("mason-lspconfig").setup()

        local ensure_installed = vim.list_extend({
            "clang-format",
            "prettierd",
            "ruff",
            "shellcheck",
            "shfmt",
            "stylua",
        }, vim.tbl_keys(require("config.lsp-servers")))

        local registry = require("mason-registry")

        registry:on("package:install:success", function()
            vim.defer_fn(function()
                vim.api.nvim_exec_autocmds("FileType", { buffer =vim.api.nvim_get_current_buf() })
            end, 100)
        end)

        registry.refresh(function()
            local mappings = require("mason-lspconfig").get_mappings().lspconfig_to_mason
            for _, package_name in ipairs(ensure_installed) do
                package_name = mappings[package_name] or package_name
                if not registry.is_installed(package_name) then
                    local package = registry.get_package(package_name)
                    package:install()
                end
            end
        end)
    end
})
