local aug = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- ヤンクしたテキストをハイライト
vim.api.nvim_create_autocmd("TextYankPost", {
  group = aug,
  callback = function() vim.hl.on_yank() end,
})

-- LSP がアタッチしたバッファ限定のキーマップ
vim.api.nvim_create_autocmd("LspAttach", {
  group = aug,
  callback = function(ev)
    local opts = { buffer = ev.buf }
    local map = vim.keymap.set
    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "gr", vim.lsp.buf.references, opts)
    map("n", "gi", vim.lsp.buf.implementation, opts)
    map("n", "K", vim.lsp.buf.hover, opts)
    map("n", "<leader>rn", vim.lsp.buf.rename, opts)
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts)

    -- インレイヒント（Roslyn の設定と両方必要）
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
    end
  end,
})

-- 補完を有効化（0.11+ の組み込み補完）
vim.api.nvim_create_autocmd("LspAttach", {
  group = aug,
  callback = function(ev)
    vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, { autotrigger = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = aug,
  pattern = { "cs", "lua", "vim", "json", "xml", "markdown", "sh" },
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
