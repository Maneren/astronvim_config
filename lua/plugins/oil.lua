return {
  "stevearc/oil.nvim",
  cmd = "Oil",
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>;"] = { function() require("oil").open() end, desc = "Open folder in Oil" },
          },
        },
        autocmds = {
          oil_settings = {
            {
              event = "FileType",
              desc = "Disable view saving for oil buffers",
              pattern = "oil",
              callback = function(args) vim.b[args.buf].view_activated = false end,
            },
            {
              event = "User",
              pattern = "OilActionsPost",
              desc = "Close buffers when files are deleted in Oil",
              callback = function(args)
                if args.data.err then
                  return
                end
                for _, action in ipairs(args.data.actions) do
                  if action.type == "delete" then
                    local _, path = require("oil.util").parse_url(action.url)
                    local bufnr = vim.fn.bufnr(path)
                    if bufnr ~= -1 then
                      require("astrocore.buffer").wipe(bufnr, true)
                    end
                  end
                end
              end,
            },
          },
        },
      },
    },
    {
      "rebelot/heirline.nvim",
      optional = true,
      dependencies = { "AstroNvim/astroui", opts = { status = { winbar = { enabled = { filetype = { "^oil$" } } } } } },
      opts = function(_, opts)
        if opts.winbar then
          local status = require("astroui.status")
          table.insert(opts.winbar, 1, {
            condition = function(self) return status.condition.buffer_matches({ filetype = "^oil$" }, self.bufnr) end,
            status.component.separated_path {
              padding = { left = 2 },
              max_depth = false,
              suffix = false,
              path_func = function(self) return require("oil").get_current_dir(self.bufnr) end,
            },
          })
        end
      end,
    },
  },
  opts = function()
    local get_icon = require("astroui").get_icon
    local oil = require("oil")

    -- https://github.com/stevearc/oil.nvim/blob/master/doc/recipes.md#hide-gitignored-files-and-show-git-tracked-hidden-files
    -- helper function to parse output
    local function parse_output(proc)
      local result = proc:wait()
      local ret = {}
      if result.code == 0 then
        for line in vim.gsplit(result.stdout, "\n", { plain = true, trimempty = true }) do
          -- Remove trailing slash
          line = line:gsub("/$", "")
          ret[line] = true
        end
      end
      return ret
    end

    -- build git status cache
    local function create_git_status()
      return setmetatable({}, {
        __index = function(self, key)
          local ignore_proc = vim.system(
            { "git", "ls-files", "--ignored", "--exclude-standard", "--others", "--directory" },
            {
              cwd = key,
              text = true,
            }
          )
          local tracked_proc = vim.system({ "git", "ls-tree", "HEAD", "--name-only" }, {
            cwd = key,
            text = true,
          })
          local ret = {
            ignored = parse_output(ignore_proc),
            tracked = parse_output(tracked_proc),
          }

          rawset(self, key, ret)
          return ret
        end,
      })
    end
    local git_status = create_git_status()

    -- Clear git status cache on refresh
    local refresh = require("oil.actions").refresh
    local orig_refresh = refresh.callback
    refresh.callback = function(...)
      git_status = create_git_status()
      orig_refresh(...)
    end

    local detail = false
    return {
      delete_to_trash = true,
      watch_for_changes = true,
      columns = {
        {
          "icon",
          default_file = get_icon("DefaultFile"),
          directory = get_icon("FolderClosed"),
        },
      },
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-x>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
        ["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
        ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["<BS>"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory", mode = "n" },
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["gd"] = {
          desc = "Toggle file detail view",
          callback = function()
            detail = not detail
            if detail then
              oil.set_columns { "icon", "permissions", "size", "mtime" }
            else
              oil.set_columns { "icon" }
            end
          end,
        },
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
      },
      use_default_keymaps = false,
      view_options = {
        is_hidden_file = function(name, bufnr)
          local dir = oil.get_current_dir(bufnr)
          local is_dotfile = vim.startswith(name, ".") and name ~= ".."
          -- if not a local directory (e.g. for ssh connections), just hide dotfiles
          if not dir then
            return is_dotfile
          end

          local dir_status = git_status[dir]
          -- mark as hidden either ignored files or untracked dotfiles
          return (is_dotfile and not dir_status.tracked[name]) or dir_status.ignored[name]
        end,
      },
    }
  end,
}
