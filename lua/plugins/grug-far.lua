--- Modern search and replace
--- https://github.com/MagicDuck/grug-far.nvim
--- extends astrocommunity

---@type LazySpec
return {
  "MagicDuck/grug-far.nvim",
  ---@type GrugFarOptionsOverride
  opts = {
    engines = {
      astgrep = {
        path = "ast-grep",
      },
    },
  },
  specs = {
    { "catppuccin", opts = { integrations = { grug_far = true } } },
  },
}
