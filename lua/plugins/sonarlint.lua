---@type LazySpec
return {
  "https://gitlab.com/schrieveslaach/sonarlint.nvim",
  ft = { "c", "cpp", "h", "hpp", "javascript", "php", "python", "typescript" },
  opts = {
    server = {
      cmd = {
        "sonarlint-language-server",
        -- Ensure that sonarlint-language-server uses stdio channel
        "-stdio",
        "-analyzers",
        vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcfamily.jar"),
        vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjs.jar"),
        vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarphp.jar"),
        vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
      },

      settings = {
        sonarlint = {
          pathToCompileCommands = "build/compile_commands.json",
        },
      },
    },
    filetypes = {
      "c",
      "cpp",
      "h",
      "hpp",
      "javascript",
      "php",
      "python",
      "typescript",
    },
  },
}
