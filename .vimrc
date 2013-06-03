set nocompatible
filetype off
filetype plugin indent off
let OSTYPE = system('uname')

"if OSTYPE == "Darwin\n"
"""ここにMac向けの設定
"elseif OSTYPE == "Linux\n"
"""ここにLinux向けの設定
"endif


" general settings {{{

set background=dark
colorscheme default  "desert molokai
"highlight on
syntax on

set nobackup
set hidden
let maplerder = ","
set autoread
set whichwrap=b,s,h,l,<,>,[,]
set wrapscan

" Set cursol position on center.
set scrolloff=999
" Tab and Indent Settings.
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
"set smartindent
augroup vimrc
autocmd! FileType CPP    setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd! FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
augroup END
""set autoindent
set cindent
" Beheivour of backspace.
set backspace=2
" Search settings.
set incsearch
set hlsearch
set ignorecase
set smartcase
" Autocomplite settings.
set wildmode=list:full
set wildmenu
" Convert "\" to "/" (for windows).
set shellslash
"Appearance settings.
set showcmd
set title
set ruler
set showmode
set number
" Display multibyte character with 2 chara width
set ambiwidth=double
set display=uhex
" Display statusline in everytime.
set laststatus=2
" Show invisible character.
set listchars=tab:>\-
" Statusline
set statusline=%{expand('%:p:t')}\ %<\(%{SnipMid(expand('%:p:h'),80-len(expand('%:p:t')),'...')}\)%=\ [%{&fenc}:%{&ff}%{&bomb?':BOM':''}:%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v]\ [%p%%]\ [LEN=%L]
function! SnipMid(str, len, mask)
  if a:len >= len(a:str)
    return a:str
  elseif a:len <= len(a:mask)
    return a:mask
  endif

  let len_head = (a:len - len(a:mask)) / 2
  let len_tail = a:len - len(a:mask) - len_head

  return (len_head > 0 ? a:str[: len_head - 1] : '') . a:mask . (len_tail > 0 ? a:str[-len_tail :] : '')
endfunction

" Highlight brackets
set showmatch
" Highlight invisible characters.
set list
set lazyredraw
set ttyfast
set clipboard=unnamed
set clipboard+=autoselect

set foldmethod=marker

set splitbelow "新しいウィンドウを下に開く
set splitright "新しいウィンドウを右に開く

" codec settings
"{{{
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif
" }}}
" }}}


" key mappings{{{
nnoremap <Space>. :<C-u>edit $MYVIMRC<CR>
nnoremap <Space>w :write<CR>
nnoremap <Space>d :bd<CR>
nnoremap <Space>q :q<CR>
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk
" }}}


" command groups{{{
" binary mode (-b)
augroup BinaryXXD
        autocmd!
        autocmd BufReadPre  *.bin let &binary =1
        autocmd BufReadPost * if &binary | silent %!xxd -g 1
        autocmd BufReadPost * set ft=xxd | endif
        autocmd BufWritePre * if &binary | %!xxd -r
        autocmd BufWritePre * endif
        autocmd BufWritePost * if &binary | silent %!xxd -g 1
        autocmd BufWritePost * set nomod | endif
augroup END

" set continuous number (ex. input "4co")
nnoremap <silent> co :ContinuousNumber <C-a><CR>
vnoremap <silent> co :ContinuousNumber <C-a><CR>
command! -count -nargs=1 ContinuousNumber let c = col('.')|for n in range(1, <count>?<count>-line('.'):1)|exec 'normal! j' . n . <q-args>|call cursor('.', c)|endfor

" 前回終了したカーソル行に移動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" Remove space at line last
autocmd BufWritePre * :%s/\s\+$//ge
" Replace tab with space
autocmd BufWritePre * :%s/\t/    /ge
"}}}


" template{{{
"python template
autocmd BufNewFile *.py 0r $HOME/.vim/template/python.txt
"}}}


" NeoBundle settings{{{
"NeoBundle basic settings {{{
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle/
endif
call neobundle#rc(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle'
" }}}

