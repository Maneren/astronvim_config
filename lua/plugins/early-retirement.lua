--- Close buffer after 15 minutes of inactivity
--- https://github.com/chrisgrieser/nvim-early-retirement

---@type LazySpec
return {
  "chrisgrieser/nvim-early-retirement",
  event = "User AstroFile",
  opts = {
    retirementAgeMins = 15,
  },
}
