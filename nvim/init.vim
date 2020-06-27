"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim-plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
nnoremap ,p :Files<CR>
nnoremap ,t :Tags<CR>
nnoremap ,b :Buffers<CR>
nnoremap ,l :BTags<CR>
nnoremap ,w :call fzf#vim#tags(expand('<cword>'))<CR>

Plug 'ludovicchabant/vim-gutentags'

Plug 'jlanzarotta/bufexplorer'
"map <silent> <F3> :call BufExplorerHorizontalSplit()<CR>
map <silent> <F3> :call ToggleBufExplorer()<CR>
let g:bufExplorerDefaultHelp = 0
let g:bufExplorerSplitHorzSize = 5
let g:bufExplorerSplitBelow = 1
let g:bufExplorerShowRelativePath = 0
let g:bufExplorerSplitOutPathName = 1

Plug 'terryma/vim-multiple-cursors'

Plug 'Lokaltog/vim-easymotion'
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1 " Turn on case sensitive feature
" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap ,, <Plug>(easymotion-s)
omap ,, <Plug>(easymotion-s)
vmap ,, <Plug>(easymotion-s)
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-s2)

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"let g:go_bin_path = "/Users/pachanga/dev/gobin/bin"

Plug 'rking/ag.vim'

"Plug 'vim-scripts/AutoComplPop'

Plug 'w0rp/ale'
" Write this in your vimrc file
let g:ale_lint_on_text_changed = 'never'
" You can disable this option too
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 0

"Plug 'ludovicchabant/vim-lawrencium'

Plug 'leafoftree/vim-vue-plugin'

Plug 'OmniSharp/omnisharp-vim'
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_highlighting = 2
"let g:OmniSharp_proc_debug = 1
let g:OmniSharp_loglevel = 'debug'
let g:OmniSharp_server_use_mono = 1
"let g:OmniSharp_selector_ui = 'fzf'

let g:ale_linters = { 'cs': ['OmniSharp'] }

Plug 'prabirshrestha/asyncomplete.vim'
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

set completeopt=longest,menuone
"set completepopup=highlight:Pmenu,border:off

call plug#end()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on

syntax enable
colorscheme inkpot

set nocompatible
set virtualedit=all
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set showmode            " Show current mode.
set ruler               " Show the line and column numbers of the cursor.
set number              " Show the line numbers on the left side.
"set relativenumber
set formatoptions+=o    " Continue comment marker in new lines.
set textwidth=0         " Hard-wrap long lines as you type them.
set expandtab           " Insert spaces when TAB is pressed.
set tabstop=2           " Render TABs using this many spaces.
set shiftwidth=2        " Indentation amount for < and > commands.
set wildmenu
"set wildmode=longest,list
set wildmode=longest:full
set encoding=utf-8
set nobackup
set noswapfile
set title
set hidden
set nohlsearch
set laststatus=2
set lazyredraw
set autoindent
set smartindent
set noerrorbells        " No beeps.
set modeline            " Enable modeline.
set linespace=0         " Set line-spacing to minimum.
set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)
set backspace=indent,eol,start

" More natural splits
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.

" Simplify windows navigation
set wmh=0

if !&scrolloff
  set scrolloff=3       " Show next 3 lines while scrolling.
endif
if !&sidescrolloff
  set sidescrolloff=5   " Show next 5 columns while side-scrolling.
endif
set nostartofline       " Do not jump to first character with page commands.

" Explicit paste support
set pastetoggle=<F5>

" path
set statusline+=%F
" flags
set statusline+=%m%r%h%w
" encoding
set statusline+=\ [%{strlen(&fenc)?&fenc:&enc}]
" line x of y
set statusline+=\ [line\ %l\/%L]

" auto-resize windows
autocmd VimResized * wincmd =

"set mouse=a

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" j,k should go into wrapped lines
map j gj
map k gk

"w!! would allow to use sudo for writing into a privileged file
cmap w!! w !sudo tee % >/dev/null

com! -nargs=1 Qfdo try | sil cfirst |
  \ while 1 | exec <q-args> | sil cn | endwhile |
  \ catch /^Vim\%((\a\+)\)\=:E\%(553\|42\):/ |
  \ endtry

com! -nargs=1 Qfdofile try | sil cfirst |
  \ while 1 | exec <q-args> | sil cnf | endwhile |
  \ catch /^Vim\%((\a\+)\)\=:E\%(553\|42\):/ |
  \ endtry

" some hotkeys for quickfix window
"nmap <leader>n :cn<CR><Esc>h 
"nmap <leader>N :cp<CR><Esc>h 
nmap ,n :cn<CR><Esc>h 
nmap ,N :cp<CR><Esc>h 

com! ClQFix call setqflist([])

" change dir to current file directory
au BufEnter * silent! lcd %:p:h
au BufRead,BufNewFile *.bhl set filetype=c
" Go back to the position the cursor was on the last time this file was edited
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")|execute("normal `\"")|endif

" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <F4> :ZoomToggle<CR>
