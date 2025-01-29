---@diagnostic disable: missing-fields
require("manpack").setup()

require("config.plugins.tokyonight")
require("config.plugins.snacks")
require("config.plugins.treesitter")
require("config.plugins.blink-cmp")
require("config.plugins.lsp")
require("config.plugins.mason")
require("config.plugins.mini")
require("config.plugins.heirline")

Manpack.load("tpope/vim-sleuth")

Manpack.load("j-hui/fidget.nvim", {
    event = "LspAttach",
    config = function()
        require("fidget").setup({})
    end
})

Manpack.load("lewis6991/gitsigns.nvim", {
    config = function()
        require("gitsigns").setup()
    end
})


Manpack.load("iamcco/markdown-preview.nvim", {
    build = function()
        vim.fn["mkdp#util#install"]()
    end
})
