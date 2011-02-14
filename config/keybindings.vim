" ;w saves a buffer
map <Leader>w :w!<CR>

" ;q closes a vim-window
map <Leader>q :q!<CR>

" EASY WINDOW NAVIGATION
"-------------------------------------------------
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" use C-j and C-k to 'bubble' lines (see
" http://vimcasts.org/episodes/bubbling-text/)
map <C-j> ddp
map <C-k> ddkP

" navigate around in buffers...
map <Leader>n :bnext<CR>
map <Leader>p :bprevious<CR>

" close all buffers but this one
map <Leader>bo :BufOnly<CR>

" switch ' and `, because:
" ' jumps to the start of the line where a mark is
" ` jumps to the exact location of a mark
" because jumping to the exact location is more useful,
" I like it to be closer to the home row, so I switch the keys.
noremap ' `
noremap ` '

nnoremap ;; :

