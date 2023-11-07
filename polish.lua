return function()
  require("neodev").setup {
    library = { plugins = { "neotest" }, types = true },
  }

  local dap = require "dap"
  dap.adapters.lldb = {
    type = "executable",
    command = "/usr/bin/lldb-vscode", -- adjust as needed, must be absolute path
    name = "lldb",
  }
  dap.configurations.cpp = {
    {
      name = "Launch",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.input {
          prompt = "Path to executable: ",
          default = vim.fn.getcwd() .. "/",
          completion = "file",
        }
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = {},
    },
  }
  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp
end
