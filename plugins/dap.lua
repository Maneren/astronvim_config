return {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  config = function()
    local dap = require("dap")
    dap.adapters = {
      python = {
        type = "executable",
        command = "python",
        args = { "-m", "debugpy.adapter" },
      },
      lldb = {
        type = "executable",
        command = "/usr/bin/lldb-vscode",
        name = "lldb",
      },
      codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "codelldb",
          args = { "--port", "${port}" },
        },
      },
      coreclr = {
        type = "executable",
        command = "/usr/local/bin/netcoredbg/netcoredbg",
        args = { "--interpreter=vscode" },
      },
    }
    dap.configurations = {
      python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            local venv = os.getenv("VIRTUAL_ENV")
            if venv then
              return venv .. "/bin/python"
            else
              return "python"
            end
          end,
        },
      },
      cpp = {
        {
          name = "Launch",
          type = "codelldb",
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
      },
      cs = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          program = function() return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file") end,
        },
      },
    }
  end,
}
