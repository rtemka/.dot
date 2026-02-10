-- For more config options see:
-- https://github.com/nvim-neo-tree/neo-tree.nvim?tab=readme-ov-file#configuration
vim.keymap.set("n", "<leader>e", "<Cmd>Neotree<CR>", { desc = "Open File [E]xplorer" })
require('neo-tree').setup({
    close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
    popup_border_style = "",     -- or "" to use 'winborder' on Neovim v0.11+
    enable_git_status = true,
    enable_diagnostics = true,
    filesystem = {
        follow_current_file = {
            enabled = true -- This will find and focus the file in the active buffer every time the current file is changed while the tree is open.
        }
    },
    window = {
        position = "right", -- Where to open NeoTree window.
        width = 46
    }
})
