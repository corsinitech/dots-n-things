" Automatic Install of Vim-Plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"Automatic Install of missing plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()
" Theme
Plug 'gruvbox-community/gruvbox'

" Telescope Dependencies
Plug 'nvim-lua/plenary.nvim'
Plug 'BurntSushi/ripgrep'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'neovim/nvim-lspconfig'
Plug 'kyazdani42/nvim-web-devicons'

" Telescope babyyyyy
Plug 'nvim-telescope/telescope.nvim' 

" COC
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Autopairs
Plug 'windwp/nvim-autopairs'

"UltiSnips
Plug 'SirVer/ultisnips'

" File Tree
Plug 'kyazdani42/nvim-tree.lua'

" Cht.sh
Plug 'dbeniamine/cheat.sh-vim'

call plug#end()


" Some Basic setup stuff
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set relativenumber
set nohlsearch
set nu
set noerrorbells
set hidden
set nowrap
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set noshowmode
set signcolumn=yes
set colorcolumn=80
set nocompatible
set clipboard=
hi ColorColumn ctermbg=darkgrey guibg=darkgrey

" Insert new line above/below without going into insert mode
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>

" Set Gruvbox as color scheme and remove background for that sweet transparency
colorscheme gruvbox
hi normal guibg=000000

" Some remaps of things...
let mapleader = " "

" Treesitter stuff
lua << EOF
require 'nvim-treesitter.configs'.setup {
    ensure_installed = {"java", "json", "python", "lua", "rust", "go", "javascript"}, --one of "all", "maintained" (parsers with maintainers)
    sync_install = true,
    highlight = {
        enable = true, --false will disable the whole extension
        },
    }
EOF

" Telescope remaps
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fc <cmd>Telescope commands<cr>

" Mappings for CoC stuff
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Press K to show docs for an item
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Symbol Renaming
autocmd CursorHold * silent call CocActionAsync('highlight')
nmap <leader>rn <Plug>(coc-rename)

" Code Actions
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Auto Fix current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap <C-f> and <C-b> for scrolling float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Native Statusline Support
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Auto Pair stuff
lua require('nvim-autopairs').setup({map_cr = true})

" nvim-tree
lua require'nvim-tree'.setup{}
nnoremap <leader>fe :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>

" nvim-web-devicons
lua require('nvim-web-devicons').setup{default=true}

