-------------------- Require configs ----------------------------------
require("config.lazy")
require("config.keybinds")
require("config.settings")
-------------------- Set default colorscheme --------------------------
local default_colorscheme = require("config.utils").colorscheme.default
vim.cmd.colorscheme(default_colorscheme)
vim.fn.setenv("PATH", os.getenv("PATH") .. ":" .. vim.fn.expand("$HOME/go/bin"))
