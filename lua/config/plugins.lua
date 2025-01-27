require("manpack").setup()

Manpack.plug("neovim/nvim-lspconfig")
require("lspconfig").lua_ls.setup({})

Manpack.plug("nvim-treesitter/nvim-treesitter")

require("nvim-treesitter.install").prefer_git = false
require("nvim-treesitter.configs").setup({
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = {
        "astro",
        "bash",
        "c",
        "cpp",
        "css",
        "diff",
        "dockerfile",
        "fish",
        "git_config",
        "gitcommit",
        "html",
        "hyprlang",
        "ini",
        "java",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "powershell",
        "printf",
        "python",
        "rasi",
        "regex",
        "svelte",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
    },
})

Manpack.plug("folke/lazydev.nvim")

require("lazydev").setup({
    library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
})
