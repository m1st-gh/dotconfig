-- snacks.nvim keymaps
local Snacks = require("snacks")
local dap = require("dap")
local map = vim.keymap.set

-- Buffer helper function
local function close_buffer(force)
	local cur = vim.api.nvim_get_current_buf()
	local bufname = vim.api.nvim_buf_get_name(cur)

	-- Don't close snacks.explorer itself
	if bufname:match("snacks://explorer") then
		return
	end

	-- Get all listed buffers except the current one
	local listed = vim.tbl_filter(function(b)
		return vim.api.nvim_buf_is_loaded(b) and vim.bo[b].buflisted and b ~= cur
	end, vim.api.nvim_list_bufs())

	if #listed > 0 then
		-- Try previous buffer first
		local target = vim.fn.bufnr("#")
		if target <= 0 or not vim.api.nvim_buf_is_loaded(target) or not vim.bo[target].buflisted then
			-- If previous buffer invalid, pick the first listed buffer (next)
			target = listed[1]
		end
		-- Switch to target buffer
		vim.api.nvim_set_current_buf(target)
		-- Delete current buffer
		vim.api.nvim_buf_delete(cur, { force = force })
	else
		-- No other buffers, open a new empty buffer
		vim.cmd("enew")
		vim.api.nvim_buf_delete(cur, { force = force })
	end
end

-- Clipboard helper function
function _clipboard_yank(type)
	if type == "line" then
		vim.cmd('normal! `[V`]"+y')
	elseif type == "block" then
		vim.cmd('normal! `[\22`]"+y')
	else
		vim.cmd('normal! `[v`]"+y')
	end
end

-- ============================================================================
-- GLOBAL KEYBINDS (No Leader)
-- ============================================================================

-- UI & Navigation
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear search highlights" })
map("n", "<C-s>", "<cmd>w<cr>", { desc = "Save current buffer" })
map("n", "<C-S>", "<cmd>wa<cr>", { desc = "Save all buffers" })
map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprev<cr>", { desc = "Previous buffer" })
map("n", "q:", "<nop>", { desc = "Disable command-line window" })
map("n", "K", "<cmd>Lspsaga hover_doc<cr>", { desc = "Hover" })

-- LSP Navigation
map("n", "gd", function()
	Snacks.picker.lsp_definitions()
end, { desc = "Goto definition" })

-- Debugging (F-keys)
map("n", "<F5>", dap.continue, { desc = "DAP: Continue" })
map("n", "<F6>", dap.toggle_breakpoint, { desc = "DAP: Toggle breakpoint" })
map("n", "<F10>", dap.step_over, { desc = "DAP: Step over" })
map("n", "<F11>", dap.step_into, { desc = "DAP: Step into" })
map("n", "<F12>", dap.step_out, { desc = "DAP: Step out" })

-- ============================================================================
-- LEADER KEYBINDS (Organized by Category)
-- ============================================================================

