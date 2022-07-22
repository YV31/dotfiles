" vim: fdm=marker:

"
"  .__       .__  __         .__
"  |__| ____ |__|/  |_ ___  _|__| _____
"  |  |/    \|  \   __\\  \/ /  |/     \
"  |  |   |  \  ||  |   \   /|  |  Y Y  \
"  |__|___|  /__||__| /\ \_/ |__|__|_|  /
"          \/         \/              \/
"
"  Minimalist (N)Vim Configuration.
"  By YV31
"

filetype indent plugin on
syntax on

set hidden            " Hide abandoned buffers
set nu rnu            " Numbers + Relative Numbers
set redrawtime=10000  " More time to redraw (Better for larger files)
set cmdheight=2       " Larger command line
set nowrap            " No warping
set wildmenu          " Better completion menu
set ignorecase        " Ignore case sensitive search
set smartcase         " Overwrite 'ignorecase' if search has upper case chars
set hlsearch          " Highlight search
set updatetime=300    " Swap write to disk delay
set shortmess+=cfms   " Abbreviate some informations
set signcolumn=auto   " Automatic signs
set cc=81             " Color Column
set encoding=utf-8    " UTF-8 Encoding
set spl=en_us,pt_br   " Spell check English and Brazilian Portuguese
set showtabline=2
set shell=bash

set list
set listchars=tab:│\ ,trail:~

fu! CheckSpell()
	if &spell
		return "[Spell (" . expand(&spelllang) . ")]"
	else
		return ""
	endif
endf

" Who needs airline?
set stl=\ %f\ %m%r%y\ %{CheckSpell()}%=(%l,\ %c)\ (0x%B)\ (%P)\ [%L]\ 

set nowritebackup " Don't make backup
set nobackup      " Don't keep backup

" Indentation
set smartindent
set noet           " Don't expand tabs
set shiftwidth=0 " Default to tabstop

let mapleader = ' '

let c_syntax_for_h = 1

let g:gruvbox_improved_warnings = 1
let g:gruvbox_contrast_dark = 'hard'

autocmd VimEnter * colorscheme gruvbox

function Up()
	if expand("%") != ""
		update
	endif
endfunction

" Auto save
autocmd TextChanged * call Up()
autocmd InsertLeave * call Up()

autocmd FileType html setlocal ts=2
autocmd FileType css  setlocal ts=2
autocmd FileType xml  setlocal ts=2
autocmd FileType vim  setlocal ts=2
autocmd FileType sh   setlocal ts=2
autocmd FileType asm      setlocal ts=2
autocmd FileType asm_ca65 setlocal ts=2
autocmd FileType javascript setlocal ts=4

noremap <leader>e :Fern %:h -drawer -toggle<CR>
noremap <leader>s :setlocal spell!<CR>

function! ToggleSearch()
	if (@/ == '')
		let @/ = expand("<cword>")
	else
		let @/ = ''
	endif
endfunction

nnoremap <F3> :call ToggleSearch()<cr>

" Ensure that plug.vim is installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')

" C Syntax
Plug 'octol/vim-cpp-enhanced-highlight'

" Fern
Plug 'lambdalisue/fern.vim'
Plug 'antoinemadec/FixCursorHold.nvim'

" ctrlp.vim
Plug 'ctrlpvim/ctrlp.vim'

" Gruvbox
Plug 'morhetz/gruvbox'

Plug 'maxbane/vim-asm_ca65'
Plug 'karolbelina/uxntal.vim'

call plug#end()

