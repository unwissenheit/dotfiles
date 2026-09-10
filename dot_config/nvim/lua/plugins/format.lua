return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  opts = {
    formatters_by_ft = {
      cs = { "csharpier" },
      go = { "gofumpt", "goimports" },
      javascript = { "prettierd" },
      javascriptreact = { "prettierd" },
      typescript = { "prettierd" },
      typescriptreact = { "prettierd" },
    },
    format_on_save = { timeout_ms = 3000, lsp_format = "fallback" },
  },
}
