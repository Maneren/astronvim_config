---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 },
      autopairs = true,
      cmp = true,
      diagnostics_mode = 3,
      highlighturl = true,
      notifications = true,
    },
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    options = {
      opt = {
        relativenumber = true,
        number = true,
        spell = false,
        signcolumn = "auto",
        wrap = false,
        guifont = { "Iosevka", ":h13" },
      },
      g = {
        neovide_cursor_vfx_mode = "pixiedust",
        neovide_remember_window_size = true,
        neovide_scroll_animation_length = 0,
        neovide_hide_mouse_when_typing = true,
        neovide_cursor_animate_command_line = false,
      },
    },
    mappings = {
      n = {
        -- make copy-pasting use the system clipboard by default
        p = { '"+p' },
        P = { '"+P' },
        ["<Leader>C"] = { name = "Crates" },
        ["<Leader>T"] = { name = "Tests" },
        ["<Leader>m"] = { name = "Markdown" },
        ["<Leader>lr"] = { function() require("lspactions").rename() end, desc = "Rename symbol" },
        ["<Leader>la"] = { function() vim.lsp.buf.code_action() end, desc = "Code actions" },
        ["<Leader>ld"] = { function() vim.lsp.buf.declaration() end, desc = "Show declaration" },
        ["<Leader>lm"] = { function() vim.lsp.buf.implementation() end, desc = "Show implementations" },
        ["<Leader>Ct"] = { function() require("crates").toggle() end, desc = "Toggle extra crates.io information" },
        ["<Leader>Cr"] = { function() require("crates").reload() end, desc = "Reload information from crates.io" },
        ["<Leader>CU"] = { function() require("crates").upgrade_crate() end, desc = "Upgrade a crate" },
        ["<Leader>CA"] = { function() require("crates").upgrade_all_crates() end, desc = "Upgrade all crates" },
        ["<Leader>Tr"] = { function() require("neotest").run.run() end, desc = "Run closest test" },
        ["<Leader>Tf"] = { function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run current file" },
        ["<Leader>Td"] = {
          function() require("neotest").run.run { strategy = "dap", suite = false } end,
          desc = "Debug closest test",
        },
        ["<Leader>Tc"] = { function() require("neotest").summary.toggle() end, desc = "Toggle summary window" },
        ["<Leader>mp"] = { function() vim.cmd("MarkdownPreview") end, desc = "Open preview" },
        ["<Leader>mP"] = { function() vim.cmd("MarkdownPreviewStop") end, desc = "Close preview" },
        ["<Leader>mf"] = { function() require("tablemd").format() end, desc = "Format table" },
        ["<Leader>mc"] = { function() require("tablemd").insertColumn(false) end, desc = "Insert column" },
        ["<Leader>md"] = { function() require("tablemd").deleteColumn() end, desc = "Delete column" },
        ["<Leader>mr"] = { function() require("tablemd").insertRow(false) end, desc = "Insert row above" },
        ["<Leader>mR"] = { function() require("tablemd").insertRow(true) end, desc = "Insert row below" },
        ["<Leader>mj"] = { function() require("tablemd").alignColumn("left") end, desc = "Align column left" },
        ["<Leader>mk"] = { function() require("tablemd").alignColumn("center") end, desc = "Align column center" },
        ["<Leader>ml"] = { function() require("tablemd").alignColumn("right") end, desc = "Align column right" },
      },
      v = {
        -- Also in visual mode
        x = { '"+x' },
        y = { '"+y' },
        p = { '"_d"+p' },
        P = { '"_d"+P' },
        ["<Leader>C"] = { name = "Crates" },
        ["<Leader>lr"] = { function() require("lspactions").rename() end, desc = "Rename symbol" },
        ["<Leader>CU"] = { function() require("crates").upgrade_crates() end, desc = "Upgrade selected crates" },
        ["<Leader>sw"] = {
          function()
            vim.cmd("startnormal")
            require("spectre").open_visual()
          end,
        },
      },
      i = {
        ["<S-CR>"] = {
          function() return vim.fn["codeium#Accept"]() end,
          desc = "Accept codeium suggestion",
          expr = true,
        },
      },
    },
  },
}
