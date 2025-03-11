---@type LazySpec
return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      handlers = {
        python = function()
          require("dap").adapters.python = {
            type = "executable",
            command = "/usr/bin/python3",
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
              command = "codelldb",
              args = { "--port", "${port}" },
            },
          }
        end,
        coreclr = function()
          require("dap").adapters.coreclr = {
            type = "executable",
            command = "netcoredbg",
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
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "ChristianChiarulli/neovim-codicons" },
    opts = {
      layouts = {
        {
          elements = {
            {
              id = "scopes",
              size = 0.30,
            },
            {
              id = "stacks",
              size = 0.30,
            },
            {
              id = "watches",
              size = 0.20,
            },
            {
              id = "breakpoints",
              size = 0.20,
            },
          },
          position = "left",
          size = 40,
        },
        {
          elements = {
            {
              id = "repl",
              size = 0.4,
            },
            {
              id = "console",
              size = 0.6,
            },
          },
          position = "bottom",
          size = 10,
        },
      },
    },
  },
}
