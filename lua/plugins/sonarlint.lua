--- SonarLint integration
--- https://gitlab.com/schrieveslaach/sonarlint.nvim
--- extends astrocommunity

---@type LazySpec
return {
  "https://gitlab.com/schrieveslaach/sonarlint.nvim",
  opts = {
    server = {
      flags = {
        debounce_text_changes = 500,
      },

      settings = {
        sonarlint = {
          pathToCompileCommands = "compile_commands.json",
        },
      },
    },
  },
}
