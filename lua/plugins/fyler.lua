--- File manager
--- https://github.com/A7Lavinraj/fyler.nvim

--- @type LazySpec
return {
  "A7Lavinraj/fyler.nvim",
  event = "VeryLazy",
  cmd = { "Fyler" },
  dependencies = { "nvim-mini/mini.icons" },
  version = "*",
  ---@param opts FylerOpts
  opts = function(_, opts)
    local astro, get_icon = require("astrocore"), require("astroui").get_icon

    ---@param finder Finder
    local function copy_selector(finder)
      ---@type Entry
      local current = finder:cursor_node_entry()
      local filepath = current.path
      local filename = current.name
      local modify = vim.fn.fnamemodify

      local vals = {
        ["BASENAME"] = modify(filename, ":r"),
        ["EXTENSION"] = modify(filename, ":e"),
        ["FILENAME"] = filename,
        ["PATH (CWD)"] = modify(filepath, ":."),
        ["PATH (HOME)"] = modify(filepath, ":~"),
        ["PATH"] = filepath,
        ["URI"] = vim.uri_from_fname(filepath),
      }

      local options = vim.tbl_filter(function(val) return vals[val] ~= "" end, vim.tbl_keys(vals))
      if vim.tbl_isempty(options) then
        astro.notify("No values to copy", vim.log.levels.WARN)
        return
      end
      table.sort(options)
      vim.ui.select(options, {
        prompt = "Choose to copy to clipboard:",
        format_item = function(item) return ("%s: %s"):format(item, vals[item]) end,
      }, function(choice)
        local result = vals[choice]
        if result then
          astro.notify(("Copied: `%s`"):format(result))
          vim.fn.setreg("+", result)
        end
      end)
    end

    ---@param finder Finder
    local function system_open(finder) vim.ui.open(finder:cursor_node_entry().path) end

    return vim.tbl_deep_extend("force", opts, {
      -- File operations
      hooks = {
        ---@param path string
        on_delete = function(path) require("astrolsp.file_operations").didDeleteFiles { path } end,
        ---@param src_path string
        ---@param dst_path string
        on_rename = function(src_path, dst_path)
          require("astrolsp.file_operations").didRenameFiles {
            from = src_path,
            to = dst_path,
          }
        end,
        -- function(hl_groups, palette) end
        on_highlight = nil,
      },
      views = {
        finder = {
          -- Close explorer when file is selected
          close_on_select = true,
          -- Auto-confirm simple file operations
          confirm_simple = false,
          -- Replace netrw as default explorer
          default_explorer = false,
          -- Move deleted files/directories to the system trash
          delete_to_trash = true,
          -- Git status
          git_status = {
            enabled = true,
            symbols = {
              Untracked = get_icon("GitUntracked"),
              Added = get_icon("GitAdd"),
              Modified = get_icon("GitChange"),
              Deleted = get_icon("GitDelete"),
              Renamed = get_icon("GitRename"),
              Copied = get_icon("GitCopy"),
              Conflict = get_icon("GitConflict"),
              Ignored = get_icon("GitIgnored"),
            },
          },
          -- Icons for directory states
          icon = {
            directory_collapsed = get_icon("FolderClosed"),
            directory_empty = get_icon("FolderEmpty"),
            directory_expanded = get_icon("FolderOpen"),
          },
          -- Indent markers
          indentscope = {
            enabled = true,
            group = "FylerIndentMarker",
            marker = "▏",
          },
          -- Key mappings
          mappings = {
            ["q"] = "CloseView",
            ["<CR>"] = "Select",
            ["<C-t>"] = "SelectTab",
            ["|"] = "SelectVSplit",
            ["-"] = "SelectSplit",
            ["<BS>"] = "GotoParent",
            ["="] = "GotoCwd",
            ["."] = "GotoNode",
            ["#"] = "CollapseAll",
            ["O"] = system_open,
            ["<S-CR>"] = system_open,
            ["Y"] = copy_selector,
          },
          -- Current file tracking
          follow_current_file = true,
          -- File system watching(includes git status)
          watcher = {
            enabled = true,
          },
        },
      },
    })
  end,
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = assert(opts.mappings)
        maps.n["<Leader>E"] = { function() require("fyler").toggle { kind = "split_left_most" } end, desc = "Fyler" }
      end,
    },
  },
}