"NeoBundle list
" {{{
NeoBundle 'vim-scripts/SingleCompile'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
    \ 'windows' : 'make -f make_mingw32.mak',
    \ 'cygwin' : 'make -f make_cygwin.mak',
    \ 'mac' : 'make -f make_mac.mak',
    \ 'unix' : 'make -f make_unix.mak',
  \ },
  \ }
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/neocomplcache'
NeoBundle "Shougo/neosnippet.git"
NeoBundle 'Shougo/vimfiler'
NeoBundle 'vim-scripts/pythoncomplete'
NeoBundle 'mattn/mkdpreview-vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'hallison/vim-markdown'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'tomasr/molokai'
"NeoBundle 'taichouchou2/alpaca_powertabline'
"NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}
NeoBundle "tsukkee/unite-tag.git"
NeoBundle "ujihisa/unite-colorscheme"
NeoBundle 'altercation/vim-colors-solarized'
"use word search in browser, need 'sudo aptitude install w3m'
NeoBundle 'thinca/vim-ref'
NeoBundle "tpope/vim-fugitive"

" C++
NeoBundle "git://github.com/Rip-Rip/clang_complete.git"
NeoBundle "git://github.com/vim-jp/cpp-vim.git"

"  }}}

" settings of SCCompileRun
" {{{
nnoremap <Space>s :SCCompileRun<CR>
"}}}

" neocomplcache
" {{{

" active at startup
let g:neocomplcache_enable_at_startup=1

" entered key num
let g:neocomplcache_auto_completion_start_length=2

let g:neocomplcache_enable_ignore_case=0
let g:neocomplcache_enable_smart_case=0
let g:neocomplcache_enable_camel_case_completion=1
let g:neocomplcache_enable_underbar_completion=1

inoremap <expr><S-TAB> pumvisible() ? "\<Up>" : "\<S-TAB>"

" Plugin key-mappings for snippets.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)"
" \: pumvisible() ? "\<C-n>" : "\<TAB>"
imap <expr><TAB> pumvisible() ?
\ "\<C-n>" : neosnippet#jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

"<CR>（ENTER）で候補を閉じ改行
inoremap <expr><CR> neocomplcache#close_popup() . "\<CR>"

"1つ前の補完を取り消す
inoremap <expr><C-g> neocomplcache#undo_completion()

"<C-h>や<BS>を押したときに確実にポップアップを削除す
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"

"現在選択している候補を確定する
inoremap <expr><C-y> neocomplcache#close_popup()

"現在選択している候補をキャンセルし、ポップアップを閉じる
inoremap <expr><C-e> neocomplcache#cancel_popup()

let g:neocomplcache_enable_cursor_hold_i=0
let g:neocomplcache_max_list=1000

" for clang_complete
let g:neocomplcache_force_overwrite_completefunc=1
if !exists("g:neocomplcache_force_omni_patterns")
    let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|::'
" }}}

" clang_complete
"  {{{
"" let g:clang_snippets=1
let g:clang_complete_auto=0
let g:clang_auto_select=0
"let g:clang_sort_algo="alpha"
let g:clang_sort_algo="priority"
let g:clang_debug=1
let g:clang_user_options = '-std=c++11'
" exec or library use
if OSTYPE == "Darwin\n"
    let g:clang_exec="/usr/bin/clang"
elseif OSTYPE == "Linux\n"
    let g:clang_use_library=1
    let g:clang_library_path="/usr/lib/"
elseif has('win32') || has('win64')
endif
"" }}}

" neocomplcache が作成した tag ファイルのパスを tags に追加する
" {{{
function! s:TagsUpdate()
    " setlocal tags に neocomplcache が出力した tag ファイルのパスを追加する
    " include している tag ファイルが毎回同じとは限らないので1度初期化
    setlocal tags=
    for filename in neocomplcache#sources#include_complete#get_include_files(bufnr('%'))
        execute "setlocal tags+=".neocomplcache#cache#encode_name('tags_output', filename)
    endfor
endfunction

command!
    \ -nargs=? PopupTags
    \ Unite -default-action=tabdrop -immediately -direction=belowright -winheight=12 tag/include:<args>

function! s:get_func_name(word)
    let end = match(a:word, '<\|[\|(')
    return end == -1 ? a:word : a:word[ : end-1 ]
endfunction

noremap <silent> g<C-]> :<C-u>execute "PopupTags ".expand('<cword>')<CR>
noremap <silent> G<C-]> :<C-u>execute "PopupTags "
\.substitute(<SID>get_func_name(expand('<cWORD>')), '\:', '\\\:', "g")<CR>
nnoremap <Space>ns :execute "tabnew\|:NeoComplCacheEditSnippets ".&filetype<CR>
" }}}

