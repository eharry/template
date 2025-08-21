---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    opts = {
      options = {
        opt = { -- vim.opt.<key>
          relativenumber = false, -- sets vim.opt.relativenumber
          wrap = true, -- sets vim.opt.wrap
          signcolumn = "yes", -- sets vim.opt.signcolumn to yes
          mouse = "",
        },
      },
      mappings = {
        n = {
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

          -- quickfix 
          ["]q"] = { "<cmd>cnext<cr>", desc = "cnext" },
          ["[q"] = { "<cmd>cprev<cr>", desc = "cnext" },

          --toggleterm
          ["<leader>tx"] = {"<cmd>exe v:count1 . 'ToggleTerm'<CR>", desc="open term"},
          ["<leader>tsc"] = {"<cmd>ToggleTermSendCurrentLine<CR>", desc="send current line"},
          ["<leader>tsv"] = {"<cmd>ToggleTermSendVisualLines<CR>", desc="send current line"},
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
      formatting = {
        format_on_save = {
          enabled = false, -- enable or disable format on save globally
        },
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
    "Mr-LLLLL/interestingwords.nvim",
    config = function()
      require("interestingwords").setup {
        colors = { "#aeee00", "#ff0000", "#b88823", "#ffa724", "#ff2c4b", "#347678", "#169003", "#872097", "#719087" },
        search_count = true,
        navigation = true,
        scroll_center = true,
        search_key = "<leader>cm",
        cancel_search_key = "<leader>cM",
        color_key = "<leader>ck",
        cancel_color_key = "<leader>cK",
      }
    end,
  },
  -- {
  --   "linrongbin16/gentags.nvim",
  --   config = function()
  --     require('gentags').setup()
  --   end,
  -- },
  {
    "kurotych/ccryptor.nvim",
    config = function()
      require("ccryptor").setup {
        dir_path = '/Users/eharry/key/'
      }
    end,
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "miikanissi/modus-themes.nvim", priority = 1000 },
  {
    "zootedb0t/citruszest.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown', 'quarto' },
  },
}
