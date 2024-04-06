---@type LazySpec
return {
  "Exafunction/codeium.vim",
  event = "BufEnter",
  config = function() vim.g.codeium_no_map_tab = 1 end,
  keys = {
    {
      "<S-CR>",
      function() return vim.fn["codeium#Accept"]() end,
      desc = "Accept codeium suggestion",
      expr = true,
      mode = "i",
    },
  },
}
