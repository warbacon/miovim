Manpack.load("nvim-treesitter/nvim-treesitter", {
    config = function()
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
    end
})
