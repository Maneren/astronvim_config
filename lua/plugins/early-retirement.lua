--- Close buffer after 10 minutes of inactivity
--- https://github.com/chrisgrieser/nvim-early-retirement

---@type LazySpec
return {
  "chrisgrieser/nvim-early-retirement",
  opts = {
    retirementAgeMins = 10,
  },
  event = "VeryLazy",
}
