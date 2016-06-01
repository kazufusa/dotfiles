"" key-mappings
" swap line/normal visual mode
noremap V v
noremap v V

" yank to the end of line
nnoremap Y y$

" remove spaces at the end of lines
nnoremap <silent> ,<Space> :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>

" C-s to file saving
" `$ stty -ixon -ixoff` is need
nnoremap <C-s> :<C-u>w<CR>
inoremap <C-s> <ESC>:<C-u>w<CR>
vnoremap <C-s> :<C-u>w<CR>
cnoremap <C-s> <C-u>w<CR>

" diff
nnoremap <silent> <expr> ,d ":\<C-u>".(&diff?"diffoff":"diffthis")."\<CR>"

" tags
nnoremap <C-@> <C-t>

" Command-line mode keymappings:
" <C-a>, A: move to head.
cnoremap <C-a>          <Home>
" <C-b>: previous char.
cnoremap <C-b>          <Left>
" <C-d>: delete char.
cnoremap <C-d>          <Del>
" <C-e>, E: move to end.
cnoremap <C-e>          <End>
" <C-f>: next char.
cnoremap <C-f>          <Right>
" <C-n>: next history.
cnoremap <C-n>          <Down>
" <C-p>: previous history.
"cnoremap <C-p>          <Up>

" IME
if executable("fcitx-remote")
  inoremap <silent> <C-[> <ESC>:call system('fcitx-remote -c')<CR>
endif
