-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.winborder = 'rounded'

local keymap = vim.keymap

-- use jk to exit insert mode
keymap.set('i', 'jk', '<ESC>', { desc = 'Exit insert mode with jk' })

-- clear search highlights
keymap.set('n', '<leader>nh', ':nohl<CR>', { desc = 'Clear search highlights' })

-- Disable the spacebar key's default behavior in Normal and Visual modes
keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true, desc = 'Disable spacebar default behavior' })

-- For conciseness
local opts = { noremap = true, silent = true }

-- save file
keymap.set('n', '<C-s>', '<cmd> w <CR>', { desc = 'Save file', noremap = true, silent = true })

-- save file without auto-formatting
keymap.set('n', '<leader>sn', '<cmd>noautocmd w <CR>', { desc = 'Save file without auto-formatting', noremap = true, silent = true })
-- quit file
keymap.set('n', '<C-q>', '<cmd> q <CR>', { desc = 'Quit current window', noremap = true, silent = true })

-- delete single character without copying into register
keymap.set('n', 'x', '"_x', { desc = 'Delete character without yanking', noremap = true, silent = true })

-- Vertical scroll and center
keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll half page down and center cursor', noremap = true, silent = true })
keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll half page up and center cursor', noremap = true, silent = true })

-- Find and center
keymap.set('n', 'n', 'nzzzv', { desc = 'Go to next search result and center view', noremap = true, silent = true })
keymap.set('n', 'N', 'Nzzzv', { desc = 'Go to previous search result and center view', noremap = true, silent = true })

-- Resize with arrows
keymap.set('n', '<Up>', 'k', { desc = 'Move cursor up', noremap = true, silent = true })
keymap.set('n', '<Down>', 'j', { desc = 'Move cursor down', noremap = true, silent = true })
keymap.set('n', '<Left>', 'h', { desc = 'Move cursor left', noremap = true, silent = true })
keymap.set('n', '<Right>', 'l', { desc = 'Move cursor right', noremap = true, silent = true })

-- Buffers
keymap.set('n', '<Tab>', ':bnext<CR>', { desc = 'Go to next buffer', noremap = true, silent = true })
keymap.set('n', '<S-Tab>', ':bprevious<CR>', { desc = 'Go to previous buffer', noremap = true, silent = true })
keymap.set('n', '<leader>bx', ':bdelete!<CR>', { desc = 'Close current buffer', noremap = true, silent = true })
keymap.set('n', '<leader>bn', '<cmd> enew <CR>', { desc = 'Create new buffer', noremap = true, silent = true })

-- Window management
keymap.set('n', '<leader>sv', '<C-w>v', { desc = 'Split window vertically', noremap = true, silent = true })
keymap.set('n', '<leader>sh', '<C-w>s', { desc = 'Split window horizontally', noremap = true, silent = true })
keymap.set('n', '<leader>se', '<C-w>=', { desc = 'Make splits equal size', noremap = true, silent = true })
keymap.set('n', '<leader>sx', '<cmd>close<CR>', { desc = 'Close current split', noremap = true, silent = true })

-- Navigate between splits
keymap.set('n', '<C-k>', ':wincmd k<CR>', { desc = 'Move to upper split', noremap = true, silent = true })
keymap.set('n', '<C-j>', ':wincmd j<CR>', { desc = 'Move to lower split', noremap = true, silent = true })
keymap.set('n', '<C-h>', ':wincmd h<CR>', { desc = 'Move to left split', noremap = true, silent = true })
keymap.set('n', '<C-l>', ':wincmd l<CR>', { desc = 'Move to right split', noremap = true, silent = true })

-- Tabs
keymap.set('n', '<leader>to', ':tabnew<CR>', { desc = 'Open new tab', noremap = true, silent = true })
keymap.set('n', '<leader>tx', ':tabclose<CR>', { desc = 'Close current tab', noremap = true, silent = true })
keymap.set('n', '<leader>tn', ':tabn<CR>', { desc = 'Go to next tab', noremap = true, silent = true })
keymap.set('n', '<leader>tp', ':tabp<CR>', { desc = 'Go to previous tab', noremap = true, silent = true })

-- Toggle line wrapping
keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', { desc = 'Toggle line wrapping', noremap = true, silent = true })

-- Stay in indent mode
keymap.set('v', '<', '<gv', { desc = 'Maintain indent after shift', noremap = true, silent = true })
keymap.set('v', '>', '>gv', { desc = 'Maintain indent after shift', noremap = true, silent = true })

-- Keep last yanked when pasting
keymap.set('v', 'p', '"_dP', { desc = 'Paste without yanking current selection', noremap = true, silent = true })

-- Diagnostic keymaps
keymap.set('n', '[d', function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = 'Go to previous diagnostic message' })

keymap.set('n', ']d', function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Go to next diagnostic message' })

keymap.set('n', '<leader>gr', vim.lsp.buf.references, { desc = 'Find all references' })
keymap.set('n', '<leader>ld', vim.lsp.buf.definition, { desc = 'List definitions (location list)' })

-- LSP Actions (Smart Fixes and Renaming)
keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'See available code actions' })
keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Smart rename' })

-- Moving Lines (Alt + j/k)
-- Normal Mode
keymap.set('n', '<C-A-j>', ':m .+1<CR>==', { desc = 'Move line down' })
keymap.set('n', '<C-A-k>', ':m .-2<CR>==', { desc = 'Move line up' })
keymap.set('n', '<C-A-h>', '<', { desc = 'Move line left' })
keymap.set('n', '<C-A-l>', '>', { desc = 'Move line right' })

-- Visual Mode
keymap.set('v', '<C-A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
keymap.set('v', '<C-A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
keymap.set('v', '<C-A-h>', '<gv', { desc = 'Move selection left' })
keymap.set('v', '<C-A-l>', '>gv', { desc = 'Move selection right' })

-- Moving up/down in Insert mode using Alt + j/k
keymap.set('i', '<A-j>', '<Down>', { desc = 'Move down in Insert mode' })
keymap.set('i', '<A-k>', '<Up>', { desc = 'Move up in Insert mode' })
keymap.set('i', '<A-h>', '<Left>', { desc = 'Move left in Insert mode' })
keymap.set('i', '<A-l>', '<Right>', { desc = 'Move right in Insert mode' })

-- Multi-cursor VS Code style
-- Add cursor above
keymap.set('n', '<C-A-k>', '<Plug>(VM-Add-Cursor-Up)', { desc = 'Add cursor up' })
-- Add cursor below
keymap.set('n', '<C-A-j>', '<Plug>(VM-Add-Cursor-Down)', { desc = 'Add cursor down' })
