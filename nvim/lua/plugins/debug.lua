return {
  -- nvim-dap-python setup
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      -- Configure nvim-dap-python with your specific settings (adjust for your setup)
      require("dap-python").setup "uv" -- 'uv' can be your Python interpreter or path
    end,
    dependencies = { "mfussenegger/nvim-dap" }, -- Ensure nvim-dap is loaded first
    lazy = false,
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap, dapui = require "dap", require "dapui"
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
    end,
  },
}
