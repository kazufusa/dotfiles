let OSTYPE = system('uname')

" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

" About searching word {{{
set ignorecase          " 大文字小文字を区別しない
set smartcase           " 検索文字に大文字がある場合は大文字小文字を区別
set incsearch           " インクリメンタルサーチ
set hlsearch             " 検索マッチテキストをハイライト

" バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'
" }}}

" About editing {{{
set shiftround          " '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set infercase           " 補完時に大文字小文字を区別しない
set virtualedit=all     " カーソルを文字が存在しない部分でも動けるようにする
set hidden              " バッファを閉じる代わりに隠す（Undo履歴を残すため）
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch           " 対応する括弧などをハイライト表示する
set matchtime=3         " 対応括弧のハイライト表示を3秒にする
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent

" 前回終了したカーソル行に移動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" set continuous number (ex. input "4co")
nnoremap <silent> co :ContinuousNumber <C-a><CR>
vnoremap <silent> co :ContinuousNumber <C-a><CR>
command! -count -nargs=1 ContinuousNumber let c = col('.')|for n in range(1, <count>?<count>-line('.'):1)|exec 'normal! j' . n . <q-args>|call cursor('.', c)|endfor

" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>

" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start

" クリップボードをデフォルトのレジスタとして指定。後にYankRingを使うので
" 'unnamedplus'が存在しているかどうかで設定を分ける必要がある
if has('unnamedplus')
    set clipboard& clipboard+=unnamedplus
else
    " set clipboard& clipboard+=unnamed,autoselect 2013-06-24 10:00 autoselect 削除
    set clipboard& clipboard+=unnamed
endif

" Swapファイル？Backupファイル？前時代的すぎ
" なので全て無効化する
set nowritebackup
set nobackup
set noswapfile
" }}}

" About display {{{
set list                " 不可視文字の可視化
set number              " 行番号の表示
set wrap                " 長いテキストの折り返し
set textwidth=0         " 自動的に改行が入るのを無効化
set colorcolumn=80      " その代わり80文字目にラインを入れる

" 起動時に折り畳み
set foldmethod=marker

" 前時代的スクリーンベルを無効化
set t_vb=
set novisualbell

" デフォルト不可視文字は美しくないのでUnicodeで綺麗に
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:«

set splitbelow "新しいウィンドウを下に開く
set splitright "新しいウィンドウを右に開く
set scrolloff=999  " カーソルを常に中央に
set cursorline "カーソル行の強調

set wildmode=list:full "コマンド候補表示の設定
set wildmenu "候補表示の設定

" Statusline {{{
set laststatus=2
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
" }}}
" }}}

" About macro and key settings {{{
nnoremap <Space>. :<C-u>tabe $MYVIMRC<CR>
nnoremap <Space>.. :<C-u>tabe ~/dotfiles/readme<CR>
"nnoremap <Space>w :write<CR>
nnoremap <Space>d :bd<CR>
nnoremap <Space>q :q<CR>
nnoremap <Space>a :qa<CR>
nnoremap <Space>o :only<CR>
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk

" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <Esc>

" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

" vを二回で行末まで選択
vnoremap v $h

" TABにて対応ペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %

" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

" T + ? で各種設定をトグル
nnoremap [toggle] <Nop>
nmap T [toggle]
nnoremap <silent> [toggle]s :setl spell!<CR>:setl spell?<CR>
nnoremap <silent> [toggle]l :setl list!<CR>:setl list?<CR>
nnoremap <silent> [toggle]t :setl expandtab!<CR>:setl expandtab?<CR>
nnoremap <silent> [toggle]w :setl wrap!<CR>:setl wrap?<CR>

" make, grep などのコマンド後に自動的にQuickFixを開く
autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen

" QuickFixおよびHelpでは q でバッファを閉じる
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %

