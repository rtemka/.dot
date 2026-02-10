-- Usefull:
-- https://github.com/nvim-lua/kickstart.nvim
-- https://github.com/neovim/nvim-lspconfig
-- NOTE: All remaps must happen before plugins are required (otherwise wrong leader will be used)
require("config.remaps")       -- key remaps

require("config.options")      -- vim options

require("config.lazy")         -- plugins manager

require("config.autocommands") -- some autocommands, such as `:help vim.highlight.on_yank()`
