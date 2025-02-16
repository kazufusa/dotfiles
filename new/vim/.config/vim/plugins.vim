packadd vim-jetpack

call jetpack#begin(expand('~/.config/vim/jetpack'))
Jetpack 'tani/vim-jetpack', {'opt': 1} "bootstrap
Jetpack 'junegunn/fzf.vim'
Jetpack 'junegunn/fzf'
Jetpack 'vim-denops/denops.vim'
Jetpack 'vim-denops/denops-helloworld.vim'
Jetpack 'rafi/awesome-vim-colorschemes'
Jetpack 'luochen1990/rainbow'
Jetpack 'thinca/vim-quickrun'
call jetpack#end()

"---------------------------------------------------------------------------
" Fzf
"
let g:fzf_layout = { 'down': '~30%' }
let g:fzf_command_prefix = 'Fzf'
command! FzfFiles2 call fzf#run({
  \  'source' : 'ag --hidden --ignore .git --ignore node_modules --ignore vendor/bundle -g .',
  \  'dir'    : '.',
  \  'sink'   : 'e',
  \  'options': '-m -x +s',
  \  'down'   : '30%'})
command! -bang -nargs=? -complete=dir FzfFiles3 call
  \ fzf#vim#files(<q-args>, fzf#vim#with_preview({'source': 'ag --hidden --ignore .git -g "" | sort -r'}), <bang>0)
command! FzfGitFiles2 call fzf#run({
  \  'source' : 'ag --hidden --ignore .git --ignore node_modules --ignore vendor/bundle -g .',
  \  'dir'    : systemlist('git rev-parse --show-toplevel 2>/dev/null|| pwd')[0],
  \  'sink'   : 'e',
  \  'options': '-m -x +s',
  \  'down'   : '30%'})
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
nnoremap <silent><C-f>a :<C-u>FzfFiles3<CR>
nnoremap <silent><C-f>m :<C-u>FzfHistory<CR>
nnoremap <silent><C-f>f :<C-u>FzfGFiles<CR>
nnoremap <silent><C-f>d :<C-u>FzfGFiles?<CR>
nnoremap <silent><C-f>b :<C-u>FzfBuffers<CR>

"---------------------------------------------------------------------------
" colow schema
"
set background=dark
" let g:solarized_termcolors=256
" colorscheme solarized8_flat
" colorscheme iceberg
" colorscheme onedark
colorscheme challenger_deep
" colorscheme deus
" colorscheme seoul256

"---------------------------------------------------------------------------
" quickrun
"
nnoremap <silent> <Leader>r <Plug>(quickrun)
" let g:quickrun_config = {}
" let g:quickrun_config.javascript = {}
" let g:quickrun_config.javascript.type ='javascript/nodejs'

"---------------------------------------------------------------------------
" rainbow
"
let g:rainbow_active = 1
au MyAutoCmd VimEnter * nested RainbowToggleOn
