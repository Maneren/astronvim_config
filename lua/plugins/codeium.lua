--- Lightweight copilot alternative (unofficial plugin)
--- https://github.com/monkoose/neocodeium

---@type LazySpec
return {
  "monkoose/neocodeium",
  event = "User AstroFile",
  opts = {
    show_label = false,
    debounce = false,
    silent = true,
  },
  specs = {
    {
      "astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          i = {
            ["<S-Enter>"] = {
              function() require("neocodeium").accept() end,
              desc = "Codeium accept",
            },
            ["<M-S-Enter>"] = {
              function() require("neocodeium").accept_word() end,
              desc = "Codeium accept word",
            },
            ["<C-S-Enter>"] = {
              function() require("neocodeium").accept_line() end,
              desc = "Codeium accept line",
            },
          },
        },
      },
    },
  },
}
