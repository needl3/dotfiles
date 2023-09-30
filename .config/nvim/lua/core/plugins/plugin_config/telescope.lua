local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<C-f>', builtin.live_grep, {})
vim.keymap.set('n', '<S-p>', builtin.find_files, {})
