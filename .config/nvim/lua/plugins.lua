local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  -- Packer
  use 'wbthomason/packer.nvim'

  -- Julia support
  use 'JuliaEditorSupport/julia-vim'

  -- General language support
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Fern
  use 'lambdalisue/fern.vim'
  use 'antoinemadec/FixCursorHold.nvim'

  -- ctrlp.vim
  use 'ctrlpvim/ctrlp.vim'

  -- Gruvbox
  use 'morhetz/gruvbox'

  use 'maxbane/vim-asm_ca65'
  use 'karolbelina/uxntal.vim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
