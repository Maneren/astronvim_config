--- Better word-wise navigation
--- https://github.com/anuvyklack/vim-smartword

---@type LazySpec
return {
  "anuvyklack/vim-smartword",
  event = "BufEnter",
  keys = {
    { "w", "<Plug>(smartword-w)" },
    { "b", "<Plug>(smartword-b)" },
    { "e", "<Plug>(smartword-e)" },
    { "ge", "<Plug>(smartword-ge)" },
  },
}
