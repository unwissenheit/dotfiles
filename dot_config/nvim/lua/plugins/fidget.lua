-- Roslyn の初回読み込みが遅い（README参照）ので、LSP の進行状況を
-- 画面右下にポップアップ表示して「今読み込み中」を可視化する。
return {
  "j-hui/fidget.nvim",
  event = "VeryLazy",
  opts = {},
}
