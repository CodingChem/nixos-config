local lspconfig = require('lspconfig')

-- setup lua ls
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
})

-- Nix ls
lspconfig.nil_ls.setup({})
