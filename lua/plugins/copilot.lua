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
    version = "^3",
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

          maps.n[prefix .. "o"] = { ":CopilotChatOpen<CR>", desc = "Open Chat" }
          maps.n[prefix .. "c"] = { ":CopilotChatClose<CR>", desc = "Close Chat" }
          maps.n[prefix .. "t"] = { ":CopilotChatToggle<CR>", desc = "Toggle Chat" }
          maps.n[prefix .. "r"] = { ":CopilotChatReset<CR>", desc = "Reset Chat" }
          maps.n[prefix .. "s"] = { ":CopilotChatStop<CR>", desc = "Stop Chat" }

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
    config = function()
      local utils = require("astrocore")
      local prompts = utils.extend_tbl(require("CopilotChat.config").prompts, {
        -- Code related prompts
        Review = {
          prompt = "/COPILOT_REVIEW\n\nPlease review the following code and provide suggestions for improvement.",
        },
        Tests = {
          prompt = "/COPILOT_GENERATE\n\nPlease explain how the selected code works, then generate unit tests for it.",
        },
        FixError = {
          prompt = "/COPILOT_EXPLAIN\n\nPlease explain the error in the following code and provide a solution.",
        },
        BetterNamings = {
          prompt = "/COPILOT_GENERATE\n\nPlease provide better names for the following variables and functions.",
        },
        Docs = {
          prompt = "/COPILOT_GENERATE\n\nPlease write a documentation for the following code in a format fitting to the language. It should contain a concise one line summary, detailed description, arguments, return values and possible error conditions.",
        },
        Comments = { prompt = "/COPILOT_GENERATE\n\nPlease add short comments to the following code where needed." },
        -- Text related prompts
        Summarize = { prompt = "/COPILOT_GENERATE\n\nPlease summarize the following text." },
        Spelling = {
          prompt = "/COPILOT_REVIEW\n\nPlease correct any grammar and spelling errors in the following text.",
        },
        Wording = { prompt = "/COPILOT_GENERATE\n\nPlease improve the grammar and wording of the following text." },
        Concise = { prompt = "/COPILOT_GENERATE\n\nPlease rewrite the following text to make it more concise." },
      })

      ---@type CopilotChat.config
      local opts = {
        window = {
          width = 0.4,
        },

        model = "gpt-4o",
        prompts = prompts,

        highlight_headers = false,
        auto_follow_cursor = true,
        auto_insert_mode = true,
      }

      require("CopilotChat").setup(opts)
    end,
  },
}
