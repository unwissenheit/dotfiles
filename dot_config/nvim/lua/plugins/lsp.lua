-- Go / React (TS) 用の LSP。C# (Roslyn) は easy-dotnet.nvim が独自に
-- 起動・管理しているため、ここでは gopls / ts_ls 以外は一切 enable しない。
return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = { "mason-org/mason-lspconfig.nvim", "saghen/blink.cmp" },
  config = function()
    -- blink.cmp 側の追加capabilities（スニペット補完など）をLSPに伝える
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    vim.lsp.config("gopls", {
      capabilities = capabilities,
      settings = {
        gopls = { gofumpt = true, staticcheck = true },
      },
    })
    vim.lsp.config("ts_ls", { capabilities = capabilities })

    vim.lsp.enable({ "gopls", "ts_ls" })
  end,
}
