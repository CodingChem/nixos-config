-- Tab / Space Settings
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.shiftwidth = 2    -- Size of an indent
vim.opt.tabstop = 2       -- Number of spaces tabs count for
vim.opt.softtabstop = 2   -- Insert 2 spaces for a tab
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.wrap = false

-- UI Polish
vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers (great for jumping)
vim.opt.cursorline = true     -- Highlight the current line
vim.opt.termguicolors = true  -- True color support
vim.opt.signcolumn = "yes"    -- Always show the sign column (prevents "flicker")
