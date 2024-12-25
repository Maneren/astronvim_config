--- Close buffer after 10 minutes of inactivity
--- https://github.com/chrisgrieser/nvim-early-retirement
--- extends astrocommunity

---@type LazySpec
return {
  "chrisgrieser/nvim-early-retirement",
  event = "BufEnter",
  opts = {
    retirementAgeMins = 15,
  },
}
