--- GUI for cmdline and popupmenu
--- https://github.com/folke/noice.nvim
--- extends astrocommunity

---@type LazySpec
return {
  "folke/noice.nvim",
  opts = {
    notify = {
      enabled = false,
    },
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
  },
}
