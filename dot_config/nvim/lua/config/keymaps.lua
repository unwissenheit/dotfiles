vim.keymap.set("n", "<leader>fp", function() require("bookmarks").pick() end, { desc = "登録ディレクトリへ移動" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "診断をフロート表示" })
