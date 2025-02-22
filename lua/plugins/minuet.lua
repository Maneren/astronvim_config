---@type LazySpec
return {
  "milanglacier/minuet-ai.nvim",
  event = "User AstroFile",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    provider = "openai_fim_compatible",
    n_completions = 1,
    context_window = 2048,
    provider_options = {
      openai_fim_compatible = {
        api_key = "TERM",
        name = "Ollama",
        end_point = "http://localhost:11434/v1/completions",
        model = "qwen2.5-coder:3b",
        optional = {
          max_tokens = 96,
          top_p = 0.9,
        },
      },
    },
    virtualtext = {
      auto_trigger_ft = { "*" },
      keymap = {
        accept = "<S-Enter>",
        accept_line = "<A-Enter>",
        prev = "<A-[>",
        next = "<A-]>",
        dismiss = "<A-e>",
      },
    },
  },
}
