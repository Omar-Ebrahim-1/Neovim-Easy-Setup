-- Line numbers
vim.opt.nu = true -- set number
vim.opt.relativenumber = true -- set relative number

-- Indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Disable line wrap
vim.opt.wrap = false

-- Disable swap, backup, and undo files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Incremental search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Colorscheme
vim.opt.termguicolors = true

-- Scrolling leaving 8 lines down
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Fast updatetime
vim.opt.updatetime = 50
