return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  priority = 1000,
  -- Dynamically resolve the Nix store path from runtimepath
  -- Prevents lazy.nvim from cloning from GitHub and shadowing Nix query files
  dir = (function()
    for _, path in ipairs(vim.opt.rtp:get()) do
      if path:match("nvim%-treesitter") and not path:match("lazy") then
        return path
      end
    end
    return nil
  end)(),
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
}
