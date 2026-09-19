return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VimEnter", -- 引数なしで nvim を開いたときだけ alpha 自身が判断して表示
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
        "███████╗██╗  ██╗ ██████╗ ██╗    ██╗    ███╗   ███╗███████╗    ████████╗██╗  ██╗███████╗     ██████╗ ██████╗ ██████╗ ███████╗",
        "██╔════╝██║  ██║██╔═══██╗██║    ██║    ████╗ ████║██╔════╝    ╚══██╔══╝██║  ██║██╔════╝    ██╔════╝██╔═══██╗██╔══██╗██╔════╝",
        "███████╗███████║██║   ██║██║ █╗ ██║    ██╔████╔██║█████╗         ██║   ███████║█████╗      ██║     ██║   ██║██║  ██║█████╗  ",
        "╚════██║██╔══██║██║   ██║██║███╗██║    ██║╚██╔╝██║██╔══╝         ██║   ██╔══██║██╔══╝      ██║     ██║   ██║██║  ██║██╔══╝  ",
        "███████║██║  ██║╚██████╔╝╚███╔███╔╝    ██║ ╚═╝ ██║███████╗       ██║   ██║  ██║███████╗    ╚██████╗╚██████╔╝██████╔╝███████╗",
        "╚══════╝╚═╝  ╚═╝ ╚═════╝  ╚══╝╚══╝     ╚═╝     ╚═╝╚══════╝       ╚═╝   ╚═╝  ╚═╝╚══════╝     ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝",
    }

    dashboard.section.buttons.val = {
      dashboard.button("f", "  ファイル検索", "<cmd>Telescope find_files<CR>"),
      dashboard.button("g", "  全文検索", "<cmd>Telescope live_grep<CR>"),
      dashboard.button("r", "  最近使ったファイル", "<cmd>Telescope oldfiles<CR>"),
      dashboard.button("o", "  ファイラー(oil)", "<cmd>Oil<CR>"),
      dashboard.button("p", "  登録ディレクトリへ移動", "<cmd>lua require('bookmarks').pick()<CR>"),
      dashboard.button("e", "  新規ファイル", "<cmd>enew<CR>"),
      dashboard.button("q", "  終了", "<cmd>qa<CR>"),
    }

    alpha.setup(dashboard.opts)
  end,
}
