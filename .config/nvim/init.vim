
call plug#begin('~/.local/share/nvim/plugged')

" Theme
Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'folke/tokyonight.nvim'

" Statusbar
Plug 'hoob3rt/lualine.nvim'

" Fuzzy Finder
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" LSP
Plug 'neovim/nvim-lspconfig'

" Syntax Highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Git Integration
Plug 'tpope/vim-fugitive'

" File Explorer
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons'

" Commenting
Plug 'b3nj5m1n/kommentary'

" Surround
Plug 'tpope/vim-surround'

" Terminal
Plug 'voldikss/vim-floaterm'

" Markdown Plugins
Plug 'preservim/vim-markdown'
Plug 'dhruvasagar/vim-table-mode'
Plug 'ellisonleao/glow.nvim'

" Org Mode Plugins
Plug 'jceb/vim-orgmode'
Plug 'nvim-orgmode/orgmode'
Plug 'nvim-neorg/neorg'

call plug#end()

" Gruvbox Theme
syntax enable
set number
set wrap
set background=dark
colorscheme gruvbox

lua require('config')

" NvimTreeOpen
