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
    filter = function(bufnr)
      if vim.endswith(vim.api.nvim_buf_get_name(bufnr), ".env") then
        return false
      end
      return true
    end,
  },
  specs = {
    {
      "astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          i = {
            ["<A-f>"] = {
              function() require("neocodeium").accept() end,
              desc = "Codeium accept",
            },
            ["<A-w>"] = {
              function() require("neocodeium").accept_word() end,
              desc = "Codeium accept word",
            },
            ["<A-a>"] = {
              function() require("neocodeium").accept_line() end,
              desc = "Codeium accept line",
            },
            ["<A-e>"] = {
              function() require("neocodeium").cycle_or_complete(1) end,
              desc = "Codeium next",
            },
            ["<A-r>"] = {
              function() require("neocodeium").cycle_or_complete(-1) end,
              desc = "Codeium prev",
            },
            ["<A-c>"] = {
              function() require("neocodeium").cancel() end,
              desc = "Codeium cancel",
            },
          },
        },
      },
    },
  },
}
