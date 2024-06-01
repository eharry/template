---@type LazySpec
return {
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  { "max397574/better-escape.nvim", enabled = false },

  -- disable dap
  { "mfussenegger/nvim-dap", enabled = false },
  { "rcarriga/cmp-dap", enabled = false },
  { "rcarriga/nvim-dap-ui", enabled = false },
  { "jay-babu/mason-nvim-dap.nvim", enabled = false },

  { "mrjones2014/smart-splits.nvim", enabled = false },

  -- disable snip
  { "L3MON4D3/LuaSnip", enabled = false },
  { "rafamadriz/friendly-snippets", enabled = false },
  { "saadparwaiz1/cmp_luasnip", enabled = false },

  {
    "AstroNvim/astrocore",
    opts = {
      options = {
        opt = { -- vim.opt.<key>
          relativenumber = false, -- sets vim.opt.relativenumber
          wrap = true, -- sets vim.opt.wrap
          mouse = "",
        },
      },
      mappings = {
        n = {
          -- glance
          ["gD"] = { "<cmd>Glance definitions<CR>", desc = "Glance definitions" },
          ["gR"] = { "<cmd>Glance references<CR>", desc = "Glance references" },
          ["gY"] = { "<cmd>Glance type_definitions<CR>", desc = "Glance type_definitions" },
          ["gM"] = { "<cmd>Glance implementations<CR>", desc = "Glance implementations" },

          -- leap
          ["s"] = {
            function()
              require("leap").leap {
                target_windows = require("leap.user").get_focusable_windows(),
              }
            end,
            desc = "leap all window",
          },
          ["gs"] = false,
          ["S"] = false,
        },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    opts = {
      features = {
        autoformat = false, -- enable or disable auto formatting on start
      },
    },
    formatting = {
      format_on_save = {
        enabled = false, -- enable or disable format on save globally
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- list like portions of a table cannot be merged naturally and require the user to merge it manually
      -- check to make sure the key exists
      if not opts.ensure_installed then opts.ensure_installed = {} end
      vim.list_extend(opts.ensure_installed, {
        "lua",
        "vim",
        "cpp",
        "java",
        "python",
        -- add more arguments for adding more treesitter parsers
      })
    end,
  },
  {
    "tomasky/bookmarks.nvim",
    -- after = "telescope.nvim",
    event = "VimEnter",
    config = function()
      require("bookmarks").setup {
        -- sign_priority = 8,  --set bookmark sign priority to cover other sign
        save_file = vim.fn.expand "$HOME/.bookmarks", -- bookmarks save file path
        keywords = {
          ["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
          ["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
          ["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
          ["@n"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
        },
        on_attach = function(bufnr)
          local bm = require "bookmarks"
          local map = vim.keymap.set
          map("n", "mm", bm.bookmark_toggle) -- add or remove bookmark at current line
          map("n", "mi", bm.bookmark_ann) -- add or edit mark annotation at current line
          map("n", "mc", bm.bookmark_clean) -- clean all marks in local buffer
          map("n", "mn", bm.bookmark_next) -- jump to next mark in local buffer
          map("n", "mp", bm.bookmark_prev) -- jump to previous mark in local buffer
          map("n", "ml", bm.bookmark_list) -- show marked file list in quickfix window
          map("n", "mx", bm.bookmark_clear_all) -- removes all bookmarks
        end,
      }
    end,
  },
  {
    "dnlhc/glance.nvim",
    config = function()
      local glance = require "glance"
      local actions = glance.actions
      glance.setup {
        height = 18, -- Height of the window
        zindex = 45,

        -- By default glance will open preview "embedded" within your active window
        -- when `detached` is enabled, glance will render above all existing windows
        -- and won't be restiricted by the width of your active window
        -- detached = true,

        -- Or use a function to enable `detached` only when the active window is too small
        -- (default behavior)
        detached = function(winid) return vim.api.nvim_win_get_width(winid) < 100 end,

        preview_win_opts = { -- Configure preview window options
          cursorline = true,
          number = true,
          wrap = true,
        },
        border = {
          enable = false, -- Show window borders. Only horizontal borders allowed
          top_char = "―",
          bottom_char = "―",
        },
        list = {
          position = "right", -- Position of the list window 'left'|'right'
          width = 0.33, -- 33% width relative to the active window, min 0.1, max 0.5
        },
        theme = { -- This feature might not work properly in nvim-0.7.2
          enable = true, -- Will generate colors for the plugin based on your current colorscheme
          mode = "auto", -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
        },
        mappings = {
          -- glonce
          list = {
            ["j"] = actions.next, -- Bring the cursor to the next item in the list
            ["k"] = actions.previous, -- Bring the cursor to the previous item in the list
            ["<Down>"] = actions.next,
            ["<Up>"] = actions.previous,
            ["<Tab>"] = actions.next_location, -- Bring the cursor to the next location skipping groups in the list
            ["<S-Tab>"] = actions.previous_location, -- Bring the cursor to the previous location skipping groups in the list
            ["<C-u>"] = actions.preview_scroll_win(5),
            ["<C-d>"] = actions.preview_scroll_win(-5),
            ["v"] = actions.jump_vsplit,
            ["s"] = actions.jump_split,
            ["t"] = actions.jump_tab,
            ["<CR>"] = actions.jump,
            ["o"] = actions.jump,
            ["l"] = actions.open_fold,
            ["h"] = actions.close_fold,
            ["<leader>l"] = actions.enter_win "preview", -- Focus preview window
            ["q"] = actions.close,
            ["Q"] = actions.close,
            ["<Esc>"] = actions.close,
            ["<C-q>"] = actions.quickfix,
            -- ['<Esc>'] = false -- disable a mapping
          },
          preview = {
            ["Q"] = actions.close,
            ["<Tab>"] = actions.next_location,
            ["<S-Tab>"] = actions.previous_location,
            ["<leader>l"] = actions.enter_win "list", -- Focus list window
          },
        },
        hooks = {
          before_open = function(results, open, jump, method)
            local uri = vim.uri_from_bufnr(0)
            if #results == 1 then
              local target_uri = results[1].uri or results[1].targetUri

              if target_uri == uri then
                jump(results[1])
              else
                open(results)
              end
            else
              open(results)
            end
          end,
        },
        folds = {
          fold_closed = "",
          fold_open = "",
          folded = true, -- Automatically fold list on startup
        },
        indent_lines = {
          enable = true,
          icon = " │",
        },
        winbar = {
          enable = true, -- Available strating from nvim-0.8+
        },
        use_trouble_qf = false, -- Quickfix action will open trouble.nvim instead of built-in quickfix list window
      }
    end,
  },
}
