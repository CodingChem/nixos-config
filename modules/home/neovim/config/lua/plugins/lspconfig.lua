return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "saghen/blink.cmp",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local blink = require("blink.cmp")

    -- 1. Hook blink.cmp capabilities globally for all LSPs
    vim.lsp.config("*", {
      capabilities = blink.get_lsp_capabilities(),
    })

    -- 2. Modern on_attach equivalent via LspAttach autocommand
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
      callback = function(event)
        local bufnr = event.buf
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        local tb = require("telescope.builtin")

        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
        end

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

        -- Inlay Hints Toggle
        if client and client.supports_method("textDocument/inlayHint") then
          map("<leader>th", function()
            local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
            vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = bufnr })
          end, "Toggle Inlay Hints")
        end
      end,
    })

    -- 3. Define Server Configurations
    vim.lsp.config["lua_ls"] = {
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
    }

    vim.lsp.config["nil_ls"] = {
      settings = {
        ["nil"] = {
          formatting = {
            command = { "nixpkgs-fmt" },
          },
        },
      },
    }

    vim.lsp.config["vtsls"] = {
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
    }

    -- 4. Enable configured servers
    vim.lsp.enable({ "lua_ls", "nil_ls", "vtsls" })
  end,
}
