---@type LazySpec
return {
  {
    "benlubas/molten-nvim",
    enabled = false,
    -- dependencies = { "3rd/image.nvim" },
    ft = { "python", "norg", "markdown", "quarto" },
    -- specs = {
    --   {
    --     "astrocore",
    --     ---@type AstroCoreOpts
    --     opts = {
    --       mappings = {
    --         n = {
    --           ["<LocalLeader>mr"] = { "<Cmd>MoltenEvaluateVisual<CR>", desc = "Evaluate selection" },
    --           ["<LocalLeader>mR"] = { "<Cmd>MoltenReevaluateCell<CR>", desc = "Re-evaluate cell" },
    --           ["<LocalLeader>mi"] = { "<Cmd>MoltenInit<CR>", desc = "Initialize Molten" },
    --         },
    --         v = {
    --           ["<LocalLeader>mr"] = { "<Cmd>MoltenEvaluateVisual<CR>", desc = "Evaluate selection" },
    --         },
    --       }
    --     }
    --   }
    -- },
    init = function()
      vim.g.molten_cover_empty_lines = true
      vim.g.molten_comment_string = "# %%"

      vim.g.molten_auto_image_popup = true
      -- vim.g.molten_show_mimetype_debug = true
      vim.g.molten_auto_open_output = false
      vim.g.molten_image_location = "float"
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_show_more = true
      vim.g.molten_output_win_border = { "", "━", "", "" }
      vim.g.molten_output_win_max_height = 12
      vim.g.molten_output_virt_lines = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_use_border_highlights = true
      vim.g.molten_virt_lines_off_by_1 = true
      vim.g.molten_wrap_output = true
      vim.g.molten_tick_rate = 142

      -- vim.keymap.set(
      --   "n",
      --   "<localleader>ir",
      --   function() vim.cmd("MoltenInit rust") end,
      --   { desc = "Initialize Molten for Rust", silent = true }
      -- )

      -- vim.api.nvim_create_autocmd("User", {
      --   pattern = "MoltenInitPost",
      --   callback = function()
      --     -- quarto code runner mappings
      --     local r = require("quarto.runner")
      --     vim.keymap.set("n", "<localleader>rc", r.run_cell, { desc = "run cell", silent = true })
      --     vim.keymap.set("n", "<localleader>ra", r.run_above, { desc = "run cell and above", silent = true })
      --     vim.keymap.set("n", "<localleader>rb", r.run_below, { desc = "run cell and below", silent = true })
      --     vim.keymap.set("n", "<localleader>rl", r.run_line, { desc = "run line", silent = true })
      --     vim.keymap.set("n", "<localleader>rA", r.run_all, { desc = "run all cells", silent = true })
      --     vim.keymap.set(
      --       "n",
      --       "<localleader>RA",
      --       function() r.run_all(true) end,
      --       { desc = "run all cells of all languages", silent = true }
      --     )
      --
      --     -- setup some molten specific keybindings
      --     vim.keymap.set(
      --       "n",
      --       "<localleader>e",
      --       ":MoltenEvaluateOperator<CR>",
      --       { desc = "evaluate operator", silent = true }
      --     )
      --     vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>", { desc = "re-eval cell", silent = true })
      --     vim.keymap.set(
      --       "v",
      --       "<localleader>r",
      --       ":<C-u>MoltenEvaluateVisual<CR>gv",
      --       { desc = "execute visual selection", silent = true }
      --     )
      --     vim.keymap.set(
      --       "n",
      --       "<localleader>os",
      --       ":noautocmd MoltenEnterOutput<CR>",
      --       { desc = "open output window", silent = true }
      --     )
      --     vim.keymap.set(
      --       "n",
      --       "<localleader>oh",
      --       ":MoltenHideOutput<CR>",
      --       { desc = "close output window", silent = true }
      --     )
      --     vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>", { desc = "delete Molten cell", silent = true })
      --     local open = false
      --     vim.keymap.set("n", "<localleader>ot", function()
      --       open = not open
      --       vim.fn.MoltenUpdateOption("auto_open_output", open)
      --     end)
      --
      --     -- if we're in a python file, change the configuration a little
      --     if vim.bo.filetype == "python" then
      --       vim.fn.MoltenUpdateOption("molten_virt_lines_off_by_1", false)
      --       vim.fn.MoltenUpdateOption("molten_virt_text_output", false)
      --     end
      --   end,
      -- })
      --
      -- change the configuration when editing a python file
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*.py",
        callback = function(e)
          if string.match(e.file, ".otter.") then
            return
          end
          if require("molten.status").initialized() == "Molten" then
            vim.fn.MoltenUpdateOption("molten_virt_lines_off_by_1", false)
            vim.fn.MoltenUpdateOption("molten_virt_text_output", false)
          end
        end,
      })

      -- Undo those config changes when we go back to a markdown or quarto file
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = { "*.qmd", "*.md", "*.ipynb" },
        callback = function()
          if require("molten.status").initialized() == "Molten" then
            vim.fn.MoltenUpdateOption("molten_virt_lines_off_by_1", true)
            vim.fn.MoltenUpdateOption("molten_virt_text_output", true)
          end
        end,
      })

      local imb = function(e)
        vim.schedule(function()
          local kernels = vim.fn.MoltenAvailableKernels()

          local try_kernel_name = function()
            local metadata = vim.json.decode(io.open(e.file, "r"):read("a"))["metadata"]
            return metadata.kernelspec.name
          end
          local ok, kernel_name = pcall(try_kernel_name)

          if not ok or not vim.tbl_contains(kernels, kernel_name) then
            kernel_name = nil
            local venv = os.getenv("VIRTUAL_ENV")
            if venv ~= nil then
              kernel_name = string.match(venv, "/.+/(.+)")
            end
          end

          if kernel_name ~= nil and vim.tbl_contains(kernels, kernel_name) then
            vim.cmd(("MoltenInit %s"):format(kernel_name))
          end
          vim.cmd("MoltenImportOutput")
        end)
      end

      -- we have to do this as well so that we catch files opened like nvim ./hi.ipynb
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = { "*.ipynb" },
        callback = function(e)
          if vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
            imb(e)
          end
        end,
      })

      -- automatically import output chunks from a jupyter notebook
      vim.api.nvim_create_autocmd("BufAdd", {
        pattern = { "*.ipynb" },
        callback = imb,
      })

      -- automatically export output chunks to a jupyter notebook
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = { "*.ipynb" },
        callback = function()
          if require("molten.status").initialized() == "Molten" then
            vim.cmd("MoltenExportOutput!")
          end
        end,
      })
    end,
  },
  {
    "GCBallesteros/jupytext.nvim",
    event = "VeryLazy",
    -- ft = { "ipynb" },
    opts = {
      style = "markdown",
      output_extension = "md",
      force_ft = "markdown",
    },
  },
  { "jmbuhr/otter.nvim", ft = { "markdown", "quarto", "norg" } },
  {
    "3rd/image.nvim",
    ft = { "markdown", "norg" },
    enabled = false,
    opts = {
      backend = "kitty",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = false,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "quarto" },
        },
      },
      max_width = 100,
      max_height = 8,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
      editor_only_render_when_focused = true, -- auto show/hide images when the editor gains/looses focus
      window_overlap_clear_ft_ignore = { "blink", "fidget", "" },
    },
  },
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
      "nvimtools/hydra.nvim",
      "jmbuhr/otter.nvim",
    },
    ft = { "quarto", "markdown", "norg", "ipynb" },
    opts = {
      lspFeatures = {
        languages = { "python", "rust", "lua" },
        chunks = "all", -- 'curly' or 'all'
        diagnostics = {
          enabled = true,
          triggers = { "BufWritePost" },
        },
        completion = {
          enabled = true,
        },
      },
      keymap = {
        hover = "H",
        definition = "gd",
        rename = "<leader>rn",
        references = "gr",
        format = "<leader>gf",
      },
      codeRunner = {
        enabled = true,
        ft_runners = {
          bash = "slime",
        },
        default_method = "molten",
      },
    },
    specs = {
      {
        "astrocore",
        ---@type AstroCoreOpts
        opts = {
          mappings = {
            n = {
              ["<LocalLeader>qc"] = {
                function() require("quarto.runner").run_cell() end,
                desc = "Run cell",
              },
              ["<LocalLeader>qa"] = {
                function() require("quarto.runner").run_above() end,
                desc = "Run cell and above",
              },
              ["<LocalLeader>qb"] = {
                function() require("quarto.runner").run_below() end,
                desc = "Run cell and below",
              },
              ["<LocalLeader>ql"] = {
                function() require("quarto.runner").run_line() end,
                desc = "Run line",
              },
              ["<LocalLeader>qA"] = {
                function() require("quarto.runner").run_all() end,
                desc = "Run all cells",
              },
              ["<LocalLeader>qR"] = {
                function() require("quarto.runner").run_all(true) end,
                desc = "Run all cells of all languages",
              },
              ["<LocalLeader>qn"] = {
                "i`<c-j>",
                desc = "New cell below",
              },
              ["<LocalLeader>qs"] = {
                "i```\r\r```{}<left>",
                desc = "Split cell",
              },
              ["<LocalLeader>qp"] = {
                function() require("quarto").quartoPreview {} end,
                desc = "Preview quarto document",
              },
            },
            v = {
              ["<LocalLeader>qr"] = {
                function() require("quarto.runner").run_range() end,
                desc = "Run range",
              },
            },
          },
        },
      },
      -- for more keybinds that I would use in a quarto document, see the configuration for molten
      -- require("benlubas.hydra.notebook")
    },
  },
}
