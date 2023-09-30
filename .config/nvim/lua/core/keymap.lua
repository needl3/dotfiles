-- Remap the keymaps using nvim set_keymap
local options = {
    noremap = true,
    silent = true
}

local keymap = vim.api.nvim_set_keymap

keymap("n", "<C-h>", ":bprev<CR>", options)
keymap("n", "<C-l>", ":bnext<CR>", options)
keymap("n", "<leader>h", ":nohlsearch<CR>", options)
keymap("n", "<leader>e", ":lua vim.diagnostic.open_float(0, {scope='line'})<CR>", options)
