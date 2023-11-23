-- NOTE: All remaps must happen before plugins are required (otherwise wrong leader will be used)
require("config.remaps") -- key remaps

require("config.options") -- vim options

require("config.lazy") -- plugins manager
require("lazy").setup("plugins") -- get plugins from ./lua/plugins/

require("config.autocommands") -- some autocommands, such as `:help vim.highlight.on_yank()`
