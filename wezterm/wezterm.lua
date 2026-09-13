local wezterm = require("wezterm")

local keybindings = require("keybindings")
local scripts = require("scripts")
local favorite_paths = require("favorite_paths")
local background = require("background")
local color_theme = require("color_theme")

local config = wezterm.config_builder()

-- Window
config.initial_cols = 120
config.initial_rows = 34
--config.window_decorations = "RESIZE"
config.default_prog = { "nu", "--experimental-options", "native-clip" }
config.window_padding = { left = 8, right = 8, top = 8, bottom = 8 }
config.window_close_confirmation = "NeverPrompt"

-- Text
config.font_size = 10
config.font = wezterm.font({ family = "JetBrains Mono", weight = "DemiBold" })
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" } -- Disables liagures.
--config.color_scheme = 'Campbell (Gogh)'
--config.color_scheme = 'Monokai Remastered'
config.line_height = 1.05

-- Cursor
config.default_cursor_style = "BlinkingUnderline"
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- Theme
config.colors = color_theme.load()

-- Tabs
config.inactive_pane_hsb = {
	saturation = 0.8,
	brightness = 0.4,
}

-- Background
config.background = background.load()

-- Keybindings
config.keys = keybindings.build_keys(scripts.show_picker, favorite_paths.show_picker)
config.key_tables = keybindings.build_key_tables()

return config
