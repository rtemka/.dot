-- [[ Setting options ]]
-- See `:help vim.o`
local opt = vim.opt -- lua interface for vim options; See: `:help vim.opt`

opt.guicursor = "" -- cursor not change at all in modes

opt.hlsearch = false -- highlight all matches for the last used search pattern
opt.incsearch = true -- show match for partly typed search command
opt.ignorecase = true -- ignore case when using a search pattern
opt.smartcase = true -- override 'ignorecase' when pattern has upper case characters

opt.number = true -- print the line number in front of each line
opt.relativenumber = true -- show relative line number in front of each line
opt.cursorline = true -- highlight the screen line of the cursor

opt.mouse = 'a' -- enable mouse in all modes.

opt.wrap = false -- disable/enable long lines wrap
opt.breakindent = true -- wrapped lines repeats indent.
opt.autoindent = true -- automatically set the indent of a new line
opt.smartindent = true -- do clever autoindenting
opt.tabstop = 4 -- number of spaces a <Tab> in the text stands for
opt.softtabstop = 4 -- number of spaces that <Tab> uses while editing 
opt.shiftwidth = 4 -- number of spaces used for each step of (auto)indent
opt.expandtab = true -- expand <Tab> to spaces in Insert mode

--  See `:help 'clipboard'`
opt.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim. 

opt.updatetime = 250 -- update time
opt.timeoutlen = 700 -- time to wait for a mapped sequence to complete (in milliseconds) default is 1000 

opt.swapfile = false
opt.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true -- save undo history

opt.signcolumn = 'yes' -- keep signcolumn on by default

opt.completeopt = { "menuone", "menu", "noselect", "preview" } -- set completeopt to have a better completion experience

vim.o.termguicolors = true -- make sure your terminal supports this
