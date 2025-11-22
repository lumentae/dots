require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls" }
vim.lsp.enable(servers)
vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
-- read :h vim.lsp.config for changing options of lsp servers 
