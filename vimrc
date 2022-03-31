"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"store lots of :cmdline history
set history=1000

set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom

set nohlsearch

"statusline setup
set statusline=%f       "tail of the filename

" set fileformat to unix,dos if on windows
if has('win64') || has('win32')
	set fileformats=unix,dos
	set encoding=utf-8
	set shell=c:/Progra~1/PowerShell/7/pwsh.exe
	set shellcmdflag=-command
	set shellquote=\"
	set shellxquote=
endif

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h      "help file flag
set statusline+=%y      "filetype
set statusline+=%r      "read only flag
set statusline+=%m      "modified flag

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"recalculate the long line warning when idle and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

"indent settings
"set shiftwidth=4
"set softtabstop=4
"set expandtab
"set autoindent

"folding settings
set nofoldenable        "dont fold by default
" and turn off folding forever!
map zi <Nop>
map zc <Nop>
map zo <Nop>
map za <Nop>
map zC <Nop>
map zO <Nop>
map zA <Nop>
map zr <Nop>
map zR <Nop>
map zm <Nop>
map zM <Nop>
map zf <Nop>
map zF <Nop>
map zd <Nop>
map zD <Nop>
map zE <Nop>
map zv <Nop>
map zx <Nop>
map zX <Nop>
map zn <Nop>
map zN <Nop>

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

set formatoptions-=o "dont continue comments when pushing o/O

"vertical/horizontal scroll off settings
set scrolloff=0
set sidescrolloff=0
set sidescroll=0

"load ftplugins and indent files
filetype plugin on
filetype indent off

"some stuff to get the mouse going in term
set mouse=a
if !has('nvim')
	set ttymouse=xterm2
endif

set t_Co=0

"use system clipboard
set clipboard=unnamed

"hide buffers when not displayed
set hidden

"dont load csapprox if we no gui support - silences an annoying warning
if !has("gui")
    let g:CSApprox_loaded = 1
endif

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

"map Q to something useful
noremap Q gq

"make Y consistent with C and D
nnoremap Y y$

if has("gui")
	let moria_style = "black"
	let moria_monochrome = 1
	colorscheme moria
	if has('win64') || has('win32')
		set guifont=Meslo_LG_S:h9
		set columns=80
		set lines=60
	endif
endif
"let g:SuperTabDefaultCompletionType = "context"
filetype indent off
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

let mapleader = ","
let g:mapleader = ","
map <leader>ss :setlocal spell!<cr>
" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=
" quick show line number
map <leader>l :set nu!<CR>

" communism and freedom
map ,cccp :set sw=4 sts=4 expandtab<cr>
map ,usa :set sw=8 sts=0 noexpandtab<cr>
" 2 space tabs are needed too. That's not exactly freedom either.
map ,prc :set sw=2 sts=2 expandtab<cr>

"turn on syntax highlighting
syntax off
