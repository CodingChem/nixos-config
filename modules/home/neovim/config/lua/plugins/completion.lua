return {
  {
    'saghen/blink.cmp',
    version = '*', -- Uses the latest stable release
    opts = {
      -- 'default' for mapping similar to vscode/intellij
      -- 'super-tab' for traditional vim tab-completion
      keymap = { preset = 'default' },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },

      -- This is what you asked for: Path completion + LSP
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
    },
  }
}
