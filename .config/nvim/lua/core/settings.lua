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
set.shiftwidth = 2
set.smarttab = true
set.autoread = true
set.startofline = true
set.endofline = true

-- Overriding default vim commands
vim.cmd [[
    command! Wwq :w|bd
    cnoreabbrev wq Wwq
    cnoreabbrev q bd!
    set clipboard+=unnamedplus
]]
