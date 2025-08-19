local on_attach = function(_, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<c-n>", function()
		vim.diagnostic.jump({ count = 1, float = true })
	end, opts)
	vim.keymap.set("n", "<c-p>", function()
		vim.diagnostic.jump({ count = -1, float = true })
	end, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)

	vim.api.nvim_create_autocmd("BufWritePre", {
		group = vim.api.nvim_create_augroup("LSP-Format-#" .. bufnr, { clear = true }),
		buffer = bufnr,
		callback = vim.lsp.buf.format,
	})
end

local caps = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp = require("lspconfig")

lsp.lua_ls.setup({
	capabilities = caps,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = { globals = { "vim", "hs" } },
			workspace = {
				library = {
					vim.fn.expand("$VIMRUNTIME/lua"),
					vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
				},
			},
		},
	},
})

lsp.gopls.setup({
	name = "gopls",
	cmd = { "gopls", "-remote=auto", "-rpc.trace", "-v" },
	init_options = {
		gofumpt = true,
		staticcheck = true,
		hints = {
			parameterNames = true,
			functionTypeParamets = true,
			assignVariableTypes = true,
		},
	},
	whitelist = { "go" },
	capabilities = caps,
	on_attach = on_attach,
})
