return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    options = {
      theme = "nightfox", -- colorscheme.lua の duskfox に追従するテーマ
      globalstatus = true, -- options.lua の laststatus = 3 と揃える
    },
    sections = {
      lualine_c = { "filename" },
      lualine_x = {
        -- Roslyn / easy-dotnet の二重LSP起動などをすぐ気づけるよう、
        -- アタッチ中のクライアント名を出す（README の「診断が2つ出る」対策）
        function()
          local clients = vim.lsp.get_clients({ bufnr = 0 })
          if #clients == 0 then return "" end
          return table.concat(vim.tbl_map(function(c) return c.name end, clients), ", ")
        end,
        "encoding",
        "filetype",
      },
    },
  },
}
