vim.o.mousehide = true
vim.o.number = true
vim.o.showmatch = true
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.relativenumber = false
vim.o.signcolumn = "yes"

vim.cmd("colorscheme nordfox")
require("telescope").load_extension("fzf")
