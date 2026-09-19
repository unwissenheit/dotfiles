return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {},
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.add({
      { "<leader>d", group = "dotnet" },
      { "<leader>f", group = "find" },
      { "<leader>g", group = "git" },
      { "<leader>x", group = "trouble" },
    })
  end,
}
