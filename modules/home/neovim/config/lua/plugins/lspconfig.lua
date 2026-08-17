local lspconfig = require("lspconfig")
local blink = require("blink.cmp")

-- 1. Hook blink.cmp capabilities
-- If you have custom capabilities to pass, you can pass them as an argument: blink.get_lsp_capabilities(my_custom_caps)
local capabilities = blink.get_lsp_capabilities()

-- 2. Common on_attach function
local on_attach = function(client, bufnr)
  local map = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
  end

  local tb = require("telescope.builtin")

  -- ==========================================
  -- Code Navigation (Telescope)
  -- ==========================================
  map("gd", tb.lsp_definitions, "Goto Definition (Telescope)")
  map("gD", vim.lsp.buf.declaration, "Goto Declaration")
  map("gi", tb.lsp_implementations, "Goto Implementation (Telescope)")
  map("gt", tb.lsp_type_definitions, "Type Definition (Telescope)")
  map("gr", tb.lsp_references, "References (Telescope)")
  map("<leader>ss", tb.lsp_document_symbols, "Document Symbols (Telescope)")
  map("<leader>sS", tb.lsp_workspace_symbols, "Workspace Symbols (Telescope)")

  -- ==========================================
  -- Code Actions & Standard LSP Helpers
  -- ==========================================
  map("K", vim.lsp.buf.hover, "Hover Documentation")
  map("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
  map("<leader>ca", vim.lsp.buf.code_action, "Code Action")

  -- Inlay Hints Toggle (Neovim 0.10+)
  if client.supports_method("textDocument/inlayHint") then
    map("<leader>th", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
    end, "Toggle Inlay Hints")
  end
end

--------------------------------------------------
-- Lua LSP (lua_ls)
--------------------------------------------------
lspconfig.lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim", "oxwm" },
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
        },
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

--------------------------------------------------
-- Nix LSP (nil_ls)
--------------------------------------------------
lspconfig.nil_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["nil"] = {
      formatting = {
        command = { "nixpkgs-fmt" },
      },
    },
  },
})

--------------------------------------------------
-- JavaScript / TypeScript LSP (vtsls)
--------------------------------------------------
lspconfig.vtsls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    typescript = {
      inlayHints = {
        parameterNames = { enabled = "literals" },
        variableTypes = { enabled = true },
      },
      suggest = {
        completeFunctionCalls = true,
      },
    },
    javascript = {
      inlayHints = {
        parameterNames = { enabled = "literals" },
        variableTypes = { enabled = true },
      },
    },
  },
})
