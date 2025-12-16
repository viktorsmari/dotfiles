" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

"Syntax
"Plug 'ervandew/supertab'
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
Plug 'airblade/vim-gitgutter'
"Plug 'pangloss/vim-javascript'
"Plug 'ap/vim-css-color'

"Plug 'mg979/vim-visual-multi'
"Plug 'slim-template/vim-slim'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-sensible'

"Linter
"Plug 'w0rp/ale'
"Plug 'vim-airline/vim-airline'

"Search
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
"Plug 'henrik/vim-indexed-search'
Plug 'scrooloose/nerdtree'

"open and close brackets
"Plug 'jiangmiao/auto-pairs'

"Git
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'

Plug 'kshenoy/vim-signature'   " display marks in gutter

"Plug 'tpope/vim-surround'
"Plug 'Valloric/MatchTagAlways' " match divs

"GitGutter: refresh signs quickly while editing
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1

" On-demand loading
" Initialize plugin system
call plug#end()

colorscheme slate
syntax enable
"set background=light

set cursorline               " highlight current line
set cursorcolumn             " highlight current line
"set hidden
"set laststatus=2             " window will always have a status line
set list
" Make CursorHold fire quickly so gitgutter refreshes promptly
set updatetime=200
"set mouse=a
"set nobackup
"set noswapfile
set number                   " show line number
set showcmd                  " show command in bottom bar
set showmatch                " highlight matching brace
set wildmenu                 " visual autocomplete for command menu
set wrap!
" Spaces & Tabs
set tabstop=2       " number of visual spaces per TAB
set softtabstop=2   " number of spaces in tab when editing
set shiftwidth=2    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line

"search
set ignorecase      " ignore case when searching
set smartcase       " ignore case if search pattern is lower case

" folding
set foldmethod=indent
set foldlevel=20

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Do not search ctrlp in these folders
let g:ctrlp_custom_ignore = '_site\|node_modules\|DS_Store\|venv\|coverage\|bower_components\|tmp\|(\.(swp|git))'
let g:ctrlp_show_hidden = 1

let g:ale_fixers = {'ruby': ['rubocop'], 'python': ['trim_whitespace','black'], 'javascript': ['eslint']}
let g:ale_linters = {
 \ 'zsh':['shell'],
 \ 'python':['pylint'],
 \ 'ruby':['rubocop'],
 \ 'javascript':['eslint'],
 \ 'scss':['stylelint'],
 \ 'css':['stylelint']}

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"Without this, tab will cycle backwards
"let g:SuperTabDefaultCompletionType = "<c-n>"

"Save with ctrl s
imap <C-s> <Esc>:w<CR>
nmap <C-s> :w<CR>

" Remap :W to :w
command W w
command Qa qa

"nerdTree
nnoremap <C-t> :NERDTreeToggle<CR>
inoremap <C-t> :NERDTreeToggle<CR>

"navigate splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"tab
nnoremap <F7> :tabp<CR>
nnoremap <F8> :tabn<CR>
inoremap <F7> <ESC>:tabp<CR>
inoremap <F8> <ESC>:tabn<CR>
nnoremap <A-Left> :tabp<CR>
nnoremap <A-Right> :tabn<CR>
"move tab
nnoremap <S-A-Left> :-tabm<CR>
nnoremap <S-A-Right> :+tabm<CR>

" Move between linting errors
nnoremap ]a :ALENextWrap<CR>
nnoremap [a :ALEPreviousWrap<CR>

" Copilot suggestions with Ctrl + Space
inoremap <C-Space> <Plug>(copilot-next)
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")

" Ctrl C will copy
nnoremap <C-c> "+yy
vnoremap <C-c> "+y

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

"disable Ex mode
:nnoremap Q <Nop>


" Hide .pyc in NERDTree
let NERDTreeIgnore = ['\.pyc$']
let NERDTreeShowHidden=1


"open nerdtree in empty vim
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let mapleader = ","
map <Leader>l :Git blame<CR>
map <Leader>m :NERDTreeFind<CR>
"Clear search
"map <silent> <leader>qs <Esc>:noh<CR>

" Search and replace word under cursor (,*)
nnoremap <leader>* :%s/\<<C-r><C-w>\>//<Left>

" pasting from clipboard and mouse selection
map <Leader>p :set paste<CR>o<esc>"+p:set nopaste<cr>
map <Leader>P :set noai<CR>o<esc>"*]p:set ai<cr>


" Find files using Telescope command-line sugar.
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

"use this to search for the word under the cursor using Telescope
nnoremap <Leader>a <cmd>Telescope live_grep<cr>
nnoremap <Leader>A :lua require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') })<CR>

" Use <F2> to toggle between 'paste' and 'nopaste'
"set pastetoggle=<F2>

" use F3 to disable highlight search, until next search
nnoremap <F3> :noh<CR>

" to prevent neovim errors inside python3 virtualenv
"let g:python3_host_prog='/usr/bin/python'
