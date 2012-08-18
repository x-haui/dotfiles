"----------------coding-------------
" folding
set foldmethod=syntax
syn region cBlock start="{" end="}" transparent fold
set foldcolumn=3
" all folds are open
set foldlevel=100
"
function GetPerlFold()
  if getline(v:lnum) =~ '^\s*sub\s'
    return ">1"
  elseif getline(v:lnum) =~ '\}\s*$'
    let my_perlnum = v:lnum
    let my_perlmax = line("$")
    while (1)
      let my_perlnum = my_perlnum + 1
      if my_perlnum > my_perlmax
        return "<1"
      endif
      let my_perldata = getline(my_perlnum)
      if my_perldata =~ '^\s*\(\#.*\)\?$'
        " do nothing
      elseif my_perldata =~ '^\s*sub\s'
        return "<1"
      else
        return "="
      endif
    endwhile
  else
    return "="
  endif
endfunction
setlocal foldexpr=GetPerlFold()
setlocal foldmethod=expr
set nofoldenable

""""
set tabstop=4
"set expandtab
set shiftwidth=4
"set shiftround
"""
" syntax/indenting etc.
syntax on
set smartindent 
set nocopyindent
filetype on
filetype plugin on
set shell=bash
"show matching braces
set showmatch
"
"set/unset ai when pasting code
set pastetoggle=<F12>
"
" Auto close braces
imap { {<CR>}<Esc>O
imap ( ()<left>
imap [ []<left>
" everybody loves C-style comments...
"imap // /**/<left><left>
"
" abbreviations
ia #i #include
"
"------find & replace------
" ignore case
set ic
" smart search - case sensitive when first char is uppercase
set smartcase
" Jump to the current typed in search term	
set incsearch
"
"------misc------
" backspace may delete these items
set backspace=indent,eol,start
" number of commands saved in history
set history=100
" highlight searched term
set hlsearch
set modified
" http://www.linux-fuer-blinde.de/programme/index.php
set scroll=11
set backup
" enable mouse-support
set mouse=a
" confirmation dialogues
set cf
" keep buffers alive
set hidden
" status bar always visible 
"se laststatus=2
colorscheme peachpuff
" sets the title of the windows to "filename"
set title
" set line numbers
set number
" not vi-compatible
set nocompatible
set fileformat=unix

"---------macros----------
" map for normal/visual mode | map! for command/insert mode

" some useful abbreviations to common mistyped commands
cab W w| cab Q q| cab Wq wq| cab wQ wq| cab WQ wq| cab q1 q!| cab Q1 q!| cab Q! q!


" show/hide TagList						
map <F2> :TlistToggle <Enter> :set ttymouse=xterm2 <Enter>

" save file & Update Tlist in all modes
map <F3> :w <Enter> :TlistUpdate <Enter>
map! <F3> <ESC> :w <Enter> :TlistUpdate <Enter>


" enables/disables hlsearch - see http://vim.wikia.com/wiki/VimTip93
map <F4> :set nohls!<CR>:set nohls?<CR>

" Ctrl-c: compile the current file 
"imap <C-c> <ESC> :w <Enter> :! gcc -ansi -pedantic -D_POSIX_SOURCE -Werror -Wall -o %:r % <Enter>
"map <C-c> <ESC> :w <Enter> :! gcc -ansi -pedantic -D_POSIX_SOURCE -Werror -Wall -o %:r % <Enter>
"map! <C-c> <ESC> :w <Enter> :! gcc -ansi -pedantic -D_POSIX_SOURCE -Werror -Wall -o %:r % <Enter>
"imap <C-c> <ESC> :w <Enter> :! gcc -Wall -lm -o %:r % <Enter>
"map <C-c> <ESC> :w <Enter> :! gcc  -Wall -lm -o %:r % <Enter>

" save & "make" the current file in all modes
map <F5> :w <Enter> :make <Enter>
map! <F5>  <ESC> :w <Enter> :make <Enter>

" save file in all modes
map! <F6> <ESC> :w <Enter>
map <F6> :w <Enter>
 
" save & close file in all modes
imap <F7> "<Esc> :wq<Cr>"
map <F7> :wq <Enter>

" show tabs, carriage returns etc. 
map <F8> :set nolist!<CR>:set nolist?<CR>
map! <F8> <ESC> :set nolist!<CR>:set nolist?<CR>

" toggle line numbers
map <F11> :set nonu!<CR>:set nonu?<CR>
map! <F11> <ESC> :set nonu!<CR>:set nonu?<CR>


" toggle-word-plugin - 0<=>1 | true<=>false etc.
nmap ,t :ToggleWord<CR>

au BufNewFile,BufRead ~/.bash_aliases           setf sh

" REQUIRED. This makes vim invoke latex-suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
"set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse latex-suite. Set your grep
" program to alway generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

"python, perl, shell comments in visual Mode using gC/gc
vmap gC :s/^/#/<CR>:noh<CR>
vmap gc :s/^#//<CR>:noh<CR>

autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

nmap <C-W>e :new \| vimshell bash<CR>
nmap <C-W>E :vnew \| vimshell bash<CR>

map Y y$


" Show the line and column number of the cursor position, separated by a comma.
set ruler
"function! SwitchSourceHeader()
"  "update!
"  if (expand ("%:t") == expand ("%:t:r") . ".cc")
"    find %:t:r.h
"  else
"    find %:t:r.cc
"  endif
"endfunction
"
"nmap ,s :call SwitchSourceHeader()<CR>


" check perl code with :make
autocmd FileType perl set makeprg=perl\ -c\ %\ $*
autocmd FileType perl set errorformat=%f:%l:%m
"autocmd FileType perl set autowrite
nnoremap <silent> _t :%!perltidy -q<Enter>
vnoremap <silent> _t :!perltidy -q<Enter>
":imap dumper <ESC>^iwarn Data::Dumper->Dump([\<ESC>llyw$a], ['<ESC>pa']);<ESC>
autocmd BufNewFile *.pl 0r ~/.vim/skeletons/perl | :normal G


autocmd BufNewFile *.c 0r ~/.vim/skeletons/c | :normal G


set viminfo='20,<50,s10,n~/.vim/viminfo
set statusline=%f%m%r%h%w\ (ff=%{&ff})\ (fenc=%{&fenc})\ (ftype=%Y)\ (ASCII=\%03.3b)\ (HEX=\%02.2B)\ (XY=%04l,%03v-%p%%)\ (nol=%L)
set laststatus=2                            " always show statusline
set matchtime=5                             " highlight matching bracket for given tenth of seconds
set scrolloff=2
set wildmenu                                " set wildmenu on
set synmaxcol=200
set ttymouse=xterm2
set tags=./tags;
 map <C-\> :tab split<CR>:exec("ts ".expand("<cword>"))<CR>

