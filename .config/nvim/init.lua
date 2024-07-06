-------------------- Require configs ----------------------------------
require("config.keybinds")
require("config.settings")
require("config.lazy")
-------------------- Set default colorscheme --------------------------
local default_colorscheme = require("config.utils").colorscheme.default
vim.cmd.colorscheme(default_colorscheme)
