vim.g.mapleader = " "
-- Netrw
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Update plugins
vim.keymap.set(
  'n',
  '<leader>pu',
  [[:TSUpdate all<CR>:Lazy sync<CR>]],
  { noremap = true, silent = true }
)

-- Visual mode move block
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Yank to end of line
vim.keymap.set("n", "Y", "y$")

-- Move lines
vim.keymap.set("n", "J", "mzJ`z")

-- Half page up/down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Search cursor in middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Search functions in Python
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Preserve yank
vim.keymap.set("n", "<leader>p", "\"_dP")

-- Yank to clipboard
-- Check if running on WSL
function is_wsl()
    local handle = io.popen("uname -a")
    local result = handle:read("*a")
    handle:close()

    return string.match(result, "microsoft") ~= nil
end

-- Example usage
if is_wsl() then
    vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'clip.exe',
      ['*'] = 'clip.exe',
    },
    paste = {
      ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Add execute permission
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Code Runner

-- Copilot
vim.api.nvim_set_keymap('i', '<C-,>', 'copilot#Accept("<CR>")', {expr=true, silent=true})
vim.api.nvim_set_keymap('s', '<C-,>', 'copilot#Accept("<CR>")', {expr=true, silent=true})
