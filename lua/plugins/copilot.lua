local prompts = {
  -- Code related prompts
  Explain = "Please explain how the following code works.",
  Review = "Please review the following code and provide suggestions for improvement.",
  Tests = "Please explain how the selected code works, then generate unit tests for it.",
  Refactor = "Please refactor the following code to improve its clarity and readability.",
  FixCode = "Please fix the following code to make it work as intended.",
  FixError = "Please explain the error in the following text and provide a solution.",
  BetterNamings = "Please provide better names for the following variables and functions.",
  Documentation = "Please provide outside API documentation for the following code. It should contain a concise one line summary, detailed description, arguments, and return values in format fitting to the language.",
  Comments = "Please add short comments to the following code where needed.",
  -- Text related prompts
  Summarize = "Please summarize the following text.",
  Spelling = "Please correct any grammar and spelling errors in the following text.",
  Wording = "Please improve the grammar and wording of the following text.",
  Concise = "Please rewrite the following text to make it more concise.",
}

---@type LazySpec
return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    event = "User AstroFile",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
      {
        "zbirenbaum/copilot.lua",
        opts = {
          suggestion = { enabled = false },
          panel = { enabled = false },
        },
      },
      {
        "astrocore",
        opts = {
          mappings = {
            n = {
              ["<leader>i"] = { group = " Copilot" },
              ["<leader>ih"] = {
                function()
                  local actions = require("CopilotChat.actions")
                  require("CopilotChat.integrations.telescope").pick(actions.help_actions())
                end,
                desc = "CopilotChat - Help actions",
              },
              ["<leader>ip"] = {
                function()
                  local actions = require("CopilotChat.actions")
                  require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
                end,
                desc = "CopilotChat - Prompt actions",
              },
              ["<leader>ie"] = { "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
              ["<leader>it"] = { "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
              ["<leader>ir"] = { "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code" },
              ["<leader>iR"] = { "<cmd>CopilotChatRefactor<cr>", desc = "CopilotChat - Refactor code" },
              ["<leader>in"] = { "<cmd>CopilotChatBetterNamings<cr>", desc = "CopilotChat - Better Naming" },
              ["<leader>ii"] = {
                function()
                  local input = vim.fn.input("Ask Copilot: ")
                  if input ~= "" then
                    vim.cmd("CopilotChat " .. input)
                  end
                end,
                desc = "CopilotChat - Ask input",
              },
              ["<leader>im"] = {
                "<cmd>CopilotChatCommit<cr>",
                desc = "CopilotChat - Generate commit message for all changes",
              },
              ["<leader>iM"] = {
                "<cmd>CopilotChatCommitStaged<cr>",
                desc = "CopilotChat - Generate commit message for staged changes",
              },
              ["<leader>iq"] = {
                function()
                  local input = vim.fn.input("Quick Chat: ")
                  if input ~= "" then
                    require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
                  end
                end,
                desc = "CopilotChat - Quick chat",
              },
              ["<leader>id"] = { "<cmd>CopilotChatDebugInfo<cr>", desc = "CopilotChat - Debug Info" },
              ["<leader>if"] = { "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix Diagnostic" },
              ["<leader>il"] = { "<cmd>CopilotChatReset<cr>", desc = "CopilotChat - Clear buffer and chat history" },
              ["<leader>iv"] = { "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle" },
              ["<leader>is"] = { "<cmd>CopilotChatStop<cr>", desc = "CopilotChat - Stop" },
            },
            x = {
              ["<leader>i"] = { group = " Copilot" },
              ["<leader>ip"] = {
                function()
                  local actions = require("CopilotChat.actions")
                  local select = require("CopilotChat.select")
                  require("CopilotChat.integrations.telescope").pick(
                    actions.prompt_actions { selection = select.visual }
                  )
                end,
                desc = "CopilotChat - Prompt actions",
              },
              ["<leader>iv"] = { ":CopilotChatVisual", desc = "CopilotChat - Open in vertical split" },
              ["<leader>ix"] = { ":CopilotChatInline<cr>", desc = "CopilotChat - Inline chat" },
            },
          },
        },
      },
    },
    opts = {
      model = "gpt-4",
      question_header = "## User ",
      answer_header = "## Copilot ",
      error_header = "## Error ",

      context = nil,
      history_path = vim.fn.stdpath("data") .. "/copilotchat_history",
      callback = nil,

      prompts = prompts,

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
          insert = "<C-CR>",
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
    config = function(_, opts)
      local chat = require("CopilotChat")
      local select = require("CopilotChat.select")

      -- Use unnamed register for the selection
      opts.selection = function(source) return select.visual(source) or select.line(source) end

      chat.setup(opts)

      vim.api.nvim_create_user_command(
        "CopilotChatVisual",
        function(args) chat.ask(args.args, { selection = select.visual }) end,
        { nargs = "*", range = true }
      )

      vim.api.nvim_create_user_command(
        "CopilotChatInline",
        function(args)
          chat.ask(args.args, {
            selection = select.visual,
            window = {
              layout = "float",
              relative = "cursor",
              width = 1,
              height = 0.4,
              row = 1,
            },
          })
        end,
        { nargs = "*", range = true }
      )

      vim.api.nvim_create_user_command(
        "CopilotChatBuffer",
        function(args) chat.ask(args.args, { selection = select.buffer }) end,
        { nargs = "*", range = true }
      )

      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-*",
        callback = function()
          vim.opt_local.relativenumber = true
          vim.opt_local.number = true

          local ft = vim.bo.filetype
          if ft == "copilot-chat" then
            vim.bo.filetype = "markdown"
          end
        end,
      })
    end,
  },
}
