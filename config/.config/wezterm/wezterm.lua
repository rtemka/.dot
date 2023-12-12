-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
--config.color_scheme = 'Gruvbox dark, hard (base16)'
--config.color_scheme = 'Catppuccin Mocha (Gogh)'
-- config.color_scheme = 'Glacier'
config.color_scheme = 'Kanagawa (Gogh)'
-- Font settings
config.font = wezterm.font_with_fallback {
  'CaskaydiaCove Nerd Font Mono',
  'Hurmit Nerd Font Mono',
}
config.font_size = 10.5
config.initial_cols = 160
config.initial_rows = 40

-- and finally, return the configuration to wezterm
return config
