return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, -- Ensures it loads before other UI plugins
  config = function()
    require("catppuccin").setup({
      flavour = "macchiato", -- Options: latte, frappe, macchiato, mocha
      transparent_background = true,
      term_colors = true,
      integrations = {
        blink = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        -- For more integrations, see: https://github.com/catppuccin/nvim#integrations
      },
    })

    -- Set the colorscheme
    vim.cmd.colorscheme("catppuccin")
  end,
}
