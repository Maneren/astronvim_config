--- Shows completion sources for NPM packages
--- https://github.com/David-Kunz/cmp-npm

---@type LazySpec
return {
  "David-Kunz/cmp-npm",
  event = "BufRead package.json",
  dependencies = { "nvim-cmp" },
  opts = { ignore = { "beta", "rc" } },
}
