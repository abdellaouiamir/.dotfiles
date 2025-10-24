local api = vim.api

-- don't auto comment new line
api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

-- wrap words "softly" (no carriage return) in mail buffer
api.nvim_create_autocmd("Filetype", {
	pattern = "mail",
	callback = function()
		vim.opt.textwidth = 0
		vim.opt.wrapmargin = 0
		vim.opt.wrap = true
		vim.opt.linebreak = true
		vim.opt.columns = 80
		vim.opt.colorcolumn = "80"
	end,
})

-- Highlight on yank
api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- go to last loc when opening a buffer
-- this mean that when you open a file, you will be at the last position
api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- show cursor line only in active window
local cursorGrp = api.nvim_create_augroup("CursorLine", { clear = true })
api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
	pattern = "*",
	command = "set cursorline",
	group = cursorGrp,
})
api.nvim_create_autocmd(
	{ "InsertEnter", "WinLeave" },
	{ pattern = "*", command = "set nocursorline", group = cursorGrp }
)

-- Enable spell checking for certain file types
api.nvim_create_autocmd(
	{ "BufRead", "BufNewFile" },
	-- { pattern = { "*.txt", "*.md", "*.tex" }, command = [[setlocal spell<cr> setlocal spelllang=en,de<cr>]] }
	{
		pattern = { "*.txt", "*.md", "*.tex" },
		callback = function()
			vim.opt.spell = true
			vim.opt.spelllang = "en"
		end,
	}
)
-- resize neovim split when terminal is resized
--[[
vim.api.nvim_command("autocmd VimResized * wincmd =")
]]

-- fix terraform and hcl comment string
--[[
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("FixTerraformCommentString", { clear = true }),
  callback = function(ev)
    vim.bo[ev.buf].commentstring = "# %s"
  end,
  pattern = { "terraform", "hcl" },
})
]]

api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		-- Core navigation
		map("gd", vim.lsp.buf.definition, "Goto Definition")
		map("gD", vim.lsp.buf.declaration, "Goto Declaration")
		map("<leader>D", vim.lsp.buf.type_definition, "Go to type definition")
		map("gi", vim.lsp.buf.implementation, "Goto Implementation")
		map("gr", vim.lsp.buf.references, "Goto References")
		map("<leader>v", "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>", "Goto Definition in Vertical Split")
		-- Documentation
		map("K", vim.lsp.buf.hover, "Hover Documentation")
		map("<leader>ls", vim.lsp.buf.signature_help, "Display Signature Information")
		-- Refactoring / Editing
		map("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
		map("<leader>ff", vim.lsp.buf.format, "Format Document")
		map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
		-- map("<leader>cl", vim.lsp.buf.range_code_action,"Range Code Actions" )
		-- working directory
		map("<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
		map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
		map("<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, "List workspace folders")
		-- Diagnostics
		map("df", vim.diagnostic.open_float, "Open Diagnostic Float")
		-- map("[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
		-- map("]d", vim.diagnostic.goto_next, "Next Diagnostic")

		--[[
    local function client_supports_method(client, method, bufnr)
      if vim.fn.has 'nvim-0.11' == 1 then
        return client:supports_method(method, bufnr)
      else
        return client.supports_method(method, { bufnr = bufnr })
      end
    end

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
        end,
      })
    end


    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
    end
    ]]
	end,
})
