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

-- タブバー
config.hide_tab_bar_if_only_one_tab = true

-- カーソル
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500

-- パフォーマンス
config.front_end = "WebGpu"
config.max_fps = 120

-- スクロールバック
config.scrollback_lines = 10000

-- ベル
config.audible_bell = "Disabled"

-- IME
config.use_ime = true

-- シェル (Windows の場合のみ PowerShell を使用)
if wezterm.target_triple:find("windows") then
  config.default_prog = { "pwsh.exe", "-NoLogo" }
end

-- リーダーキー (tmux的なペイン操作)
-- mac は Cmd+a (Ctrl+a はシェルの行頭移動と衝突するため)、それ以外は Ctrl+a
local leader_mods = wezterm.target_triple:find("apple") and "SUPER" or "CTRL"
config.leader = { key = "a", mods = leader_mods, timeout_milliseconds = 1000 }
config.keys = {
  { key = "|", mods = "LEADER|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "-", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") },
  { key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },
  { key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") },
  -- コピーモード (tmux 風: Leader + [)
  { key = "[", mods = "LEADER", action = wezterm.action.ActivateCopyMode },
}

require("appearance").apply_to_config(config)

return config

