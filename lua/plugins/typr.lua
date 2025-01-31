--- Typing trainer
--- https://github.com/nvzone/typr

---@type LazySpec
return {
  "nvzone/typr",
  dependencies = "nvzone/volt",
  opts = {
    mode = "phrases",
    wpm_goal = 80,
    insert_on_start = true,
  },
  cmd = { "Typr", "TyprStats" },
}
