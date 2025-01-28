---@diagnostic disable: missing-fields
require("manpack").setup()

Manpack.load("folke/tokyonight.nvim", {
    config = function()
        require("tokyonight").setup()
        vim.cmd.colorscheme("tokyonight-night")
    end
})

Manpack.load("neovim/nvim-lspconfig", {
    event = { "BufNewFile", "BufReadPre" },
    config = function()
        require("lspconfig").lua_ls.setup({})
    end
})

Manpack.load("lewis6991/gitsigns.nvim", {
    config = function()
        require("gitsigns").setup()
    end
})

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

Manpack.load("echasnovski/mini.move", {
    config = function()
        require("mini.move").setup()
    end
})

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

Manpack.load("folke/snacks.nvim", {
    config = function()
        require("snacks").setup({
            quickfile = {},
            bigfile = {},
            input = {},
            picker = {},
            indent = {},
            scope = {}
        })

        vim.keymap.set("n", "<leader>f", Snacks.picker.files)
        vim.keymap.set("n", "<leader>sh", Snacks.picker.help)
    end
})

Manpack.load("echasnovski/mini.icons", {
    config = function()
        require("mini.icons").setup()
    end
})

Manpack.load("rebelot/heirline.nvim", {
    config = function()
        local utils = require("heirline.utils")
        local conditions = require("heirline.conditions")

        local Space = { provider = " " }
        local Align = { provider = "%=" }

        local colors = {
            aqua = utils.get_highlight("DiagnosticHint").fg,
            blue = utils.get_highlight("Function").fg,
            cyan = utils.get_highlight("Special").fg,
            green = utils.get_highlight("String").fg,
            orange = utils.get_highlight("Constant").fg,
            purple = utils.get_highlight("Statement").fg,
            red = utils.get_highlight("DiagnosticError").fg,

            bright_bg = utils.get_highlight("Folded").bg,

            diag_error = utils.get_highlight("DiagnosticError").fg,
            diag_warn = utils.get_highlight("DiagnosticWarn").fg,
            diag_hint = utils.get_highlight("DiagnosticHint").fg,
            diag_info = utils.get_highlight("DiagnosticInfo").fg,
        }

        local ViMode = {
            init = function(self)
                self.mode = vim.fn.mode(1):sub(1, 1)
            end,
            static = {
                mode_colors = {
                    n = "blue",
                    i = "green",
                    v = "purple",
                    V = "purple",
                    ["\22"] = "purple",
                    c = "orange",
                    s = "purple",
                    S = "purple",
                    ["\19"] = "purple",
                    R = "red",
                    ["!"] = "aqua",
                    t = "aqua",
                },
            },
            provider = " ",
            hl = function(self)
                return { bg = self.mode_colors[self.mode] or self.mode_colors.n }
            end,
        }

        local FileNameBlock = {
            init = function(self)
                self.filename = vim.api.nvim_buf_get_name(0)
            end,
            {
                init = function(self)
                    local icon, hl, is_default = MiniIcons.get("file", self.filename)
                    if is_default then
                        icon, hl, is_default = MiniIcons.get("filetype", vim.bo.filetype)
                    end
                    if is_default and vim.bo.buftype ~= "" then
                        icon, hl = MiniIcons.get("file", "init.lua")
                    end
                    self.icon, self.hl = icon, hl
                end,
                provider = function(self)
                    return self.icon and (self.icon .. " ")
                end,
            },
            {
                provider = function(self)
                    if self.filename == "" then
                        if vim.bo.buftype == "" then
                            return "[Sin nombre]"
                        end

                        return vim.bo.filetype
                    end

                    if vim.bo.buftype == "help" then
                        return vim.fn.fnamemodify(self.filename, ":t")
                    end

                    local name = vim.fn.fnamemodify(self.filename, ":.")

                    if not util.is_win then
                        name = name:gsub("oil://", ""):gsub("^" .. vim.env.HOME, "~")
                    else
                        name = name:gsub("oil://", ""):gsub("\\", "/")
                    end

                    if not conditions.width_percent_below(#name, 0.45) then
                        name = vim.fn.pathshorten(name)
                    end

                    return name
                end,
            },
            {
                provider = function()
                    if vim.bo.modified then
                        return " ●"
                    end
                end,
            },
            {
                provider = function()
                    if vim.bo.readonly then
                        return " 󰌾"
                    end
                end,
                hl = { fg = "red" },
            },
            { provider = "%<" },
        }

        local Diagnostics = {
            condition = conditions.has_diagnostics,
            static = {
                error_icon = util.icons.diagnostics.ERROR,
                warn_icon = util.icons.diagnostics.WARN,
                info_icon = util.icons.diagnostics.INFO,
                hint_icon = util.icons.diagnostics.HINT,
            },
            init = function(self)
                self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
                self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
                self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
                self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
            end,
            update = {
                "DiagnosticChanged",
                "BufEnter",
                callback = vim.schedule_wrap(function()
                    vim.api.nvim__redraw({ statusline = true })
                end),
            },
            {
                provider = function(self)
                    return self.errors > 0 and (self.error_icon .. " " .. self.errors .. " ") or ""
                end,
                hl = { fg = "diag_error" },
            },
            {
                provider = function(self)
                    return self.warnings > 0 and (self.warn_icon .. " " .. self.warnings .. " ") or ""
                end,
                hl = { fg = "diag_warn" },
            },
            {
                provider = function(self)
                    return self.info > 0 and (self.info_icon .. " " .. self.info .. " ") or ""
                end,
                hl = { fg = "diag_info" },
            },
            {
                provider = function(self)
                    return self.hints > 0 and (self.hint_icon .. " " .. self.hints .. " ") or ""
                end,
                hl = { fg = "diag_hint" },
            },
        }

        local Ruler = {
            provider = "%-7.(%l:%c%V%)",
        }

        local ScrollBar = {
            static = { sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" } },
            provider = function(self)
                local line = vim.api.nvim_win_get_cursor(0)[1]
                local total_lines = vim.api.nvim_buf_line_count(0)
                local i = math.ceil(line / total_lines * #self.sbar)
                return string.rep(self.sbar[i], 2)
            end,
            hl = { fg = "cyan", bg = "bright_bg" },
        }

        local StatusLine = {
            ViMode,
            Space,
            FileNameBlock,
            Align,
            Diagnostics,
            Space,
            Ruler,
            Space,
            ScrollBar,
            hl = "StatusLine",
        }

        local StatusLineNC = {
            FileNameBlock,
            Align,
            Ruler,
            Space,
            ScrollBar,
            hl = vim.tbl_extend("force", utils.get_highlight("StatusLineNC"), { force = true }),
            condition = conditions.is_not_active,
        }

        require("heirline").setup({
            ---@diagnostic disable-next-line: missing-fields
            statusline = { fallthrough = false, StatusLineNC, StatusLine },
            opts = { colors = colors },
        })

        -- Fix colors when changing colorscheme
        vim.api.nvim_create_augroup("Heirline", { clear = true })
        vim.api.nvim_create_autocmd("ColorScheme", {
            callback = function()
                utils.on_colorscheme(function()
                    return colors
                end)
            end,
            group = "Heirline",
        })
    end
})
