"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
let g:fzf_tags_command= 'ag -g "" | ctags -R --links=no -L -'
nnoremap ,p :Files<CR>
nnoremap ,t :Tags<CR>
nnoremap ,b :Buffers<CR>
nnoremap ,l :BTags<CR>
nnoremap ,w :call fzf#vim#tags(expand('<cword>'))<CR>

Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_file_list_command = 'ag -g ""'

Plug 'jlanzarotta/bufexplorer'
"map <silent> <F3> :call BufExplorerHorizontalSplit()<CR>
map <silent> <F3> :call ToggleBufExplorer()<CR>
let g:bufExplorerDefaultHelp = 0
let g:bufExplorerSplitHorzSize = 5
let g:bufExplorerSplitBelow = 1
let g:bufExplorerShowRelativePath = 0
let g:bufExplorerSplitOutPathName = 1

Plug 'mg979/vim-visual-multi', {'branch': 'master'}

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

Plug 'fatih/vim-go'
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_list_height = 10
let g:go_list_type = "quickfix"
nmap ,gr :GoReferrers<CR>

Plug 'leafoftree/vim-vue-plugin'

Plug 'OmniSharp/omnisharp-vim'
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_timeout = 5
let g:OmniSharp_server_use_mono = 1
let g:OmniSharp_popup_position = 'peek'
let g:OmniSharp_selector_ui = 'fzf'
nmap ,cu :OmniSharpFindUsages<CR>
nmap ,cd :OmniSharpGotoDefinition<CR>
nmap ,ci :OmniSharpFindImplementations<CR>
nmap ,cp :OmniSharpPreviewDefinition<CR>
augroup omnisharp_commands
    autocmd!
    autocmd FileType cs nnoremap <buffer> <C-]> :OmniSharpGotoDefinition<CR>
augroup END

set previewheight=5

Plug 'w0rp/ale'
let g:ale_linters = { 'cs': ['OmniSharp'], 'go' : ['gofmt', 'go vet', 'gopls']}
"NOTE: golint is too verbose
"let g:ale_linters = { 'cs': ['OmniSharp'], 'go' : ['gofmt', 'golint', 'go vet', 'gopls']}
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_lint_delay = 400
let g:ale_go_go_executable = 'go'
let g:ale_go_golint_executable = '/Users/pachanga/go/bin/golint'
let g:ale_go_gopls_executable = '/Users/pachanga/go/bin/gopls'
nmap <silent> <C-e> <Plug>(ale_next_wrap)

Plug 'rking/ag.vim'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
set completeopt=longest,menuone
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <TAB>
  \ <SID>check_back_space() ? "\<TAB>" :
  \ "\<C-x><C-o>"

Plug 'sjl/vitality.vim'
let g:vitality_always_assume_iterm = 1
au FocusLost * :up

Plug 'ronakg/quickr-preview.vim'
let g:quickr_preview_keymaps = 0
let g:quickr_preview_on_cursor = 0
let g:quickr_preview_position = 'below'
let g:quickr_preview_size = '9'
autocmd FileType qf nmap <space> <plug>(quickr_preview)

Plug 'vim-airline/vim-airline'
let g:airline_section_c = '%F'

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
set wildmode=longest,list
"set wildmode=longest:full
set encoding=utf-8
set nobackup
set noswapfile
set title
set hidden
set nohlsearch
"set laststatus=1
set lazyredraw
set autoindent
set smartindent
set noerrorbells        " No beeps.
set modeline            " Enable modeline.
set linespace=0         " Set line-spacing to minimum.
set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)

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

"NOTE: handled by airline
"" path
"set statusline+=%F
"" flags
"set statusline+=%m%r%h%w
"" encoding
"set statusline+=\ [%{strlen(&fenc)?&fenc:&enc}]
"" line x of y
"set statusline+=\ [line\ %l\/%L]

" auto-resize windows
autocmd VimResized * wincmd =

"set mouse=a

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" j,k should go into wrapped lines
map j gj
map k gk

function! ZoomCurrent()
  execute "tabnew +" . line('.') . " %"
endfunction

function! ZoomClose()
  tabclose
endfunction

" "Zoom" a split window into a tab and/or close it
com! ON call ZoomCurrent()
com! OF call ZoomClose()

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
nmap ,n :cn<CR><Esc>h 
nmap ,N :cp<CR><Esc>h 

com! ClQFix call setqflist([])

" save on escape
noremap <Esc><Esc> <Esc>:w<CR>
"autocmd InsertLeave * if expand('%') != '' | update | endif

" change dir to current file directory
au BufEnter * silent! lcd %:p:h
au BufRead,BufNewFile *.bhl set filetype=c
" Go back to the position the cursor was on the last time this file was edited
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")|execute("normal `\"")|endif

