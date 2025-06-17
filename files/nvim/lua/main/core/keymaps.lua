vim.g.mapleader = " " -- space as leader key

local keymap = vim.keymap

keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jk" })
