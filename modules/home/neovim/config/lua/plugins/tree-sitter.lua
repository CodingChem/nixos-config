require("nvim-treesitter.configs").setup({
  -- Parsers to ensure installed for Lua, Nix, and JS/TS
  ensure_installed = {
    "lua",
    "luadoc",
    "nix",
    "javascript",
    "typescript",
    "tsx",
    "jsdoc",
    "json",
    "html",
    "css",
  },

  -- Set to false on NixOS if you manage grammar packages via Nixpkgs
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true,
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
})
