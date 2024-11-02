--- Lightweight copilot alternative
--- https://github.com/Exafunction/codeium.nvim

---@type LazySpec
return {
  "Exafunction/codeium.nvim",
  event = "InsertEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    enable_cmp_source = false,
    enable_chat = false,
    virtual_text = {
      enabled = true,
      key_bindings = {
        accept = "<S-CR>",
      },
    },
  },
}
