Manpack.load("folke/tokyonight.nvim", {
    config = function()
        require("tokyonight").setup()
        vim.cmd.colorscheme("tokyonight-night")
    end
})

