return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "ファイル検索" },
    { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "全文検索" },
    { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "バッファ" },
    { "<leader>fs", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "シンボル検索" },
  },
  opts = {
    defaults = {
      file_ignore_patterns = { "bin/", "obj/", "%.dll", "%.pdb" },
    },
  },
  config = function(_, opts)
    require("telescope").setup(opts)
    pcall(require("telescope").load_extension, "fzf")
  end,
}
