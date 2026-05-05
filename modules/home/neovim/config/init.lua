-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Tab / Space Settings
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.shiftwidth = 2    -- Size of an indent
vim.opt.tabstop = 2       -- Number of spaces tabs count for
vim.opt.softtabstop = 2   -- Insert 2 spaces for a tab
vim.opt.smartindent = true -- Insert indents automatically

-- UI Polish
vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers (great for jumping)
vim.opt.cursorline = true     -- Highlight the current line
vim.opt.termguicolors = true  -- True color support
vim.opt.signcolumn = "yes"    -- Always show the sign column (prevents "flicker")

-- Bootstrap lazy.nvim (The Plugin Manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins from the 'lua/plugins' folder
require("lazy").setup("plugins")