" :e などでファイルを開く際にフォルダが存在しない場合は自動作成
function! s:mkdir(dir, force)
  if !isdirectory(a:dir) && (a:force ||
        \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction
autocmd MyAutoCmd BufWritePre * call s:mkdir(expand('<afile>:p:h'), v:cmdbang)

" vim 起動時のみカレントディレクトリを開いたファイルの親ディレクトリに指定
autocmd MyAutoCmd VimEnter * call s:ChangeCurrentDir('', '')
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang == ''
        pwd
    endif
endfunction

" ~/.vimrc.localが存在する場合のみ設定を読み込む
let s:local_vimrc = expand('~/.vimrc.local')
if filereadable(s:local_vimrc)
    execute 'source ' . s:local_vimrc
endif
" }}}

" codec settings{{{
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
set ambiwidth=double
" }}}

"tab settings {{{
nnoremap <Space>t :tabe<CR>
nnoremap <S-Tab> gt
nnoremap <Tab><Tab> gT
for i in range(1, 9)
    execute 'nnoremap <Tab>' . i . ' ' . i . 'gt'
endfor

set tabline=%!MyTabLine()

function! MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        " select the highlighting
        if i + 1 == tabpagenr()
              let s .= '%#TabLineSel#'
        else
              let s .= '%#TabLine#'
        endif
    
        " set the tab page number (for mouse clicks)
        let s .= '%' . (i + 1) . 'T'
    
        " the label is made by MyTabLabel()
        let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
    endfor
    
    " after the last tab fill with TabLineFill and reset tab page nr
    let s .= '%#TabLineFill#%T'
    
    " right-align the label to close the current tab page
    if tabpagenr('$') > 1
        let s .= '%=%#TabLine#%999XClose'
    endif
    
    return s
endfunction

let g:use_Powerline_dividers = 0

function! MyTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    let altbuf = bufname(buflist[winnr - 1])

    " $HOME を消す
    let altbuf = substitute(altbuf, expand('$HOME/'), '', '')

    " カレントタブ以外はパスを短くする
    if tabpagenr() != a:n
        let altbuf = substitute(altbuf, '^.*/', '', '')
        let altbuf = substitute(altbuf, '^.\zs.*\ze\.[^.]\+$', '', '')
    endif

    " vim-powerline のグリフを使う
    if g:use_Powerline_dividers
        let dividers = g:Pl#Parser#Symbols[g:Powerline_symbols].dividers
        let left_div = nr2char(get(dividers[3], 0, 124))
        let right_div = nr2char(get(dividers[1], 0, 124))
        let altbuf = left_div . altbuf . right_div
    else
        let altbuf = altbuf . '  <'
    endif

    " タブ番号を付加
    let altbuf = a:n . ':' . altbuf

    return altbuf
endfunction
"}}}

" binary mode (-b) {{{
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
"}}}

" About NeoBundle {{{

" Base settings before {{{
let s:noplugin = 0
let s:bundle_root = expand('~/.vim/bundle')
let s:neobundle_root = s:bundle_root . '/neobundle/'
if !isdirectory(s:neobundle_root) || v:version < 702
    " NeoBundleが存在しない、もしくはVimのバージョンが古い場合はプラグインを一切
    " 読み込まない
    let s:noplugin = 1
else
    " NeoBundleを'runtimepath'に追加し初期化を行う
    if has('vim_starting')
        execute "set runtimepath+=" . s:neobundle_root
    endif
    call neobundle#rc(s:bundle_root)

    " NeoBundle自身をNeoBundleで管理させる
    NeoBundleFetch 'Shougo/neobundle.vim'

    " 非同期通信を可能にする
    " 'build'が指定されているのでインストール時に自動的に
    " 指定されたコマンドが実行され vimproc がコンパイルされる
    NeoBundle "Shougo/vimproc", {
        \ "build": {
        \   "windows"   : "make -f make_mingw32.mak",
        \   "cygwin"    : "make -f make_cygwin.mak",
        \   "mac"       : "make -f make_mac.mak",
        \   "unix"      : "make -f make_unix.mak",
        \ }}
" }}}

" About neocomplcache {{{

NeoBundleLazy "Shougo/neocomplcache.vim", {
    \ "autoload": {
    \   "insert": 1,
    \ }}

let s:hooks = neobundle#get_hooks("neocomplcache.vim")
function! s:hooks.on_source(bundle)
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
    "NeoComplCacheEnable
endfunction
" }}}

" clang_complete  {{{
"" let g:clang_snippets=1
NeoBundle "Rip-Rip/clang_complete"
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
" }}}

" Shougo/neosnippet {{{
NeoBundleLazy "Shougo/neosnippet.vim", {
      \ "depends": ["honza/vim-snippets"],
      \ "autoload": {
      \   "insert": 1,
      \ }}
let s:hooks = neobundle#get_hooks("neosnippet.vim")
function! s:hooks.on_source(bundle)
    " Plugin key-mappings.
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)
    " SuperTab like snippets behavior.
    imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \: pumvisible() ? "\<C-n>" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \: "\<TAB>"
    " For snippet_complete marker.
    if has('conceal')
          set conceallevel=2 concealcursor=i
    endif
    " Enable snipMate compatibility feature.
    let g:neosnippet#enable_snipmate_compatibility = 1
    " Tell Neosnippet about the other snippets
    let g:neosnippet#snippets_directory=s:bundle_root . '/vim-snippets/snippets'
