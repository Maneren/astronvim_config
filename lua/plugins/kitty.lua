--- View Kitty scrollback in nvim
--- https://github.com/mikesmithgh/kitty-scrollback.nvim

--- requires complementary kitten installed

---@type LazySpec
return {
  "mikesmithgh/kitty-scrollback.nvim",
  cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
  event = { "User KittyScrollbackLaunch" },
  opts = {},
}
