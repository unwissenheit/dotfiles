return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    require("nvim-treesitter").setup()
    require("nvim-treesitter").install({
      "c_sharp", "lua", "vim", "vimdoc", "json", "xml", "markdown", "bash",
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "c_sharp", "lua", "json", "xml", "markdown", "bash" },
      callback = function()
        pcall(vim.treesitter.start)
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      end,
    })
  end,
}

