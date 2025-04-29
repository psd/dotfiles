-- indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- backups
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- highlight searching
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

-- relative line numbering
vim.opt.nu = true
vim.opt.relativenumber = true

-- gutter
vim.opt.scrolloff = 8

-- stop LSP shaking the page
vim.opt.signcolumn = "yes"

vim.opt.isfname:append("@-@")

-- use XTerm mouse menu
vim.opt.mouse = ""
