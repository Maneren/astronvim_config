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
    "jpmcb/nvim-llama",
    cmd = "Llama",
    opts = {
      model = "codegemma:instruct",
    },
  },
  {
    "David-Kunz/gen.nvim",
    cmd = "Gen",
    opts = {
      model = "codegemma:instruct",
      host = "localhost",
      port = "11434",
      quit_map = "q",
      retry_map = "<c-r>",
      display_mode = "split",
      show_prompt = true,
      show_model = true,
      no_auto_close = true,
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    version = "^2",
    cmd = {
      "CopilotChat",
      "CopilotChatOpen",
      "CopilotChatClose",
      "CopilotChatToggle",
      "CopilotChatStop",
      "CopilotChatReset",
      "CopilotChatSave",
      "CopilotChatLoad",
      "CopilotChatDebugInfo",
      "CopilotChatModels",
      "CopilotChatExplain",
      "CopilotChatReview",
      "CopilotChatFix",
      "CopilotChatOptimize",
      "CopilotChatDocs",
      "CopilotChatFixDiagnostic",
      "CopilotChatCommit",
      "CopilotChatCommitStaged",
    },
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
      {
        "AstroNvim/astrocore",
        ---@param opts AstroCoreOpts
        opts = function(_, opts)
          local maps = assert(opts.mappings)
          local prefix = "<Leader>i"
          local astroui = require("astroui")

          maps.n[prefix] = { desc = astroui.get_icon("CopilotChat", 1, true) .. "CopilotChat" }
          maps.v[prefix] = { desc = astroui.get_icon("CopilotChat", 1, true) .. "CopilotChat" }

          maps.n[prefix .. "o"] = { "<Cmd>CopilotChatOpen<CR>", desc = "Open Chat" }
          maps.n[prefix .. "c"] = { "<Cmd>CopilotChatClose<CR>", desc = "Close Chat" }
          maps.n[prefix .. "t"] = { "<Cmd>CopilotChatToggle<CR>", desc = "Toggle Chat" }
          maps.n[prefix .. "r"] = { "<Cmd>CopilotChatReset<CR>", desc = "Reset Chat" }
          maps.n[prefix .. "s"] = { "<Cmd>CopilotChatStop<CR>", desc = "Stop Chat" }

          maps.n[prefix .. "S"] = {
            function()
              vim.ui.input({ prompt = "Save Chat: " }, function(input)
                if input ~= nil and input ~= "" then
                  require("CopilotChat").save(input)
                end
              end)
            end,
            desc = "Save Chat",
          }

          maps.n[prefix .. "L"] = {
            function()
              local copilot_chat = require("CopilotChat")
              local path = copilot_chat.config.history_path
              local chats = require("plenary.scandir").scan_dir(path, { depth = 1, hidden = true })
              -- Remove the path from the chat names and .json
              for i, chat in ipairs(chats) do
                chats[i] = chat:sub(#path + 2, -6)
              end
              vim.ui.select(chats, { prompt = "Load Chat: " }, function(selected)
                if selected ~= nil and selected ~= "" then
                  copilot_chat.load(selected)
                end
              end)
            end,
            desc = "Load Chat",
          }

          -- Helper function to create mappings
          local function create_mapping(action_type, selection_type)
            return function()
              require("CopilotChat.integrations.telescope").pick(require("CopilotChat.actions")[action_type] {
                selection = require("CopilotChat.select")[selection_type],
              })
            end
          end

          maps.n[prefix .. "p"] = {
            create_mapping("prompt_actions", "buffer"),
            desc = "Prompt actions",
          }

          maps.v[prefix .. "p"] = {
            create_mapping("prompt_actions", "visual"),
            desc = "Prompt actions",
          }

          maps.n[prefix .. "d"] = {
            create_mapping("help_actions", "buffer"),
            desc = "LSP Diagnostics actions",
          }

          maps.v[prefix .. "d"] = {
            create_mapping("help_actions", "visual"),
            desc = "LSP Diagnostics actions",
          }

          -- Quick Chat function
          local function quick_chat(selection_type)
            return function()
              vim.ui.input({ prompt = "Quick Chat: " }, function(input)
                if input ~= nil and input ~= "" then
                  require("CopilotChat").ask(input, { selection = require("CopilotChat.select")[selection_type] })
                end
              end)
            end
          end

          maps.n[prefix .. "q"] = {
            quick_chat("buffer"),
            desc = "Quick Chat",
          }

          maps.v[prefix .. "q"] = {
            quick_chat("visual"),
            desc = "Quick Chat",
          }
        end,
      },
      { "AstroNvim/astroui", opts = { icons = { CopilotChat = "" } } },
    },
    opts = {
      window = {
        width = 0.4,
        height = vim.o.lines - 4, -- absolute height in rows, subtract for command line and status line
        row = 1, -- row position of the window, starting from the top
      },

      model = "gpt-4o",
      question_header = "## User ",
      answer_header = "## Copilot ",
      error_header = "## Error ",

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
          normal = "<C-CR>",
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
  },
}
