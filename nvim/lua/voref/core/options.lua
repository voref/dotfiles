-- Neovim Options

-- Appearance / UI
vim.opt.termguicolors = true -- real 24-bit colors instead of a degraded 256-color palette
vim.opt.laststatus = 3 -- one statusline for the whole window, not one per split
vim.opt.showmode = false -- redundant, lualine already shows the mode
vim.opt.ruler = false -- redundant, lualine already shows line:col
vim.opt.smoothscroll = true -- smooth scrolling on wrapped lines
vim.opt.splitkeep = "screen" -- keep the visible screen content stable when opening/closing splits

-- Undo
vim.opt.undofile = true -- persist undo history to disk across restarts

-- Folding (treesitter-based)
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99 -- start with everything unfolded

-- Line numbers
vim.opt.relativenumber = true -- Relative number from cursor
vim.opt.number = true -- Show line number
vim.opt.cursorline = true -- Highlight cursor line

-- Indentation
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.autoindent = true -- Maintain indentation level
vim.opt.tabstop = 2 -- Number of spaces per tab
vim.opt.softtabstop = 2 -- Spaces per tab while editing
vim.opt.shiftwidth = 2 -- Indentation width for auto-indent

-- Search
vim.opt.ignorecase = true -- ignore case in searches
vim.opt.smartcase = true -- Case sensitive if uppercase is used

-- Clipboard
vim.opt.clipboard = "unnamedplus" -- Sync default register with system clipboard

-- Diagnostics (LSP + nvim-lint)
vim.diagnostic.config({ virtual_text = true }) -- show the message inline, not just an underline

