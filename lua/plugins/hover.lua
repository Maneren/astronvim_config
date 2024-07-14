--- Improved hover window
--- https://github.com/lewis6991/hover.nvim

---@type LazySpec
return {
  "lewis6991/hover.nvim",
  opts = {
    init = function() require("hover.providers.lsp") end,
    preview_window = true,
    title = false,
  },
}
