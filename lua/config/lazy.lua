-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Add support for the LazyFile event
local Event = require("lazy.core.handler.event")
Event.mappings.LazyFile = { id = "LazyFile", event = { "BufReadPost", "BufNewFile" } }
Event.mappings["User LazyFile"] = Event.mappings.LazyFile

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    defaults = {
        cond = vim.env.TERM ~= "linux",
    },
    install = {
        colorscheme = { "tokynight-night" },
    },
    ---@diagnostic disable-next-line: assign-type-mismatch
    dev = {
        path = util.is_win and "F:\\" or "~/Git",
        patterns = { "warbacon" },
        fallback = true,
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "rplugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})

-- Set keymap
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>")
