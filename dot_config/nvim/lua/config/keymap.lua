vim.keymap.set("i", "jj", "<esc>")
vim.keymap.set("t", "jj", "<c-\\><c-n>")
vim.keymap.set("n", "<leader><space>", "<cmd>noh<cr>")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "fzb", builtin.buffers)
vim.keymap.set("n", "fzf", builtin.find_files)
vim.keymap.set("n", "fzrg", builtin.live_grep)

vim.keymap.set("n", "<leader>bp", ":BufferLinePick<cr>")
vim.keymap.set("n", "<leader>bd", ":BufferLinePickClose<cr>")
vim.keymap.set("n", "<leader>G", ":G<cr>")
