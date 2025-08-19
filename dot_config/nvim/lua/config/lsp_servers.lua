local settings = function(tbl)
	return function(capabilities, on_attach)
		tbl["capabilities"] = capabilities
		tbl["on_attach"] = on_attach

		return tbl
	end
end

return {
	lua_ls = settings({
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
	}),
	gopls = settings({
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
	}),
	rust_analyzer = settings({
		name = "rust_analyzer",
		settings = {
			rust_analyzer = {
				assist = {
					importGranularity = "module",
					importPrefix = "self",
					formatOnSave = true,
				},
				cargo = {
					loadOutDirsFromCheck = true,
				},
				procMacro = { enable = true },
			},
		},
		whitelist = { "rust" },
	}),
	pyright = settings({
		name = "pyright",
		cmd = { "pyright-langserver", "--stdio" },
		whitelist = { "python" },
	}),
}
