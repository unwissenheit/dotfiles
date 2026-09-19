-- Go / React (TS) 専用。C# は easy-dotnet.nvim が Roslyn を独自管理しているため
-- ここでは一切触らない（ensure_installed に csharp-ls / omnisharp を入れない）。
return {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = { "gopls", "ts_ls" },
      -- 自動 enable はオフ。C# 側の LSP 構成に予期せず干渉しないよう、
      -- 有効化は lsp.lua で gopls / ts_ls だけ明示的に行う。
      automatic_enable = false,
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      -- csharpier は dotnet tool で手動管理のまま。ここは Go/React 用のみ。
      ensure_installed = { "gofumpt", "goimports", "prettierd" },
    },
  },
}
