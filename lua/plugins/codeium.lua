--- Lightweight copilot alternative
--- https://github.com/Exafunction/codeium.nvim

---@type LazySpec
return {
  "Exafunction/codeium.nvim",
  event = "BufEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    enable_cmp_source = false,
    enable_chat = false,
    virtual_text = {
      enabled = true,
    },
  },
}
