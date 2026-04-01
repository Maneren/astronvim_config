--- Improved hover window
--- https://github.com/lewis6991/hover.nvim

---@type LazySpec
return {
  "lewis6991/hover.nvim",
  opts = {
    init = function()
      require("hover.providers.lsp")
      require("hover.providers.dap")
      require("hover.providers.fold_preview")
      require("hover.providers.man")
    end,
    preview_window = true,
    title = false,
  },
}