endfunction
" }}}

" thinca/vim-template {{{
NeoBundle "thinca/vim-template"
" テンプレート中に含まれる特定文字列を置き換える
autocmd MyAutoCmd User plugin-template-loaded call s:template_keywords()
function! s:template_keywords()
    silent! %s/<+DATE+>/\=strftime('%Y-%m-%d')/g
    silent! %s/<+FILENAME+>/\=expand('%:r')/g
endfunction
" テンプレート中に含まれる'<+CURSOR+>'にカーソルを移動
autocmd MyAutoCmd User plugin-template-loaded
    \   if search('<+CURSOR+>')
    \ |   silent! execute 'normal! "_da>'
    \ | endif
" }}}

" Shougo/unite {{{
NeoBundleLazy "Shougo/unite.vim", {
      \ "autoload": {
      \   "commands": ["Unite", "UniteWithBufferDir"]
      \ }}
NeoBundleLazy 'h1mesuke/unite-outline', {
      \ "autoload": {
      \   "unite_sources": ["outline"],
      \ }}
nnoremap [unite] <Nop>
nmap U [unite]
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]r :<C-u>Unite register<CR>
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
nnoremap <silent> [unite]t :<C-u>Unite tab<CR>
nnoremap <silent> [unite]w :<C-u>Unite window<CR>
let s:hooks = neobundle#get_hooks("unite.vim")
function! s:hooks.on_source(bundle)
  " start unite in insert mode
  let g:unite_enable_start_insert = 1
  " use vimfiler to open directory
  call unite#custom_default_action("source/bookmark/directory", "vimfiler")
  call unite#custom_default_action("directory", "vimfiler")
  call unite#custom_default_action("directory_mru", "vimfiler")
  autocmd MyAutoCmd FileType unite call s:unite_settings()
  function! s:unite_settings()
    imap <buffer> <Esc><Esc> <Plug>(unite_exit)
    nmap <buffer> <Esc> <Plug>(unite_exit)
    nmap <buffer> <C-n> <Plug>(unite_select_next_line)
    nmap <buffer> <C-p> <Plug>(unite_select_previous_line)
  endfunction
endfunction


" old settings unite-vim {{{
" key map {{{
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

" settings {{{
let g:unite_data_directory = $VIMLOCALUSER."~/.vim/.unite"
let g:unite_source_history_yank_enable=1

" file mru の保存数
let g:unite_source_file_mru_limit = 5000
let g:unite_source_file_mru2_limit = 200

" default action
call unite#custom_default_action('directory' , 'tabvimfiler')
call unite#custom_default_action("directory_mru", "vimfiler")
let g:vimfiler_as_default_explorer = 1
" }}}

" }}}

" }}}

" Shougo/vimfiler {{{
NeoBundleLazy "Shougo/vimfiler", {
      \ "depends": ["Shougo/unite.vim"],
      \ "autoload": {
      \   "commands": ["VimFilerTab", "VimFiler", "VimFilerExplorer"],
      \   "mappings": ['<Plug>(vimfiler_switch)'],
      \   "explorer": 1,
      \ }}
nnoremap <Leader>e :VimFilerExplorer<CR>
" close vimfiler automatically when there are only vimfiler open
autocmd MyAutoCmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
let s:hooks = neobundle#get_hooks("vimfiler")
function! s:hooks.on_source(bundle)
  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_enable_auto_cd = 1

  " vimfiler specific key mappings
  autocmd MyAutoCmd FileType vimfiler call s:vimfiler_settings()
  function! s:vimfiler_settings()
    " ^^ to go up
    nmap <buffer> ^^ <Plug>(vimfiler_switch_to_parent_directory)
    " use R to refresh
    nmap <buffer> R <Plug>(vimfiler_redraw_screen)
    " overwrite C-l
    nmap <buffer> <C-l> <C-w>l
  endfunction
