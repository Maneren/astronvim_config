--- Flash movement
--- https://github.com/folke/flash.nvim
--- extends astrocommunity

---@type LazySpec
return {
  "folke/flash.nvim",
  ---@type Flash.Config
  opts = {
    search = {
      mode = "fuzzy",
    },
    label = {
      rainbow = {
        enabled = true,
      },
    },
    modes = {
      char = {
        jump_labels = true,
      },
    },
  },
}
