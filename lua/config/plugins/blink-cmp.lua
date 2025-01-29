Manpack.load("Saghen/blink.cmp", {
    event = "InsertEnter",
    branch = "v0.11.0",
    config = function()
        require("blink.cmp").setup({
            keymap = {
                ["<C-s>"] = { "hide", "fallback" },
            },
            signature = {
                enabled = true,
            },
            sources = {
                default = { "lazydev", "lsp", "path", "snippets", "buffer" },
                cmdline = {},
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                },
            },
            appearance = {
                nerd_font_variant = "normal",
                kind_icons = util.icons.kinds,
            },
        })
    end,
})

