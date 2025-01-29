Manpack.load("folke/snacks.nvim", {
    config = function()
        require("snacks").setup({
            quickfile = {},
            bigfile = {},
            input = {},
            picker = {
                win = {
                    input = {
                        keys = {
                            ["<Esc>"] = { "close", mode = { "n", "i" } },
                        },
                    },
                    preview = {
                        wo = {
                            signcolumn = "no",
                        },
                    },
                },
                layout = function()
                    return {
                        preview = vim.o.columns >= 120 and true or false,
                        layout = require("snacks.picker.config.layouts").default.layout
                    }
                end,
                formatters = {
                    file = {
                        filename_first = true,
                    },
                },
                sources = {
                    files = {
                        hidden = true,
                        exclude = {
                            "*.class",
                            "*.o",
                            ".git/",
                            "node_modules/",
                        },
                    },
                },
                icons = {
                    diagnostics = {
                        Error = util.icons.diagnostics.ERROR,
                        Warn = util.icons.diagnostics.WARN,
                        Hint = util.icons.diagnostics.HINT,
                        Info = util.icons.diagnostics.INFO,
                    },
                    kinds = util.icons.kinds,
                },
            },
        })

        vim.keymap.set("n", "<leader>f", Snacks.picker.files)
        vim.keymap.set("n", "<leader>sh", Snacks.picker.help)
    end
})
