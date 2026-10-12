-- Disable lazy.nvim management so it never clones from GitHub
-- Nix already placed nvim-treesitter on Neovim's runtimepath
return {
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = false, -- Stops lazy from cloning or touching it
  },
  {
    -- Run our config against the Nix-installed treesitter
    "nvim-treesitter-config",
    virtual = true,
    lazy = false,
    priority = 1000,
    config = function()
      local status_ok, ts_configs = pcall(require, "nvim-treesitter.configs")
      if not status_ok then
        return
      end

      ts_configs.setup({
        ensure_installed = {},
        sync_install = false,
        auto_install = false,
        ignore_install = {},

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },
}
