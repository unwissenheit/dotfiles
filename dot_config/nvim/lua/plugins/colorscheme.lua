return {
  "EdenEast/nightfox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("nightfox").setup({
      options = {
        transparent = false,
        terminal_colors = true,
        dim_inactive = true,
        styles = {
          comments = "italic",
          keywords = "bold",
          functions = "italic,bold",
          types = "italic,bold",
        },
        inverse = {
          match_paren = true,
        },
      },
    })
    vim.cmd("colorscheme duskfox")
  end,
}
