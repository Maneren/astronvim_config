---@type LazySpec
return {
  "anuvyklack/vim-smartword",
  event = "VeryLazy",
  keys = {
    { "w", "<Plug>(smartword-w)" },
    { "b", "<Plug>(smartword-b)" },
    { "e", "<Plug>(smartword-e)" },
    { "ge", "<Plug>(smartword-ge)" },
  },
}
