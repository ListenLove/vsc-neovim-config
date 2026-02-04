local wezterm = require 'wezterm'

local config = {}

-- 颜色方案
config.color_scheme = 'Tokyo Night'

-- 字体设置
config.font = wezterm.font('JetBrains Mono')
config.font_size = 13.0

-- 窗口外观
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_background_opacity = 0.9
config.window_padding = {
  left = 5,
  right = 5,
  top = 5,
  bottom = 5,
}

-- 标签栏设置
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false

-- 光标设置
config.cursor_blink_rate = 800
config.cursor_thickness = '2pt'

-- 滚动和窗口大小
config.scrollback_lines = 10000
config.initial_cols = 120
config.initial_rows = 30

-- 快捷键
config.keys = {
  { key = 'F11', mods = 'NONE',       action = wezterm.action.ToggleFullScreen },
  -- 标签页切换：Ctrl+Shift+, 向左切换，Ctrl+Shift+. 向右切换
  { key = ',',   mods = 'CTRL',       action = wezterm.action.ActivateTabRelative(1) },
  { key = '<',   mods = 'CTRL|SHIFT', action = wezterm.action.ActivateTabRelative(-1) },
}

-- 默认 WSL 启动
config.default_prog = { 'C:\\Windows\\system32\\wsl.exe' }

return config
