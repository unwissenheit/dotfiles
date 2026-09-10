return {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
  },
  keys = {
    { "<F5>", function() require("dap").continue() end },
    { "<F10>", function() require("dap").step_over() end },
    { "<F11>", function() require("dap").step_into() end },
    { "<leader>b", function() require("dap").toggle_breakpoint() end },
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")
    dapui.setup()
    dap.listeners.before.attach.dapui = dapui.open
    dap.listeners.before.launch.dapui = dapui.open
    dap.listeners.before.event_exited.dapui = dapui.close
  end,
}
