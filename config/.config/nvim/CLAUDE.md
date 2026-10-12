# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration targeting Neovim 0.11+. It uses [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager and is structured as a modern Lua-based config.

## Repository Structure

```
init.lua                 -- Entry point: loads config.remaps, config.options, config.lazy, config.autocommands
lua/config/
  remaps.lua             -- Global keymaps; leader is `<Space>`. Must load before plugins.
  options.lua            -- Vim options (tabs, clipboard, undo, etc.)
  lazy.lua               -- Bootstrap and configure lazy.nvim; imports `lua/plugins/`
  autocommands.lua       -- Auto-format on save, yank highlight, Go organize imports, LSP attach keymaps
lua/plugins/
  core.lua               -- Colorschemes (kanagawa active), which-key, lualine, indent-blankline, mini.nvim, Comment, toggleterm
  lsp.lua                -- LSP server configurations using Neovim 0.11's `vim.lsp.config` / `vim.lsp.enable` APIs
  autocomplete.lua       -- nvim-cmp + LuaSnip setup
  telescope.lua          -- Telescope + fzf-native + file-browser keymaps
  neotree.lua            -- File explorer on the right (`<leader>e`)
  treesitter.lua         -- Treesitter parsers + textobjects/swap/move keymaps
  git.lua                -- Gitsigns + fugitive + rhubarb
  lazydev.lua            -- Lua development helpers for Neovim config editing
```

## Key Architectural Decisions

### LSP Configuration (Neovim 0.11 Native)

This config uses the new native `vim.lsp.config(name, opts)` and `vim.lsp.enable({...})` APIs instead of `lspconfig` server setups. LSP keymaps are attached via `LspAttach` autocmd in `lua/plugins/lsp.lua` using the `gr*` prefix convention (`grn` rename, `gra` code action, `grr` references, `grd` definition, `grD` declaration, `gri` implementation, `grt` type definition, `gO` document symbols, `gW` workspace symbols). Do not introduce `lspconfig` setup calls.

### Format on Save

`lua/config/autocommands.lua` formats the entire buffer on `BufWritePre` via `vim.lsp.buf.format()`. For Go files, it additionally runs `source.organizeImports` as a code action on save.

### Plugin Loading

All plugins are declared as Lua tables returned from files in `lua/plugins/`. lazy.nvim auto-discovers them via `{ import = "plugins" }`. Each file can return a single plugin table or a list of tables.

## Common Commands

Since this is a Neovim configuration (not a buildable project), there are no traditional build/test commands. Instead, use the following to verify changes:

- **Validate Lua syntax:** `nvim --headless -c 'luafile init.lua' -c 'q'` (run from repo root)
- **Check health:** Inside Neovim, run `:checkhealth lazy` or `:checkhealth lsp`
- **Sync plugins:** Inside Neovim, run `:Lazy sync`
- **Update lockfile:** `:Lazy update` writes to `lazy-lock.json`; commit changes if you want to pin versions
- **Inspect LSP config:** `:lua print(vim.inspect(vim.lsp.config('gopls')))`

## Important Conventions

- **Leader key:** `<Space>` (`vim.g.mapleader`)
- **Tab width:** 4 spaces (`expandtab`, `tabstop=4`, `shiftwidth=4`)
- **Colorscheme:** `kanagawa` is active (others like rose-pine and catppuccin are installed but inactive)
- **Go server:** `gofumpt` is enabled; extensive codelenses and analyses are turned on
- **Python server:** `pylsp` with pycodestyle, pyflakes, pylint, flake8, pydocstyle, mccabe, autopep8, isort, and jedi enabled
- **Rust server:** `rust-analyzer` with `clippy` check, all features, and extensive inlay hints
- **Tree-sitter branch:** Uses `main` branch, not `master`
