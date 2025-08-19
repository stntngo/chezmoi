return {
	"EdenEast/nightfox.nvim",
	{
		"echasnovski/mini.nvim",
		version = "*",
	},
	{
		"akinsho/bufferline.nvim",
		opts = {
			options = {
				color_icons = true,
				tab_size = 24,
				show_close_icon = false,
				enforce_regular_tabs = false,
				show_buffer_icons = false,
				show_buffer_close_icons = false,
				diagnostics = "nvim_lsp",
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "EdenEast/nightfox.nvim" },
		opts = function(_, _)
			return require("config.lualine")
		end,
	},
	"tpope/vim-fugitive",
	"mbbill/undotree",
	"nvim-lua/popup.nvim",
	"nvim-lua/plenary.nvim",
	{
		"nvim-telescope/telescope.nvim",
		opts = {
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sort = true,
					case_mode = "smart_case"
				},
			},
		},
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	"folke/todo-comments.nvim",
	"neovim/nvim-lspconfig",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",
	{
		"mason-org/mason.nvim",
		opts = {}
	},
	{
	    "mason-org/mason-lspconfig.nvim",
	    opts = {
		ensure_installed = { "lua_ls", "gopls" },
		automatic_enable = false,
	    },
	    dependencies = {
		"mason-org/mason.nvim",
		"neovim/nvim-lspconfig",
	    },
	},
}
