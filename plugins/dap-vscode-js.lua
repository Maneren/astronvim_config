return {
  "mxsdev/nvim-dap-vscode-js",
  lazy = false,
  dependencies = { "mfussenegger/nvim-dap", "microsoft/vscode-js-debug" },
  opts = {
    adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
  },
}
