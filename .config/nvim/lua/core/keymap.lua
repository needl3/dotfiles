vim.g.mapleader = " "

local set = vim.opt
set.hidden = true
set.encoding = "utf-8"
set.cursorline = true
set.number = true
set.scrolloff = 0
set.mouse = a
set.tabstop = 8
set.softtabstop = 0
set.expandtab = true
set.shiftwidth=4
set.smarttab = true
set.autoread = true



-- Remap the keymaps using nvim set_keymap
local options = {
    noremap = true,
    silent = true
}
local keymap = vim.api.nvim_set_keymap
keymap("n", "<C-h>", ":bprev<CR>", options)
keymap("n", "<C-l>", ":bnext<CR>", options)
keymap("n", "<leader>h", ":nohlsearch<CR>", options)

-- Overriding default vim commands
vim.cmd[[
    command! Wwq :w|bd
    cnoreabbrev wq Wwq
    cnoreabbrev q bd!
]]

