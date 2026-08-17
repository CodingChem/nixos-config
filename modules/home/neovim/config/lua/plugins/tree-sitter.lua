return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  lazy = false,
  priority = 1000,
  config = function()
    local status_ok, ts_configs = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
      return
    end

    ts_configs.setup({
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
      auto_install = true,
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
