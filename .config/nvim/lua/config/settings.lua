-- Overriding default vim commands
vim.cmd [[
command! Wwq :w|bd
cnoreabbrev wq Wwq
cnoreabbrev q bd!
set clipboard+=unnamedplus
highlight Folded guibg=black guifg=blue
]]
