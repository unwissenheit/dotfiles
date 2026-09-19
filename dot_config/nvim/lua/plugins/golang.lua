-- Go のデバッグアダプタ(delve)だけを既存の nvim-dap に足す。
-- LSP は lsp.lua、フォーマッタは mason.lua + format.lua 側で管理。
return {
  "leoluz/nvim-dap-go",
  ft = "go",
  config = function()
    require("dap-go").setup()
  end,
}
