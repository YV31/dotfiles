
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

local ensure_packer = function()
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()
local packer = require('packer')

packer.startup(function(use)
  -- Packer
  use 'wbthomason/packer.nvim'

  -- Julia support
  use 'JuliaEditorSupport/julia-vim'

  -- Fuzzy OwO
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- General language support
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Gruvbox
  use 'morhetz/gruvbox'

  if packer_bootstrap then
    packer.sync()
    packer.install()
  end
end)

vim.opt.nu          = true              -- Line numbers
vim.opt.rnu         = true              -- Show line number relative to cursor line
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
vim.opt.showtabline = 2                 -- Always show the tab line

-- Show tabs and trailing spaces
vim.opt.list        = true
vim.opt.listchars   = { tab = '│ ' , trail = '~' }

vim.opt.autochdir   = true
vim.opt.mouse       = ""
vim.opt.formatoptions:remove({'r', 'o'})

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

vim.g.c_syntax_for_h = true

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
  cpp  = [[ setlocal ts=4 ]],
  lua  = [[ setlocal ts=2 et ]],
  elm  = [[ setlocal ts=2 et ]],
  javascript = [[ setlocal ts=4 et ]],
  markdown = [[ setlocal ts=4 et ]],
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

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set('n', '<F3>', function()
  fn.setreg('/', (fn.getreg('/') == '') and fn.expand("<cword>") or '')
end)


require('nvim-treesitter.configs').setup {
  ensure_installed = { "c", "cpp", "lua", "vim", "python", "go" },
  sync_install = false,
  auto_install = false,
  highlight = {
    enable = true,
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KiB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },
}

