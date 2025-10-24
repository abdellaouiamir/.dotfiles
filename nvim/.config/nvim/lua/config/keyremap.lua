-- Key mappings
vim.g.mapleader = " "

-- Normal mode mappings
vim.keymap.set("n", "<leader>c", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
vim.keymap.set("n", "G", "Gzz", { desc = "End page (centered)" })

-- Delete without yanking
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

-- Paste without yanking
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

-- Move lines up/down
vim.keymap.set("n", "<C-Down>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<C-Up>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Better J behavior
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- Yanking the system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yanking to the system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yanking current line to the system clipboard" })

-- Utility
-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc= "Give the execute permision" })

-- Source configuration for neovim
vim.keymap.set("n", "<leader>rr", function()
	vim.cmd("so")
end, { desc = "source file" })

-- the worst place in universe
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux display-popup -E ~/.local/bin/tmux-sessionizer.sh<CR>")

-- <C-j> ctrl and j -- <A-j> lalt and j
-- Quick fix list -- global for wide project like :grep find
-- :grep todo
-- :copen
-- :cclose
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- Location list -- local for result lik lsp or linter errors
-- :grep todo
-- :lopen
-- :lclose
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Quick file navigation
-- vim.keymap.set("n", "<leader>e", ":Explore<CR>", { desc = "Open file explorer" })
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer" })
-- vim.keymap.set("n", "<leader>ff", ":find ", { desc = "Find file" })

-- Better window navigation
-- vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
-- vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
-- vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
-- vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
