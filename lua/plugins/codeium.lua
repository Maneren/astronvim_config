--- Lightweight copilot alternative
--- https://github.com/Exafunction/codeium.vim

---@type LazySpec
return {
  "Exafunction/codeium.vim",
  event = "InsertEnter",
  config = function() vim.g.codeium_no_map_tab = 1 end,
  dependencies = {
    {
      "astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          i = {
            ["<S-CR>"] = {
              function() return vim.fn["codeium#Accept"]() end,
              desc = "Accept codeium suggestion",
              expr = true,
            },
          },
        },
      },
    },
  },
}
