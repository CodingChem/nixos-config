-- define lua lsp
vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "oxwm" },
      },
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
        },
        checkThirdParty = false,
      },
    },
  },
})

-- define nix lsp
vim.lsp.config("nil_ls", {
  cmd = { "nil" },
  filetypes = { "nix" },
})

-- Enable servers
vim.lsp.enable("lua_ls")
vim.lsp.enable("nil_ls")
