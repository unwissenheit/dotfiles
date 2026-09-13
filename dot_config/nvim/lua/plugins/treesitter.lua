return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    require("nvim-treesitter").setup()
    require("nvim-treesitter").install({
      "c_sharp", "lua", "vim", "vimdoc", "json", "xml", "markdown", "bash",
      "go", "gomod", "gowork", "gosum",
      "javascript", "typescript", "tsx", "css", "html",
    })
    -- ハイライト有効化と foldexpr の設定は config/autocmds.lua 側の
    -- FileType autocmd に一本化（ここに重複させない。かつては
    -- "c_sharp"/"bash"/"tsx" 等パーサ名を pattern に誤指定していて
    -- 実際の filetype ("cs"/"sh"/"typescriptreact") と一致せず発火していなかった）
  end,
}

