colorscheme ir_black

set laststatus=2   " always display a status line
set number         " show line numbers
set ruler          " display coordinates in status bar
set showcmd        " display unfinished commands
set showmatch      " show matching bracket (briefly jump)
set showmode       " display the current mode in the status bar
set title          " show file in titlebar

set synmaxcol=2048 " so we don't syntax color lines that are too long

" status bar
set statusline=
set statusline+=%f\                                           " filename
set statusline+=[%{strlen(&ft)?&ft:'none'}]                   " filetype
set statusline+=%h%1*%m%r%w%0*                                " flags
set statusline+=%=                                            " right align
set statusline+=%{fugitive#statusline()}                      " git status
set statusline+=%{exists('g:loaded_rvm')?rvm#statusline():''} " rvm status
set statusline+=(%l,%c%V)\ %<%P                               " offset

