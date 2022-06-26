" Automatic Install of missing plugins
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Automatic Install of Vim-Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
"autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
"  \| PlugInstall --sync | source $MYVIMRC
"\| endif

call plug#begin()
" Theme
Plug 'sainnhe/gruvbox-material'
Plug 'nvim-lualine/lualine.nvim'
Plug 'xiyaowong/nvim-transparent'

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

" Golang
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries' }

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
set autowrite
hi ColorColumn ctermbg=darkgrey guibg=darkgrey

" Set Gruvbox as color scheme and remove background for that sweet transparency
colorscheme gruvbox-material

" Transparent background stuff
let g:transparent_enabled = v:true

" Some remaps of things...
let mapleader = " "

" Use tab for completions
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

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
nmap <silent> cd <Plug>(coc-definition)
nmap <silent> cy <Plug>(coc-type-definition)
nmap <silent> ci <Plug>(coc-implementation)
nmap <silent> cr <Plug>(coc-references)

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
" autocmd CursorHold * silent call CocActionAsync('highlight')
" nmap <leader>rn <Plug>(coc-rename)

" Code Actions
xmap <leader>ca  <Plug>(coc-codeaction-selected)
nmap <leader>ca  <Plug>(coc-codeaction-selected)

" Auto Fix current line
nmap <leader>qf  <Plug>(coc-fix-current)

"" Remap <C-f> and <C-b> for scrolling float windows/popups
"if has('nvim-0.4.0') || has('patch-8.2.0750')
"  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"endif

" Auto Pair stuff
lua require('nvim-autopairs').setup({map_cr = true})

" nvim-tree
lua << EOF
require'nvim-tree'.setup({
    view = {
        adaptive_size=true,
        }
})
EOF
nnoremap <leader>fe :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>

" nvim-web-devicons
lua require('nvim-web-devicons').setup{default=true}

" Go setup stuff
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
autocmd FileType go nmap <leader>gb <Plug>(go-build)
autocmd FileType go nmap <leader>gr <Plug>(go-run)
autocmd FileType go nmap <leader>gt <Plug>(go-test)
autocmd FileType go nmap <leader>gtc <Plug>(go-coverage-toggle)
let g:go_list_type = "quickfix"

" LuaLine stuff
lua << END
require('lualine').setup()
END

