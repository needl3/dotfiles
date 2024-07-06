local keyopts = require("config.utils").keymap.opts

return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({ cmd = "lazygit", hidden = false, direction = "float", dir = "git_dir" })
    function lazygit_toggle()
      lazygit:toggle()
    end

    vim.keymap.set("n", "<leader>g", lazygit_toggle, keyopts("Toggle lazygit"))
  end
}
