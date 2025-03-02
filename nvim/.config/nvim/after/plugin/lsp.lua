require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
	}
})

local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' }
			}
		}
	}
})

vim.keymap.set('n', 'K', vim.lsp.buf.hover)
