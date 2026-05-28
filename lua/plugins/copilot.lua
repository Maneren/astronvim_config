--- Github Copilot Chat window
--- https://github.com/CopilotC-Nvim/CopilotChat.nvim
--- extends astrocommunity

---@type LazySpec
return {
  "CopilotC-Nvim/CopilotChat.nvim",
  cmd = {
    "CopilotChat",
    "CopilotChatOpen",
    "CopilotChatClose",
    "CopilotChatToggle",
    "CopilotChatStop",
    "CopilotChatReset",
    "CopilotChatSave",
    "CopilotChatLoad",
    "CopilotChatModels",
    "CopilotChatExplain",
    "CopilotChatReview",
    "CopilotChatFix",
    "CopilotChatOptimize",
    "CopilotChatDocs",
    "CopilotChatTests",
    "CopilotChatCommit",
  },
  dependencies = {
    { "zbirenbaum/copilot.lua" },
    { "nvim-lua/plenary.nvim" },
  },
  opts = function(_, opts)
    local prompts = vim.tbl_deep_extend("force", require("CopilotChat.config").prompts, {
      -- Code related prompts
      Review = {
        prompt = "/COPILOT_REVIEW\n\nPlease review the following code and provide suggestions for improvement. Explain the changes first, then provide the fixed code.",
      },
      Tests = {
        prompt = "/COPILOT_GENERATE\n\nPlease explain how the selected code works, then generate unit tests for it.",
      },
      FixError = {
        prompt = "/COPILOT_EXPLAIN\n\nPlease find and explain the error in the following code and provide an explanation and a fixed solution.",
      },
      Docs = {
        prompt = "/COPILOT_GENERATE\n\nPlease write a documentation for the following code in a format fitting for the language. It should contain a concise one line summary, detailed description, arguments, return values and possible error conditions.",
      },
      Comments = { prompt = "/COPILOT_GENERATE\n\nPlease add short comments to the following code where needed." },
      -- Text related prompts
      Summarize = { prompt = "/COPILOT_GENERATE\n\nPlease summarize the following text." },
      Spelling = {
        prompt = "/COPILOT_REVIEW\n\nPlease correct any grammar and spelling errors in the following text while preserving the formatting.",
      },
      Wording = {
        prompt = "/COPILOT_GENERATE\n\nPlease improve the grammar and wording of the following text while preserving the formatting.",
      },
      Concise = {
        prompt = "/COPILOT_GENERATE\n\nPlease rewrite the following text to make it more concise while preserving the overall formatting.",
      },
    })

    ---@type CopilotChat.config
    local custom_opts = {
      window = {
        width = 0.4,
      },

      model = "grok-code-fast-1",
      prompts = prompts,

      highlight_headers = false,
      auto_follow_cursor = true,
      auto_insert_mode = true,
    }

    return vim.tbl_deep_extend("force", opts, custom_opts)
  end,
}
