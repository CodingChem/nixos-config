return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    -- Recommended settings from nvim-tree
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    local api = require("nvim-tree.api")

    local function my_on_attach(bufnr)
      -- Load default keymaps first
      api.config.mappings.default_on_attach(bufnr)

      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- Custom h / l navigation
      vim.keymap.set("n", "l", api.node.open.edit, opts("Open or Expand"))
      vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
    end

    require("nvim-tree").setup({
      on_attach = my_on_attach,
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 30,
        relativenumber = true,
      },
      renderer = {
        group_empty = true,
        icons = {
          show = {
            git = true,
            folder = true,
            file = true,
            folder_arrow = true,
          },
        },
      },
      filters = {
        dotfiles = false,
      },
    })

    -- Handy keymap to toggle the tree
    vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
  end,
}
