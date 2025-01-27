-- Set the leader key to space and the local leader key to backslash
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Always show the sign column
vim.opt.signcolumn = "yes"

-- Enable line numbers and relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Highlight the line number of the cursor's line
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- Use spaces instead of tabs and set indentation size
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- Customize fill characters
vim.opt.fillchars = {
    foldopen = "",
    foldclose = "",
    fold = " ",
    foldsep = " ",
    diff = "╱",
    eob = " ",
}

-- Folding options
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99

-- Open new splits below and to the right of the current window
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Ignore case in search patterns, but enable smart case
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Show whitespace characters like tabs, trailing spaces, and non-breakable spaces
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "+" }

-- Do not show the intro message on startup
vim.opt.shortmess:append({ I = true })

-- Set global statusline
-- vim.opt.laststatus = 3

-- Enable persistent undo, allowing undo history to be saved between sessions
vim.opt.undofile = true

-- Disable line wrapping
vim.opt.wrap = false

-- Set minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 3
vim.opt.scrolloff = 5

-- Limit the height of the popup menu
vim.opt.pumheight = 10
