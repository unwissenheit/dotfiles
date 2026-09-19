return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    on_attach = function(bufnr)
      local gs = require("gitsigns")
      local map = vim.keymap.set
      local opts = { buffer = bufnr }

      map("n", "]c", function()
        if vim.wo.diff then return "]c" end
        vim.schedule(gs.next_hunk)
        return "<Ignore>"
      end, vim.tbl_extend("force", opts, { expr = true, desc = "次のhunk" }))

      map("n", "[c", function()
        if vim.wo.diff then return "[c" end
        vim.schedule(gs.prev_hunk)
        return "<Ignore>"
      end, vim.tbl_extend("force", opts, { expr = true, desc = "前のhunk" }))

      map("n", "<leader>gs", gs.stage_hunk, vim.tbl_extend("force", opts, { desc = "hunkをステージ" }))
      map("n", "<leader>gr", gs.reset_hunk, vim.tbl_extend("force", opts, { desc = "hunkをリセット" }))
      map("n", "<leader>gp", gs.preview_hunk, vim.tbl_extend("force", opts, { desc = "hunkをプレビュー" }))
      map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, vim.tbl_extend("force", opts, { desc = "blame" }))
    end,
  },
}
