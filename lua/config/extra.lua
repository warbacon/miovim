-- Configure diagnostics
---@type vim.diagnostic.Opts
vim.diagnostic.config({
    severity_sort = true,
    signs = {
        text = util.icons.diagnostics,
    },
})

-- Remove the `How to disable mouse` entry from the PopUp menu
vim.cmd([[
if has("nvim-0.11")
    unmenu PopUp.-2-
else
    unmenu PopUp.-1-
endif
unmenu PopUp.How-to\ disable\ mouse
]])

-- Make clipboard work in WSL
if vim.fn.has("wsl") == 1 then
    vim.g.clipboard = {
        name = "WslClipboard",
        copy = {
            ["+"] = "clip.exe",
            ["*"] = "clip.exe",
        },
        paste = {
            ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        },
        cache_enabled = 0,
    }
end

if vim.g.neovide then
    vim.o.guifont = "JetBrains Mono,Symbols Nerd Font:h18"
    vim.keymap.set({ "n", "v" }, "<C-+>", function()
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1
    end)
    vim.keymap.set({ "n", "v" }, "<C-->", function()
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1
    end)
end
