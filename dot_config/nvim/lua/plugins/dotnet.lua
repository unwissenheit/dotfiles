return {
  "GustavEikaas/easy-dotnet.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  ft = { "cs", "fsharp", "razor" },
  cmd = "Dotnet",
  keys = {
    { "<leader>dr", "<cmd>Dotnet run<CR>", desc = "dotnet run" },
    { "<leader>db", "<cmd>Dotnet build<CR>", desc = "dotnet build" },
    { "<leader>dt", "<cmd>Dotnet testrunner<CR>", desc = "test runner" },
    { "<leader>ds", "<cmd>Dotnet secrets<CR>", desc = "user secrets" },
  },
  opts = {
    lsp = { enabled = true },
    test_runner = {
      viewmode = "float",
      enable_buffer_test_execution = true,
    },
    auto_bootstrap_namespace = {
      type = "file_scoped",
      enabled = true,
    },
  },
}
