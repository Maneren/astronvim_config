--- Improved hover window
--- https://github.com/lewis6991/hover.nvim

---@type LazySpec
return {
  "lewis6991/hover.nvim",
  opts = {
    init = function()
      require("hover.providers.lsp")
      require("hover.providers.gh")
      require("hover.providers.gh_user")
      require("hover.providers.dap")
      require("hover.providers.fold_preview")
      require("hover.providers.man")
      require("hover.providers.dictionary")
    end,
    preview_window = true,
    title = false,
  },
  dependencies = {
    "astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["K"] = { function(opts) require("hover").hover(opts) end, desc = "hover.nvim" },
          ["gK"] = {
            function(opts) require("hover").hover_select(opts) end,
            desc = "hover.nvim (select)",
          },
        },
      },
    },
  },
}
