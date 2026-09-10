local wezterm = require("wezterm")

-- ここに設定内容を記述していく
local config = wezterm.config_builder()

-- 設定ファイルの変更を自動で読み込む
config.automatically_reload_config = true

-- font
config.font_size = 13.5
config.font = wezterm.font("HackGen Console NF")

-- 背景の透過度とぼかし
config.window_background_opacity = 0.9 -- 非フォーカス時のデフォルト（blur見える）
config.macos_window_background_blur = 8 -- opacityで視覚的に制御

require("appearance").apply_to_config(config)

return config