endfunction
" }}}

" jedi-vim {{{
NeoBundleLazy "davidhalter/jedi-vim", {
      \ "autoload": {
      \   "filetypes": ["python", "python3", "djangohtml"],
      \   "build": {
      \     "mac": "pip install jedi",
      \     "unix": "pip install jedi",
      \   }
      \ }}
let s:hooks = neobundle#get_hooks("jedi-vim")
function! s:hooks.on_source(bundle)
  " jediにvimの設定を任せると'completeopt+=preview'するので
  " 自動設定機能をOFFにし手動で設定を行う
  let g:jedi#auto_vim_configuration = 0
  " 補完の最初の項目が選択された状態だと使いにくいためオフにする
  let g:jedi#popup_select_first = 0
  " quickrunと被るため大文字に変更
  let g:jedi#rename_command = '<Leader>R'
  " gundoと被るため大文字に変更 (2013-06-24 10:00 追記）
  let g:jedi#goto_command = '<Leader>G'
endfunction
" }}}

" quickrun {{{
NeoBundleLazy "thinca/vim-quickrun", {
      \ "autoload": {
      \   "mappings": [['nxo', '<Plug>(quickrun)']]
      \ }}
nmap <Leader>r <Plug>(quickrun)
let s:hooks = neobundle#get_hooks("vim-quickrun")
function! s:hooks.on_source(bundle)
    let g:quickrun_config = {
    \   "_" : {
    \       "outputter/buffer/split" : ":botright",
    \       "outputter/buffer/close_on_empty" : 1
    \   },
    \}
    let g:quickrun_config['_']['runner'] = 'vimproc'
    let g:quickrun_config['_']['runner/vimproc/updatetime'] = 100
    "let g:quickrun_config = {
    "  \ "*": {"runner": "remote/vimproc"},
    "  \ }
    " <C-c> で実行を強制終了させる
    nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
endfunction
" }}}

" clang_complete  {{{
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

" tagbar {{{ 
NeoBundle 'majutsushi/tagbar'
nmap <Leader>t :TagbarToggle<CR>
let g:tagbar_ctags_bin = '/usr/bin/ctags'
" }}}

" syntastic {{{
NeoBundle "scrooloose/syntastic" ",{
      " \ "build": {
      " \   "mac": ["pip install flake8", "npm -g install coffeelint"],
      " \   "unix": ["pip install flake8", "npm -g install coffeelint"],
      " \ }}
" }}}

" About python {{{
" Djangoを正しくVimで読み込めるようにする
NeoBundleLazy "lambdalisue/vim-django-support", {
      \ "autoload": {
      \   "filetypes": ["python", "python3", "djangohtml"]
      \ }}
" Vimで正しくvirtualenvを処理できるようにする
NeoBundleLazy "jmcantrell/vim-virtualenv", {
      \ "autoload": {
      \   "filetypes": ["python", "python3", "djangohtml"]
      \ }}
" }}}

" About Git {{{
NeoBundleLazy "mattn/gist-vim", {
      \ "depends": ["mattn/webapi-vim"],
      \ "autoload": {
      \   "commands": ["Gist"],
      \ }}

" vim-fugitiveは'autocmd'多用してるっぽくて遅延ロード不可
NeoBundle "tpope/vim-fugitive"
NeoBundleLazy "gregsexton/gitv", {
      \ "depends": ["tpope/vim-fugitive"],
      \ "autoload": {
      \   "commands": ["Gitv"],
      \ }}
" }}}

" vim-indent-guides {{{
NeoBundle "nathanaelkane/vim-indent-guides"
let g:indent_guides_enable_on_vim_startup = 1
" 自動カラーを無効にする
let g:indent_guides_auto_colors=0
" 奇数インデントのカラー
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#262626 ctermbg=green
" 偶数インデントのカラー
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3c3c3c ctermbg=cyan
" ハイライト色の変化の幅
let g:indent_guides_color_change_percent = 20
" ガイドの幅
let g:indent_guides_guide_size = 1

"}}}

" sjl/gundo {{{
NeoBundleLazy "sjl/gundo.vim", {
      \ "autoload": {
      \   "commands": ['GundoToggle'],
      \}}
nnoremap <Leader>g :GundoToggle<CR>
" }}}

