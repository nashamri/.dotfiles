" .vimrc
" Based on the .vimrc of Steve Losh <steve@stevelosh.com>
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Author: Nasser Alshammari <designernasser@gmail.com>
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"
"Preamble =================================================================={{{

call plug#begin()

"Plugins
Plug 'junegunn/goyo.vim'
Plug 'klen/python-mode'
Plug 'ervandew/supertab'
Plug 'vim-scripts/taglist.vim'
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-markdown'
Plug 'DrawIt'

"Depends on other software
"gem install redcarpet pygments.rb
"npm -g install instant-markdown-d
Plug 'suan/vim-instant-markdown'

"Colorschemes
Plug 'nashamri/tir_black'

call plug#end()

"}}}

"Basic Options ============================================================={{{

"Basic {{{
set nocompatible 
set encoding=utf-8
set fileencoding=utf-8
set modelines=0
set autoindent
set showmode
set showcmd
set wildmenu
set hidden
set visualbell
set ttyfast "For fast scrolling
set ruler
set backspace=indent,eol,start "Make backspace works normally
set nonumber
set norelativenumber
set laststatus=2 "Always show the status line
set history=1000 "How many command-lines are remembered
set undofile
set undoreload=10000
set nolist
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set shell=/bin/bash\ --login
set lazyredraw "Make macros fast
set matchtime=3 "Time to show the matching pair
set showbreak=↪
set splitbelow
set splitright
set fillchars=diff:⣿,vert:│
set autowrite
set autoread
set shiftround "Use multiple of shiftwidth when indenting with '<' and '>'
set title
set linebreak
set t_Co=256
set foldmethod=marker
set mouse=a

"Tabs, spaces, wrapping
set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab
set wrap
set textwidth=80
set formatoptions=qrn1
set colorcolumn=+1

"Make vim use the system clipboard
set clipboard=unnamedplus

"Better Completion
set complete=.,w,b,u,t
set completeopt=longest,menuone,preview

"Resize splits when the window is resized
au VimResized * :wincmd =

"Leader
let mapleader = ","
let maplocalleader = "\\"

"}}}
"Cursorline {{{

"Only show cursorline in the current window and in normal mode.
augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END

"}}}
"Backups {{{

set backup
set noswapfile

set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files

"Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

"}}}
"Searching {{{

"Enable 'very magic' mode
nnoremap / /\v
vnoremap / /\v

set ignorecase "Ignores the case when searching
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault "Eliminate the need for the /g flag when substitution

set scrolloff=3
set sidescroll=1
set sidescrolloff=10

set virtualedit+=block

" Clear search maches
noremap <localleader>c :noh<cr>:call clearmatches()<cr>

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Don't move on *
nnoremap * *<c-o>
"}}}
"Folding {{{
set foldlevelstart=0

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" "Focus" the current line.  Basically:
"
" 1. Close all folds.
" 2. Open just the folds containing the current line.
" 3. Move the line to the center of the screen.
"
" This mapping wipes out the z mark, which I never use.
"
" I use :sus for the rare times I want to actually background Vim.
nnoremap <c-z> mzzMzvzz<c-e>`z<cr>

function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction 
set foldtext=MyFoldText()
"}}}
"Gvim {{{
set guioptions-=r  "No scrollbar on the right
set guioptions-=R  "No scrollbar on the right when there are splits
set guioptions-=l  "No scrollbar on the left
set guioptions-=L  "No scrollbar on the left when there are splits
set guioptions-=m  "No menu
set guioptions-=T  "No toolbar
"}}}
"Colorscheme {{{
syntax on
colorscheme tir_black
"}}}

"}}}

"Key mappings =============================================================={{{

"Use jj to exit insert mode
imap jj <Esc>

"Toggle line numbers
nnoremap <leader>n :setlocal number!<cr>

"Toggle hidden chars
nnoremap <leader>l :setlocal list!<cr>

"Toggle arabic 
nnoremap <leader>a :setlocal arabic!<cr>

"Clean trailing whitespace
nnoremap <leader>w mz:%s/\s\+$//<cr>:let @/=''<cr>`z

"Keep the cursor in place while joining lines
nnoremap J mzJ`z

"Split line (sister to [J]oin lines)
"The normal use of S is covered by cc, so don't worry about shadowing it.
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

"Select (charwise) the contents of the current line, excluding indentation.
"Great for pasting Python lines into REPLs.
nnoremap vv ^vg_

"Made D behave
nnoremap D d$

"Go to top of the screen
"noremap T H

"Go to bottom of the screen
"noremap Y L

"Easier to type 
noremap H ^
noremap L $
vnoremap L g_

"Heresy
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A

"Easy buffer navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

noremap <leader>v <C-w>v
noremap <leader>h <C-w>s

"Windows resizing
nnoremap <c-left> 5<c-w>>
nnoremap <c-right> 5<c-w><
nnoremap <c-up> 5<c-w>-
nnoremap <c-down> 5<c-w>+

"no shift for command mode
nnoremap ; :

"Sudo to write
cnoremap w!! w !sudo tee % >/dev/null

"Easier braces jumping with <tab>
map <tab> %

"Toggling Error list with F7
function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location panel
        Errors
    endif
endfunction

nnoremap <F7> :call ToggleErrors()<cr>

"Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

"When having long lines, make j and k move up and down
nnoremap j gj
nnoremap k gk

"Turn on British english spellchecking
noremap <localleader>s :setlocal spell spelllang=en_gb<cr>

"Quick Editing {{{

nnoremap <leader>ev :e $MYVIMRC<cr>

"}}}

"}}}

"Plugins ==================================================================={{{

"Goyo {{{
nnoremap <s-F11> :Goyo <cr>
"}}}
"Supertab {{{
"Make the selection start from the top
let g:SuperTabDefaultCompletionType = "<c-n>"
"}}}
"Python-mode {{{
"Python version
let g:pymode_python = 'python' "options 'python', 'python3'
"Folding
let g:pymode_folding = 0
"Only code complete when I press CTRL+SPACE
let g:pymode_rope_complete_on_dot = 0
"}}}
"Taglist {{{
"Toggle
nnoremap <silent> <F8> :TlistToggle<cr>

"Set the focus to the taglist window
let Tlist_GainFocus_On_ToggleOpen = 1

"Only show one file
let Tlist_Show_One_File = 1
"}}}
"Ultisnip {{{
"Jumping to next and previous
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
"}}}
"Instant-markdown
let g:instant_markdown_autostart = 0
"}}}
