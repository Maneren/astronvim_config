--- @type LazySpec
return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
      { "zbirenbaum/copilot.lua", opts = {} },
    },
    opts = {
      model = "gpt-4",
      question_header = "## User ",
      answer_header = "## Copilot ",
      error_header = "## Error ",
      separator = "---",

      show_folds = true,
      show_help = true,
      auto_follow_cursor = true,
      auto_insert_mode = false,
      clear_chat_on_new_prompt = false,

      context = nil,
      history_path = vim.fn.stdpath("data") .. "/copilotchat_history",
      callback = nil,

      -- selection = function(source) return select.visual(source) or select.line(source) end,
      --
      -- prompts = {
      --   Explain = {
      --     prompt = "/COPILOT_EXPLAIN Write an explanation for the active selection as paragraphs of text.",
      --   },
      --   Review = {
      --     prompt = "/COPILOT_REVIEW Review the selected code.",
      --   },
      --   Fix = {
      --     prompt = "/COPILOT_GENERATE There is a problem in this code. Rewrite the code to show it with the bug fixed.",
      --   },
      --   Optimize = {
      --     prompt = "/COPILOT_GENERATE Optimize the selected code to improve performance and readablilty.",
      --   },
      --   Docs = {
      --     prompt = "/COPILOT_GENERATE Please add documentation comment for the selection.",
      --   },
      --   Tests = {
      --     prompt = "/COPILOT_GENERATE Please generate tests for my code.",
      --   },
      --   FixDiagnostic = {
      --     prompt = "Please assist with the following diagnostic issue in file:",
      --     selection = select.diagnostics,
      --   },
      --   Commit = {
      --     prompt = "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.",
      --     selection = select.gitdiff,
      --   },
      --   CommitStaged = {
      --     prompt = "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.",
      --     selection = function(source) return select.gitdiff(source, true) end,
      --   },
      -- },

      mappings = {
        complete = {
          detail = "Use @<Tab> or /<Tab> for options.",
          insert = "<Tab>",
        },
        close = {
          normal = "q",
          insert = "<C-c>",
        },
        reset = {
          normal = "<C-l>",
          insert = "<C-l>",
        },
        submit_prompt = {
          normal = "<CR>",
          insert = "<C-m>",
        },
        accept_diff = {
          normal = "<C-y>",
          insert = "<C-y>",
        },
        yank_diff = {
          normal = "gy",
        },
        show_diff = {
          normal = "gd",
        },
        show_system_prompt = {
          normal = "gp",
        },
        show_user_selection = {
          normal = "gs",
        },
      },
    },
    keys = {
      {
        "<leader>ih",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.help_actions())
        end,
        desc = "CopilotChat - Help actions",
      },
      {
        "<leader>ia",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        desc = "CopilotChat - Prompt actions",
      },
      {
        "<leader>iq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
          end
        end,
        desc = "CopilotChat - Quick chat",
      },
      {
        "<leader>ic",
        "<Cmd>CopilotChatToggle<CR>",
        desc = "CopilotChat - Toggle",
      },
      {
        "<leader>ie",
        "<Cmd>CopilotChatExplain<CR>",
        desc = "CopilotChat - Explain",
      },
      {
        "<leader>ir",
        "<Cmd>CopilotChatReview<CR>",
        desc = "CopilotChat - Review",
      },
      {
        "<leader>if",
        "<Cmd>CopilotChatFix<CR>",
        desc = "CopilotChat - Fix",
      },
      {
        "<leader>io",
        "<Cmd>CopilotChatOptimize<CR>",
        desc = "CopilotChat - Optimize",
      },
      {
        "<leader>id",
        "<Cmd>CopilotChatDocs<CR>",
        desc = "CopilotChat - Docs",
      },
      {
        "<leader>it",
        "<Cmd>CopilotChatTests<CR>",
        desc = "CopilotChat - Tests",
      },
      {
        "<leader>ix",
        "<Cmd>CopilotChatFixDiagnostic<CR>",
        desc = "CopilotChat - Fix diagnostic",
      },
      {
        "<leader>iC",
        "<Cmd>CopilotChatCommit<CR>",
        desc = "CopilotChat - Commit",
      },
      {
        "<leader>is",
        "<Cmd>CopilotChatCommitStaged<CR>",
        desc = "CopilotChat - Commit staged",
      },
    },
  },
}
