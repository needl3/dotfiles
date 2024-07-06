local icons = require("config.utils").icons

return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { "<C-p>", "<cmd>:Telescope git_files<cr>",  desc = "Telescope find files" },
    { "<C-f>", "<cmd>:Telescope live_grep<cr>",  desc = "Telescope find files" },
    { "<S-p>", "<cmd>:Telescope find_files<cr>", desc = "Telescope find files" },
  },
  opts = {
    defaults = {
      prompt_prefix = icons.prompt_prefix,
      selection_caret = icons.selection_caret,
    },
    pickers = { find_files = { hidden = true } },
  },
}
