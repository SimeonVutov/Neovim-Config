vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true 

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 9 
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.splitright = true
vim.opt.splitbelow = true

-- disable netrw
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- For perfomance
vim.opt.ttyfast = true
vim.opt.redrawtime = 1000
-- vim.opt.lazyredraw = true
vim.opt.incsearch = true

vim.opt.guicursor = {
  "n-v-c:block",     -- block cursor in normal/visual/command modes
  "i-ci:ver25",      -- vertical beam in insert
  "r-cr:hor20"       -- optional: horizontal cursor in replace modes
}
