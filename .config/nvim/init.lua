
--
--   .__       .__  __         .__
--   |__| ____ |__|/  |_ ___  _|__| _____
--   |  |/    \|  \   __\\  \/ /  |/     \
--   |  |   |  \  ||  |   \   /|  |  Y Y  \
--   |__|___|  /__||__| /\ \_/ |__|__|_|  /
--           \/         \/              \/
--
--   Minimalist (N)Vim Configuration.
--   By YV31
--

autocmd = vim.api.nvim_create_autocmd
fn = vim.fn

vim.opt.hidden      = true
vim.opt.nu          = true
vim.opt.rnu         = true
vim.opt.redrawtime  = 10000             -- More time to redraw (Better for larger files)
vim.opt.cmdheight   = 2                 -- Larger command line
vim.opt.wrap        = false             -- No warping
vim.opt.wildmenu    = true              -- Better completion menu
vim.opt.ignorecase  = true              -- Ignore case sensitive search
vim.opt.smartcase   = true              -- Overwrite 'ignorecase' if search has upper case chars
vim.opt.hlsearch    = true              -- Highlight search
vim.opt.updatetime  = 300               -- Swap write to disk delay
vim.opt.signcolumn  = 'auto'            -- Automatic signs
vim.opt.colorcolumn = {81}              -- Color Column
vim.opt.encoding    = 'utf-8'           -- UTF-8 Encoding
vim.opt.spelllang   = {'en_us','pt_br'} -- Spell check English and Brazilian Portuguese
vim.opt.showtabline = 2
vim.opt.shell       = 'bash'
vim.opt.list        = true
vim.opt.listchars   = { tab = '│ ' , trail = '~' }

-- Who needs airline?
function status()
  return ' %f %m%r%y '
  .. (vim.opt.spell:get() and '[Spell ('
  .. vim.inspect(vim.opt.spelllang:get())
  .. ')]' or '')
  .. '%=(%l, %c) (0x%B) (%P) [%L] '
end

vim.opt.statusline = '%!v:lua.status()'

vim.opt.writebackup = false -- Don't make backup
vim.opt.backup      = false -- Don't keep backup

-- Indentation
vim.opt.smartindent = true
vim.opt.expandtab   = false -- Don't expand tabs
vim.opt.shiftwidth  = 0     -- Default to tabstop

vim.g.mapleader = ' '

vim.g.gruvbox_contrast_dark = 'hard'

vim.cmd.colorscheme('gruvbox')

local typecmd = {
  html = [[ setlocal ts=2 ]],
  tex  = [[ setlocal ts=2 ]],
  css  = [[ setlocal ts=2 ]],
  xml  = [[ setlocal ts=2 ]],
  vim  = [[ setlocal ts=2 ]],
  sh   = [[ setlocal ts=2 ]],
  asm  = [[ setlocal ts=2 ]],
  lua  = [[ setlocal ts=2 et ]],
  javascript = [[ setlocal ts=4 et ]],
}

for filetype, cmd in pairs(typecmd) do
  autocmd("FileType", { pattern = { filetype }, command = cmd })
end

-- Auto-save
autocmd({"TextChanged", "InsertLeave"}, {
  pattern = { '*' },
  callback = function()
    if fn.expand('%') ~= "" then vim.cmd.update() end
  end,
})

vim.keymap.set('n', '<leader>e', function()
  vim.cmd [[Fern %:h -drawer -toggle]]
end)

vim.keymap.set('n', '<leader>s', function()
  vim.cmd [[setlocal spell!]]
end)

vim.keymap.set('n', '<F3>', function()
  fn.setreg('/', (fn.getreg('/') == '') and fn.expand("<cword>") or '')
end)

require('plugins')

require('nvim-treesitter.configs').setup {
  ensure_installed = { "c", "lua", "vim", "python", "go" },
  sync_install = false,
  auto_install = false,
  highlight = {
    enable = true,
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },
}

