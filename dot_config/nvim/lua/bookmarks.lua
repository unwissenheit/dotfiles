-- 事前に登録したディレクトリへ Telescope からジャンプするための小さな機能。
-- 場所を増やしたいときは M.dirs に1行足すだけでよい。
--
-- Windows/Mac でパスが違う場所は is_windows で分岐する。chezmoi の
-- テンプレート機能(.tmpl)は使わず、このファイル自体をそのまま両OSで
-- 共有し、実行時に vim.fn.has("win32") で切り替える方式にしている。
local M = {}

local is_windows = vim.fn.has("win32") == 1

M.dirs = {
  { name = "nvim config", path = "~/.config/nvim" },
  {
    name = "dotfiles (chezmoi source)",
    path = is_windows
      and (vim.fn.expand("$USERPROFILE") .. "/.local/share/chezmoi")
      or "~/.local/share/chezmoi",
  },
  -- { name = "適当な名前", path = "~/path/to/project" },
}

function M.pick()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  pickers
    .new({}, {
      prompt_title = "登録ディレクトリへ移動",
      finder = finders.new_table({
        results = M.dirs,
        entry_maker = function(entry)
          return {
            value = entry,
            display = string.format("%-28s %s", entry.name, entry.path),
            ordinal = entry.name,
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(bufnr, _)
        actions.select_default:replace(function()
          actions.close(bufnr)
          local selection = action_state.get_selected_entry()
          local path = vim.fn.expand(selection.value.path)
          vim.cmd.cd(path)
          vim.notify("cd: " .. path)
          require("telescope.builtin").find_files({ cwd = path })
        end)
        return true
      end,
    })
    :find()
end

return M
