return {
  -- 1. trouble.nvim: Pretty list for diagnostics, references, quickfix, and TODOs
  {
    "folke/trouble.nvim",
    opts = {}, -- Uses default options
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xt",
        "<cmd>Trouble todo toggle<cr>",
        desc = "Todo List (Trouble)",
      },
      {
        "<leader>xT",
        "<cmd>Trouble todo toggle filter = {tag = {TODO, FIX, FIXME}}<cr>",
        desc = "Todo/Fix/Fixme (Trouble)",
      },
    },
  },

  -- 2. todo-comments.nvim: Highlight, search, and list TODO/FIXME/HACK in codebase
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      -- Next/Prev Todo Jumps
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next todo comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous todo comment",
      },
      -- Synergy 1: Search Todo comments directly in Telescope
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find TODOs (Telescope)" },
      {
        "<leader>fT",
        "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",
        desc = "Find TODO/FIX/FIXME (Telescope)",
      },
    },
  },

  -- 3. Synergy 2: Extend Telescope mappings to send pickers directly to Trouble
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "folke/trouble.nvim" },
    opts = function(_, opts)
      local open_with_trouble = require("trouble.sources.telescope").open
      local add_to_trouble = require("trouble.sources.telescope").add

      opts.defaults = opts.defaults or {}
      opts.defaults.mappings = opts.defaults.mappings or { i = {}, n = {} }

      -- Pressing <C-t> in ANY Telescope picker sends results straight to Trouble
      -- Pressing <A-t> appends current Telescope results to an existing Trouble list
      opts.defaults.mappings.i["<C-t>"] = open_with_trouble
      opts.defaults.mappings.i["<A-t>"] = add_to_trouble
      opts.defaults.mappings.n["<C-t>"] = open_with_trouble
      opts.defaults.mappings.n["<A-t>"] = add_to_trouble
    end,
  },
}
