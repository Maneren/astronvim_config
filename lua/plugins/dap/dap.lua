---@type LazySpec
return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      handlers = {
        python = function()
          require("dap").adapters.python = {
            type = "executable",
            command = vim.fn.exepath("python"),
            args = {
              "-m",
              "debugpy.adapter",
            },
          }
        end,
        codelldb = function()
          require("dap").adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
              command = vim.fn.exepath("codelldb"),
              args = { "--port", "${port}" },
            },
          }
        end,
        coreclr = function()
          require("dap").adapters.coreclr = {
            type = "executable",
            command = vim.fn.exepath("netcoredbg"),
            args = { "--interpreter=vscode" },
          }
        end,
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "mxsdev/nvim-dap-vscode-js",
        dependencies = { "microsoft/vscode-js-debug" },
        opts = { adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" } },
      },
    },
  },
}
