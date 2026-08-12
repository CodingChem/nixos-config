return {
  "mrjones2014/smart-splits.nvim",
  lazy = false,
  opts = {
    -- Automatically fallback to normal Neovim window movement 
    -- if outside multiplexer or at edge
    at_edge = "wrap",
  },
  keys = {
    -- Moving between splits
    { "<C-h>", function() require("smart-splits").move_cursor_left() end, desc = "Move cursor left" },
    { "<C-j>", function() require("smart-splits").move_cursor_down() end, desc = "Move cursor down" },
    { "<C-k>", function() require("smart-splits").move_cursor_up() end, desc = "Move cursor up" },
    { "<C-l>", function() require("smart-splits").move_cursor_right() end, desc = "Move cursor right" },
  },
}
