-- Copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>Y", '"+y$')

-- Set up keymaps for LSP features when an LSP client is attached to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp_actions", { clear = true }),
    callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, opts)
        if vim.fn.has("nvim-0.11") == 0 then
            vim.keymap.set("n", "gra", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "grr", vim.lsp.buf.references, opts)
            vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, opts)
        end
    end,
})

-- Disable the `q:` command-line window
vim.keymap.set("n", "q:", "<cmd>echoe 'q:'<CR>", { noremap = true })

-- Debugging
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")
