--- Discord Rich Presence
--- https://github.com/vyfor/cord.nvim
--- extends astrocommunity

---@type LazySpec
return {
  "vyfor/cord.nvim",
  opts = {
    buttons = {
      { label = "View Repository", url = function(opts) return opts.repo_url end },
    },
    display = {
      theme = "catppuccin",
      flavor = "dark",
    },
  },
}
