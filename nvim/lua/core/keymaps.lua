-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- For conciseness
local opts = { noremap = true, silent = true }

-- save file and format
vim.keymap.set("n", "<leader>w", "<cmd> w <CR>", opts)

-- auto-yank mouse selection to system clipboard
vim.keymap.set("x", "<LeftRelease>", '"+y', { desc = "copy mouse selection" })

-- save file without auto-formatting
vim.keymap.set("n", "<leader>sn", "<cmd>noautocmd w <CR>", opts)

-- quit fil
-- <C-q> bufdelete handled in plugins/snacks.lua keys

-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x', opts)

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Find and center
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- Resize with arrows
vim.keymap.set("n", "<Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<Right>", ":vertical resize +2<CR>", opts)

-- Buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", opts)
vim.keymap.set("n", "<leader>x", ":bd!<CR>", opts) -- close buffer
vim.keymap.set("n", "<leader>b", "<cmd> enew <CR>", opts) -- new buffer

-- Window management
vim.keymap.set("n", "<leader>v", "<C-w>v", opts) -- split window vertically
vim.keymap.set("n", "<leader>h", "<C-w>s", opts) -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", opts) -- make split windows equal width & height
vim.keymap.set("n", "<leader>xs", ":close<CR>", opts) -- close current split window

-- Navigate between splits
-- (<C-h/j/k/l> are owned by vim-tmux-navigator so they cross into tmux panes;
--  diagnostics live on ]d / [d below)
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", opts)
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", opts)
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", opts)
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", opts)

-- Tabs
vim.keymap.set("n", "<leader>to", ":tabnew<CR>", opts) -- open new tab
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", opts) -- close current tab
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", opts) --  go to next tab
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", opts) --  go to previous tab

-- Toggle line wrapping
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opts)

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- New tab
vim.keymap.set("n", "te", ":tabedit")

-- Select all
vim.keymap.set("n", "<C-a>", "gg<S-v>G")

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts)

-- Disable continuations
vim.keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
vim.keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Diagnostic keymaps

vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next diagnostic message" })

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })

-- Copy diagnostic(s) on current line to system clipboard
vim.keymap.set("n", "<leader>ce", function()
	local d = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
	if #d == 0 then
		return vim.notify("No diagnostic on this line")
	end
	local msg = table.concat(
		vim.tbl_map(function(x)
			return x.message
		end, d),
		"\n"
	)
	vim.fn.setreg("+", msg)
	vim.notify("Copied diagnostic")
end, { desc = "Copy diagnostic under cursor" })
vim.keymap.set("n", "<leader>q", ":bd!<CR>", { desc = "Close current buffer" })

-- Smart :q — close the current bufferline buffer instead of the window.
-- If only one listed file buffer remains, fall through to real :quit.
local function smart_quit(bang)
  -- Jump to a file window if currently in neo-tree
  if vim.bo.filetype == 'neo-tree' then
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
      local b = vim.api.nvim_win_get_buf(win)
      if vim.bo[b].filetype ~= 'neo-tree' and vim.bo[b].buftype == '' then
        vim.api.nvim_set_current_win(win)
        break
      end
    end
  end
  -- Count listed file buffers
  local listed = {}
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[b].buflisted and vim.bo[b].buftype == '' then
      table.insert(listed, b)
    end
  end
  if #listed > 1 then
    local cur = vim.api.nvim_get_current_buf()
    -- Switch current window to another listed buffer first
    for _, b in ipairs(listed) do
      if b ~= cur then
        vim.api.nvim_set_current_buf(b)
        break
      end
    end
    pcall(vim.cmd, 'bdelete' .. (bang and '!' or '') .. ' ' .. cur)
    -- Also tabclose if we were in an extra tab page
    if #vim.api.nvim_list_tabpages() > 1 then
      pcall(vim.cmd, 'tabclose' .. (bang and '!' or ''))
    end
  else
    vim.cmd('quit' .. (bang and '!' or ''))
  end
end
vim.api.nvim_create_user_command('Q', function(opts) smart_quit(opts.bang) end, { bang = true })
vim.cmd([[cnoreabbrev <expr> q (getcmdtype() == ':' && getcmdline() ==# 'q')  ? 'Q'  : 'q']])
vim.cmd([[cnoreabbrev <expr> q! (getcmdtype() == ':' && getcmdline() ==# 'q!') ? 'Q!' : 'q!']])

vim.keymap.set("t", "<Esc>", "<c-\\><c-n><c-h>", opts)
