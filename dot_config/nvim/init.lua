vim.g.mapleader = " "        -- lazy より前に設定すること
vim.g.maplocalleader = "\\"

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
