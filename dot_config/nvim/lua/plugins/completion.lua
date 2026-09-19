-- 補完UI(blink.cmp)とスニペット展開(LuaSnip + friendly-snippets)。
-- 組み込みLSP補完(vim.lsp.completion)はここに一本化したので
-- config/autocmds.lua 側では無効化済み。
return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp", -- 正規表現トリガー付きスニペット用。無くても動く
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  {
    "saghen/blink.cmp",
    version = "1.*", -- prebuilt バイナリを使う（cargo不要）
    dependencies = { "L3MON4D3/LuaSnip" },
    event = "InsertEnter",
    opts = {
      keymap = { preset = "default" },
      appearance = { nerd_font_variant = "mono" },
      completion = { documentation = { auto_show = true } },
      snippets = { preset = "luasnip" },
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
  },
}
