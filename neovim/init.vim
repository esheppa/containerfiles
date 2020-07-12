" https://github.com/neovim/neovim/issues/5990
" Can cause weird issues but the below should solve it
set guicursor= " prevents weird shit
set termguicolors " allows full colours

call plug#begin()

Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}

Plug 'rust-lang/rust.vim'

Plug 'moll/vim-bbye'
Plug 'justinmk/vim-sneak'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'junegunn/fzf', { 'dir': '~/.config/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'itchyny/lightline.vim'
Plug 'ap/vim-buftabline'


Plug 'morhetz/gruvbox'

call plug#end()

set hidden " boh
set number " shows line numbers
set autoread " auto updates file on change
set autoindent 
set smartindent
set smartcase " only considers case when uppercase
set expandtab " presing tab inserts spaces
set smarttab
set tabstop=4
set shiftwidth=4

set hlsearch
set incsearch

let g:deoplete#enable_at_startup = 1
set completeopt -=preview

let g:LanguageClient_serverCommands = { 'rust': ['ra_lsp_server'],  'python': ['/usr/local/bin/pyls']}

let g:LanguageClient_useVirtualText="All"

autocmd FileType python,rust LanguageClientStart
autocmd bufenter 'call deoplete#enable()'

let g:sneak#label = 1

nnoremap <silent> K  :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

map <C-f> :NERDTreeToggle<CR>

autocmd FileType rust LanguageClientStart
autocmd bufenter 'call deoplete#enable()'

nnoremap H ^
nnoremap L $

nnoremap ; :|

inoremap <C-n> <Esc>
vnoremap <C-n> <Esc>

nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
nnoremap <C-k> :bnext<CR>
nnoremap <C-j> :bprevious<CR>

inoremap <C-h> <Esc><C-W>h
inoremap <C-l> <Esc><C-W>l
inoremap <C-k> <Esc>:bnext<CR>
inoremap <C-j> <Esc>:bprevious<CR>

vnoremap <C-h> <Esc><C-W>h
vnoremap <C-l> <Esc><C-W>l
vnoremap <C-k> <Esc>:bnext<CR>
vnoremap <C-j> <Esc>:bprevious<CR>

" later usse bbye here
nnoremap <C-x> :Bdelete<CR>

let g:fzf_layout = { 'window': {
    \ 'width': 0.9,
    \ 'height': 0.7,
    \ 'highlight': 'Comment',
    \ 'rounded': v:false } }

nnoremap fb :BLines<CR>    
nnoremap fl :Lines<CR>
nnoremap fa :Rg<CR>  

tnoremap <C-[> <C-\><C-n>
tnoremap <Esc> <C-\><C-n>

tnoremap <C-h> <C-\><C-n><C-W>h
tnoremap <C-l> <C-\><C-n><C-W>l
tnoremap <C-k> <C-\><C-n>:bnext<CR>
tnoremap <C-j> <C-\><C-n>:bprevious<CR>
