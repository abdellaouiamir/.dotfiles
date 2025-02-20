vim.opt.nu = true -- Enable line number
vim.opt.relativenumber = true -- Enable relative line number
vim.opt.cursorline = true -- Enable the cursorline to be highligh it
vim.opt.cursorlineopt = "number" -- highligh only the current line number

vim.opt.tabstop = 2                 -- Set tab width to 2 spaces
vim.opt.softtabstop = 2             -- When hitting tab in insert mode, insert 2 spaces
vim.opt.shiftwidth = 2              -- When auto-indenting, use 2 spaces
vim.opt.expandtab = true            -- Convert tabs into spaces

vim.opt.guicursor = "" -- Enable legacy vim cursor

vim.opt.smartindent = true -- Vim be smart about my indent

vim.opt.wrap = false -- Disable line wrap, when the line is longer than the current screen it wont go back to the begining

vim.opt.swapfile = false -- Disable Neovim swap file
vim.opt.backup = false -- Disable Neovim backup file
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Location where nvim save the undo changes of the file
vim.opt.undofile = true -- Persistance of undo changes when u close neovim

vim.opt.hlsearch = false -- Disable search highlight after searching
vim.opt.incsearch = true -- Enable incremental search (shows matches as you type) 

vim.opt.termguicolors = true -- Enable full 24-bit RGB color support

vim.opt.scrolloff = 8 -- Keep at least 8 lines of context above/below the cursor
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@") -- Allow filenames with '@' symbol

vim.opt.updatetime = 50

vim.opt.colorcolumn = "100" -- Show a vertical line at column 100
