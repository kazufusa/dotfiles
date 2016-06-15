"" key-mappings
" swap line/normal visual mode
noremap V v
noremap v V

" yank to the end of line
nnoremap Y y$

" remove spaces at the end of lines
nnoremap <silent> ,<Space> :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>

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
" C-s to file saving
" `$ stty -ixon -ixoff` is need
if executable("fcitx-remote")
  nnoremap <silent> <C-s> :<C-u>w<CR>:call system('fcitx-remote -c')<CR>
  inoremap <silent> <C-s> <ESC>:<C-u>w<CR>:call system('fcitx-remote -c')<CR>
  vnoremap <silent> <C-s> :<C-u>w<CR>:call system('fcitx-remote -c')<CR>
  cnoremap <silent> <C-s> <C-u>w<CR>:call system('fcitx-remote -c')<CR>

  inoremap <silent> <C-[> <ESC>:call system('fcitx-remote -c')<CR>
else
  nnoremap <silent> <C-s> :<C-u>w<CR>
  inoremap <silent> <C-s> <ESC>:<C-u>w<CR>
  vnoremap <silent> <C-s> :<C-u>w<CR>
  cnoremap <silent> <C-s> <C-u>w<CR>
endif
