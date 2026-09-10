local o = vim.opt

o.number = true
o.relativenumber = true
o.signcolumn = "yes"
o.cursorline = true
o.termguicolors = true
o.showmode = false          -- ステータスラインを入れるなら不要
o.laststatus = 3            -- ウィンドウ分割してもステータスは1本

o.expandtab = true
o.shiftwidth = 4            -- C# 中心なので既定を4に
o.tabstop = 4
o.smartindent = true

o.ignorecase = true
o.smartcase = true
o.inccommand = "split"

o.undofile = true
o.swapfile = false
o.updatetime = 250
o.timeoutlen = 400
o.scrolloff = 8
o.splitright = true
o.splitbelow = true
o.clipboard = "unnamedplus"

vim.g.have_nerd_font = true

-- 診断表示。C# は警告が多いので virtual_text は控えめに
vim.diagnostic.config({
  virtual_text = { spacing = 2, prefix = "●" },
  severity_sort = true,
  float = { border = "rounded", source = true },
})
