return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  -- Remove build = ":TSUpdate" to prevent imperative compiler calls
  lazy = false,
  priority = 1000,
  config = function()
    local status_ok, ts_configs = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
      return
    end

    ts_configs.setup({
      -- Keep empty since Nix provides the parsers
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
}
