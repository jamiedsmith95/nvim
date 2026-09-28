-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.api.nvim_set_keymap("n", "<leader>we", "<C-k>", { noremap = false })
vim.api.nvim_set_keymap("n", "<leader>wi", "<C-j>", { noremap = false })
vim.api.nvim_set_keymap("n", "<leader>wo", "<C-l>", { noremap = false })
vim.api.nvim_set_keymap("n", "<leader>wn", "<C-h>", { noremap = false })
vim.api.nvim_set_keymap("i", "<c-h>", "<esc>cb", { noremap = false })
