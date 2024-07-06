local keymap = vim.keymap.set
local keyopts = require("config.utils").keymap.opts

-- Buffer navigation options
keymap("n", "<C-h>", ":bprev<CR>", keyopts("Previous buffer"))
keymap("n", "<C-l>", ":bnext<CR>", keyopts("Next buffer"))

-- Search highlight reset
keymap("n", "<leader>h", ":nohlsearch<CR>", keyopts("Clear selection"))

-- Diagnostics
keymap("n", "<leader>e", ":lua vim.diagnostic.open_float(0, {scope='line'})<CR>", keyopts("Show diagnostics details"))

-- Code Folding
keymap("n", "-", ":foldclose<CR>", keyopts("Close fold"))

-- Terminal splits and resizing 
keymap("n", "<leader>\\", ":vsp<CR>", keyopts("Split vertical"))
keymap("n", "<leader>-", ":sp<CR>", keyopts("Split horizontal"))
keymap("n", "<C-Left>", ":vertical resize -2<CR>", keyopts("Resize to left"))
keymap("n", "<C-Right>", ":vertical resize +2<CR>", keyopts("Resize to right"))

-- Gitsigns
keymap('n', "gbl", ":Gitsigns blame_line<CR>", keyopts("Blame line"))
keymap('n', "ghp", ":Gitsigns preview_hunk<CR>", keyopts("Preview hunk"))
keymap('n', "gnh", ":Gitsigns next_hunk<CR>", keyopts("Go to next hunk"))
keymap('n', "gph", ":Gitsigns prev_hunk<CR>", keyopts("Go to previous hunk"))
keymap('n', "gdt", ":Gitsigns diffthis<CR>", keyopts("Show diff"))
keymap('n', "gsh", ":Gitsigns stage_hunk<CR>", keyopts("Stage hunk"))
keymap('n', "grh", ":Gitsigns reset_hunk<CR>", keyopts("Reset hunk"))
keymap('n', "grb", ":Gitsigns reset_buffer<CR>", keyopts("Hard reset buffer"))
keymap('n', "guh", ":Gitsigns undo_stage_hunk<CR>", keyopts("Undo stage hunk"))
keymap('n', "gsb", ":Gitsigns stage_buffer<CR>", keyopts("Stage whole buffer"))