-- ========================================
-- BUFFER MANAGEMENT (<leader> + single key)
-- ========================================
map("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit Neovim" })
map("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "Force quit Neovim" })
map("n", "<leader>x", function()
	close_buffer(false)
end, { desc = "Close buffer (safe)" })
map("n", "<leader>X", function()
	close_buffer(true)
end, { desc = "Force close buffer" })
map("n", "<leader>n", "<cmd>enew<cr>", { desc = "New buffer" })

-- ========================================
-- CLIPBOARD OPERATIONS (<leader> + y/p)
-- ========================================
map("n", "<leader>y", function()
	vim.o.operatorfunc = "v:lua._clipboard_yank"
	return "g@"
end, { expr = true, desc = "Yank to clipboard (motion)" })

map("v", "<leader>y", '"+y', { desc = "Yank selection to clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from clipboard" })

-- ========================================
-- FILE FINDER (<leader>f + *)
-- ========================================
map("n", "<leader>ff", function()
	Snacks.picker.files()
end, { desc = "Find files" })
map("n", "<leader>fF", function()
	Snacks.picker.files({ hidden = true })
end, { desc = "Find all files (hidden)" })
map("n", "<leader>fr", function()
	Snacks.picker.recent()
end, { desc = "Recent files" })
map("n", "<leader>fc", function()
	Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find config files" })
map("n", "<leader>fb", function()
	Snacks.picker.buffers()
end, { desc = "Find buffers" })
map("n", "<leader>fp", function()
	Snacks.picker.projects()
end, { desc = "Projects" })
map("n", "<leader>fz", function()
	Snacks.picker.lines()
end, { desc = "Find in current buffer" })

-- SEARCH OPERATIONS (<leader>f + *)
map("n", "<leader>fB", function()
	Snacks.picker.grep_buffers()
end, { desc = "Grep open buffers" })
map("n", "<leader>fg", function()
	Snacks.picker.grep()
end, { desc = "Grep files" })
map({ "n", "x" }, "<leader>fw", function()
	Snacks.picker.grep_word()
end, { desc = "Grep word/selection" })
map("n", "<leader>fh", function()
	Snacks.picker.help()
end, { desc = "Help pages" })
map("n", "<leader>fk", function()
	Snacks.picker.keymaps()
end, { desc = "Keymaps" })
map("n", "<leader>fm", function()
	Snacks.picker.marks()
end, { desc = "Marks" })
map("n", "<leader>fM", function()
	Snacks.picker.man()
end, { desc = "Man pages" })
map("n", "<leader>fu", function()
	Snacks.picker.undo()
end, { desc = "Undo history" })
map("n", "<leader>fq", function()
	Snacks.picker.qflist()
end, { desc = "Quickfix list" })
map("n", "<leader>fl", function()
	Snacks.picker.loclist()
end, { desc = "Location list" })

-- ========================================
-- EXPLORER (<leader>e)
-- ========================================
map("n", "<leader>e", function()
	Snacks.explorer()
end, { desc = "File explorer" })

-- ========================================
-- GIT OPERATIONS (<leader>g + *)
-- ========================================
map("n", "<leader>gb", function()
	Snacks.picker.git_branches()
end, { desc = "Git branches" })
map("n", "<leader>gl", function()
	Snacks.picker.git_log()
end, { desc = "Git log" })
map("n", "<leader>gL", function()
	Snacks.picker.git_log_line()
end, { desc = "Git log (current line)" })
map("n", "<leader>gs", function()
	Snacks.picker.git_status()
end, { desc = "Git status" })
map("n", "<leader>gS", function()
	Snacks.picker.git_stash()
end, { desc = "Git stash" })
map("n", "<leader>gd", function()
	Snacks.picker.git_diff()
end, { desc = "Git diff" })
map("n", "<leader>gf", function()
	Snacks.picker.git_log_file()
end, { desc = "Git log (current file)" })
map({ "n", "v" }, "<leader>gB", function()
	Snacks.gitbrowse()
end, { desc = "Git browse" })
map("n", "<leader>gg", function()
	Snacks.lazygit()
end, { desc = "Lazygit" })

-- ========================================
-- LSP OPERATIONS (<leader>l + *)
-- ========================================
map("n", "<leader>ld", function()
	Snacks.picker.lsp_definitions()
end, { desc = "Goto definition" })
map("n", "<leader>lD", function()
	Snacks.picker.lsp_declarations()
end, { desc = "Goto declaration" })
map("n", "<leader>lr", function()
	Snacks.picker.lsp_references()
end, { desc = "References" })
map("n", "<leader>lI", function()
	Snacks.picker.lsp_implementations()
end, { desc = "Goto implementation" })
map("n", "<leader>ly", function()
	Snacks.picker.lsp_type_definitions()
end, { desc = "Goto type definition" })
map("n", "<leader>ls", function()
	Snacks.picker.lsp_symbols()
end, { desc = "Document symbols" })
map("n", "<leader>lS", function()
	Snacks.picker.lsp_workspace_symbols()
end, { desc = "Workspace symbols" })

-- ========================================
-- UI TOGGLES (<leader>u + *)
-- ========================================
map("n", "<leader>ud", function()
	if vim.diagnostic.is_enabled() then
		vim.diagnostic.enable(false)
	else
		vim.diagnostic.enable(true)
	end
end, { desc = "Toggle diagnostics" })

map("n", "<leader>uu", function()
	local current = vim.diagnostic.config().underline
	vim.diagnostic.config({ underline = not current })
end, { desc = "Toggle diagnostic underline" })

map("n", "<leader>uv", function()
	local current = vim.diagnostic.config().virtual_text
	vim.diagnostic.config({ virtual_text = not current })
end, { desc = "Toggle diagnostic virtual text" })

map("n", "<leader>uz", function()
	Snacks.zen()
end, { desc = "Toggle Zen mode" })
map("n", "<leader>uZ", function()
	Snacks.zen.zoom()
end, { desc = "Toggle zoom" })
map("n", "<leader>un", function()
	Snacks.notifier.hide()
end, { desc = "Dismiss notifications" })
map("n", "<leader>uc", function()
	Snacks.toggle.option("conceallevel", { off = 0, on = 2 })
end, { desc = "Toggle conceal" })
map("n", "<leader>uC", function()
	local enabled = vim.g.__zen_mode_enabled

	if not enabled then
		vim.g.__zen_mode_enabled = true
		-- save current settings
		vim.g.__zen_laststatus = vim.o.laststatus
		vim.g.__zen_showtabline = vim.o.showtabline
		-- hide statusline and bufferline (tabline)
		vim.opt.laststatus = 0
		vim.opt.showtabline = 0
	else
		vim.g.__zen_mode_enabled = false
		-- restore previous settings
		if vim.g.__zen_laststatus ~= nil then
			vim.opt.laststatus = vim.g.__zen_laststatus
		end
		if vim.g.__zen_showtabline ~= nil then
			vim.opt.showtabline = vim.g.__zen_showtabline
		end
	end

	vim.cmd("NoNeckPain")
end, { desc = "Zen mode: center + hide status/bufferline" })

map("n", "<leader>ul", function()
	Snacks.toggle.line_number()
end, { desc = "Toggle line numbers" })
map("n", "<leader>uL", function()
	Snacks.toggle.option("relativenumber")
end, { desc = "Toggle relative numbers" })
map("n", "<leader>uw", function()
	Snacks.toggle.option("wrap")
end, { desc = "Toggle line wrap" })
map("n", "<leader>us", function()
	Snacks.toggle.option("spell")
end, { desc = "Toggle spell check" })

-- ========================================
-- EDITING (<leader> + /, r, G)
-- ========================================
map("n", "<leader>/", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })
map("n", "<leader>r", function()
	vim.lsp.buf.rename()
end, { desc = "Rename symbol" })
map("n", "<leader>G", "<cmd>Neogen<cr>", { desc = "Generate docstring" })

-- ========================================
-- DEBUGGING (<leader>d + *)
-- ========================================
map("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle breakpoint" })
map("n", "<leader>dB", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "DAP: Conditional breakpoint" })

map("n", "<leader>dp", function()
	dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, { desc = "DAP: Set logpoint" })

map("n", "<leader>de", dap.repl.open, { desc = "DAP: Open REPL" })
map("n", "<leader>dl", dap.run_last, { desc = "DAP: Run last" })
