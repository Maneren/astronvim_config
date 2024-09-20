--- Modern search and replace
--- https://github.com/MagicDuck/grug-far.nvim
--- extends the astrocommunity module

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
}
