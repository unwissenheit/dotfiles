-- 編集まわりの補助。括弧の自動補完・囲み文字の操作・診断/参照の一覧表示。
return {
  { "echasnovski/mini.pairs", event = "InsertEnter", opts = {} },
  { "echasnovski/mini.surround", event = "VeryLazy", opts = {} },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "診断一覧" },
      { "<leader>xr", "<cmd>Trouble lsp_references toggle<CR>", desc = "参照一覧" },
    },
    opts = {},
  },
}
