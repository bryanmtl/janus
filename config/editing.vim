" automatically indent lines and try to do it intelligently
set autoindent
set smartindent

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" get out of insert mode easily
inoremap jj <ESC>

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc

" backspace behaves 'normally'
set backspace=indent,eol,start

set whichwrap+=<,>,h,l   " cursor keys also wrap

" spaces instead of tabs
set softtabstop=2
set tabstop=2
set shiftwidth=2
set expandtab

set autoread     " automatically reload a file if it's changed outside vim

" wrap settings
set nowrap       " wrap lines rather than use horiz. scrolling
set linebreak    " try not to wrap in the middle of a word
set textwidth=80 " 80-character lines maximum

" format settings
" t - Auto-wrap text using textwidth
" c - Auto-wrap comments using textwidth, inserting the current comment
"     leader automatically.
" r - Automatically insert the current comment leader after hitting <Enter>
"     in Insert mode.
" q - Allow formatting of comments with "gq".
"     Note that formatting will not change blank lines or lines containing
"     only the comment leader. A new paragraph starts after such a line,
"     or when the comment leader changes.
" n - When formatting text, recognize numbered lists.
" 2 - When formatting text, use the indent of the second line of a paragraph
"     for the rest of the paragraph, instead of the indent of the first line.
" 1 - Don't break a line after a one-letter word. It's broken before it
"     instead (if possible).
set formatoptions=tcrqn21

" Automatically restore cursor position when possible
autocmd BufReadPost *
   \ if line("'\"") > 1 && line("'\"") <= line("$") |
   \ exe "normal! g`\"" |
   \ endif

" Whitespace stuff
set list listchars=tab:\ \ ,trail:·
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

