---@type LazySpec
return {
  "mxsdev/nvim-dap-vscode-js",
  event = "VeryLazy",
  dependencies = { "mfussenegger/nvim-dap", "microsoft/vscode-js-debug" },
  opts = { adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" } },
}
