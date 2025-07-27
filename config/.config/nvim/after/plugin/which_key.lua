-- document existing key chains
local wk = require("which-key")
wk.add({
    { "<leader>f", group = "[F]ile Browser relative to opened buffer" },
    { "<leader>F", group = "[F]ile Browser relative to directory" },
    { "<leader>c", group = "[C]ode" },
    -- { "<leader>c_", hidden = true },
    { "<leader>d", group = "[D]ocument" },
    -- { "<leader>d_", hidden = true },
    { "<leader>g", group = "[G]it" },
    -- { "<leader>g_", hidden = true },
    { "<leader>h", group = "More git" },
    -- { "<leader>h_", hidden = true },
    { "<leader>r", group = "[R]ename" },
    -- { "<leader>r_", hidden = true },
    { "<leader>s", group = "[S]earch" },
    -- { "<leader>s_", hidden = true },
    { "<leader>w", group = "[W]orkspace" },
    -- { "<leader>w_", hidden = true },
    {
        "<leader>b",
        group = "buffers",
        expand = function()
            return require("which-key.extras").expand.buf()
        end
    },
})
