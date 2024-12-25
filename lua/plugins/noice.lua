--- GUI for cmdline and popupmenu
--- https://github.com/folke/noice.nvim
--- extends astrocommunity

---@type LazySpec
return {
  "folke/noice.nvim",
  opts = {
    messages = {
      enabled = false,
    },
    cmdline_popup = {
      position = {
        row = 5,
        col = "50%",
      },
      size = {
        width = 60,
        height = "auto",
      },
    },
    popupmenu = {
      relative = "editor",
      position = {
        row = 8,
        col = "50%",
      },
      size = {
        width = 60,
        height = 10,
      },
      border = {
        style = "rounded",
        padding = { 0, 1 },
      },
      win_options = {
        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
      },
    },
  },
  config = function(_, opts)
    require("noice").setup(opts)
    require("telescope").load_extension("noice")
  end,
}