" unite-vim
" {{{
" key map
" {{{
nnoremap <Space>ub :Unite buffer -input=!split<CR>
nnoremap <Space>ufm :Unite file_mru2<CR>
nnoremap <Space><Space>ufm :Unite file_mru<CR>
nnoremap <Space>udm :Unite directory_mru<CR>
nnoremap <Space>urm :UniteResume<CR>
nnoremap <Space>uff :Unite file<CR>
nnoremap <Space>uol :Unite outline<CR>
nnoremap <Space>unb :Unite neobundle<CR>
nnoremap <Space>ugr :Unite grep<CR><CR>
nnoremap <Space>um :Unite menu<CR>
nnoremap <Space>urrr :Unite rofi<CR>
nnoremap <Space>url :Unite reanimate -default-action=reanimate_load<CR>
nnoremap <Space>urs :Unite reanimate -default-action=reanimate_save<CR>
nnoremap <Space>umes :Unite output:mes<CR>
nnoremap <Space>uqh :Unite qfixhowm:nocache<CR>
nnoremap <Space>ubb :Unite boost-online-doc -default-action=ref_lynx_tabnew<CR>
 " nnoremap <Space>ub :Unite bookmark<CR>
 " nnoremap <Space>ucmd :Unite commandsCR>
 " nnoremap <Space>uw :Unite window<CR>
 " nnoremap <Space>ut :Unite tab<CR>
inoremap <C-y> <esc>:Unite history/yank -direction=belowright -winheight=12<CR>
" }}}

" settings
" {{{
call unite#custom_default_action('directory' , 'tabvimfiler')

let g:unite_data_directory = $VIMLOCALUSER."~/.vim/.unite"
let g:unite_source_history_yank_enable=1

" file mru の保存数
let g:unite_source_file_mru_limit = 5000
let g:unite_source_file_mru2_limit = 200

" default action
call unite#custom_default_action("directory_mru", "vimfiler")
" }}}

" }}}

" colorscheme solarized
" {{{
syntax enable
" setting of  background color transparently
let g:solarized_termtrans=1
set background=dark
"set background=light
colorscheme solarized
" }}}

" ref.vim
"{{{
"webdictサイトの設定
let g:ref_source_webdict_sites = {
\   'je': {
\     'url': 'http://dictionary.infoseek.ne.jp/jeword/%s',
\   },
\   'ej': {
\     'url': 'http://dictionary.infoseek.ne.jp/ejword/%s',
\   },
\   'wiki': {
\     'url': 'http://ja.wikipedia.org/wiki/%s',
\   },
\ }

"デフォルトサイト
let g:ref_source_webdict_sites.default = 'ej'

"出力に対するフィルタ。最初の数行を削除
function! g:ref_source_webdict_sites.je.filter(output)
  return join(split(a:output, "\n")[15 :], "\n")
endfunction
function! g:ref_source_webdict_sites.ej.filter(output)
  return join(split(a:output, "\n")[15 :], "\n")
endfunction
function! g:ref_source_webdict_sites.wiki.filter(output)
  return join(split(a:output, "\n")[17 :], "\n")
endfunction

nmap ,re :<C-u>Ref webdict<Space>
nmap <Leader>rj :<C-u>Ref webdict je<Space>
nmap <Leader>re :<C-u>Ref webdict ej<Space>
" }}}
" }}}


" quickrun.{{{
"let g:quickrun_config = {}
"let g:quickrun_config['_'] = {}
" カーソルを専用バッファに移動
"let g:quickrun_config = {
"       \  "_" : { "outputter/buffer/into" : 1,},}
"let g:quickrun_config = { '*' : {'shebang' : '0' }}
let g:quickrun_config = {
\   "_" : {
\       "outputter/buffer/split" : ":botright",
\       "outputter/buffer/close_on_empty" : 1
\   },
\}
let g:quickrun_config['_']['runner'] = 'vimproc'
let g:quickrun_config['_']['runner/vimproc/updatetime'] = 100
" <C-c> で実行を強制終了させる
" " quickrun.vim が実行していない場合には <C-c> を呼び出す
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
" }}}


filetype plugin indent on