" About text edit {{{
NeoBundle 'tpope/vim-surround'
NeoBundle 'vim-scripts/Align'
NeoBundle 'vim-scripts/YankRing.vim'
" }}}

" vim-pandoc {{{
" for syntax indent
NeoBundleLazy "vim-pandoc/vim-pandoc", {
      \ "autoload": {
      \   "filetypes": ["text", "pandoc", "markdown", "rst", "textile"],
      \ }}
" }}}

" memolist {{{
let g:memolist_path = "$HOME/Dropbox/memo"
let g:memolist_vimfiler = 1
let g:memolist_qfixgrep = 1
map <Space>mn  :MemoNew<CR>
map <Space>ml  :MemoList<CR>
map <Space>mg  :MemoGrep<CR>
"}}}

" vim-ref {{{
"webdict reffering site
NeoBundle 'thinca/vim-ref'
let g:ref_open = 'split'
let g:ref_source_webdict_sites = {
\ 'ej': {
\ 'url': 'http://ejje.weblio.jp/content/%s',
\ },
\ 'th': {
\ 'url': 'http://ejje.weblio.jp/english-thesaurus/content/%s',
\ },
\ 'wiki': {
\ 'url': 'http://ja.wikipedia.org/wiki/%s',
\ },
\ }

" default site
let g:ref_source_webdict_sites.default = 'ej'

" output filter
function! g:ref_source_webdict_sites.ej.filter(output)
  return join(split(a:output, "\n")[54 :], "\n")
endfunction
function! g:ref_source_webdict_sites.th.filter(output)
  return join(split(a:output, "\n")[47 :], "\n")
endfunction
function! g:ref_source_webdict_sites.wiki.filter(output)
  return join(split(a:output, "\n")[5 :], "\n")
endfunction

nnoremap <space>re :<C-u>Ref webdict ej<Space>
nnoremap <space>rt :<C-u>Ref webdict th<Space>
nnoremap <space>rw :<C-u>Ref webdict wiki<Space>
" }}}

" {{{ shareboard
" setup
" 1. % sudo aptitude install python-pyside
" 2. % pip install shareboard
" 3. % shareboard start
"    in other terminal
"    % shareboard set "Hello"
"    % shareboard get
"    Hello  <- OK?
" 4. shareboard start -v 
NeoBundleLazy "lambdalisue/shareboard.vim", {
      \ "autoload": {
      \   "commands": ["ShareboardPreview", "ShareboardCompile"],
      \ },
      \ "build": {
      \   "mac": "pip install shareboard",
      \   "unix": "pip install shareboard",
      \ }}
function! s:shareboard_settings()
  nnoremap <buffer>[shareboard] <Nop>
  nmap <buffer><Leader> [shareboard]
  nnoremap <buffer><silent> [shareboard]v :ShareboardPreview<CR>
  nnoremap <buffer><silent> [shareboard]c :ShareboardCompile<CR>
endfunction
autocmd MyAutoCmd FileType rst,text,pandoc,markdown,textile call s:shareboard_settings()
let s:hooks = neobundle#get_hooks("shareboard.vim")
function! s:hooks.on_source(bundle)
  " VimからPandocが見えないことが多々あるので念の為~/.cabal/binをPATHに追加
  let $PATH=expand("~/.cabal/bin:") . $PATH
endfunction
" }}}

" solarized {{{
NeoBundle "altercation/vim-colors-solarized"
syntax enable
let g:solarized_termtrans=1
set background=dark
colorscheme solarized
" }}}

" powerline {{{
"NeoBundle 'Lokaltog/vim-powerline'
" }}}

" python checker {{{
NeoBundle 'Flake8-vim'
NeoBundle 'hynek/vim-python-pep8-indent'
"保存時に自動でチェック
let g:PyFlakeOnWrite = 1
""解析種別を設定
let g:PyFlakeCheckers = 'pep8,mccabe,pyflakes'
"McCabe複雑度の最大値
"let g:PyFlakeDefaultComplexity=10
""visualモードでQを押すと自動で修正
let g:PyFlakeRangeCommand = 'Q'

" }}}

" Base settings after {{{
    " インストールされていないプラグインのチェックおよびダウンロード
    NeoBundleCheck
endif

" ファイルタイププラグインおよびインデントを有効化
" これはNeoBundleによる処理が終了したあとに呼ばなければならない
filetype plugin indent on
" }}}

" }}}

