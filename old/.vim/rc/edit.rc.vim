"---------------------------------------------------------------------------
" Edit:
"

set autoread
set nopaste
set tabstop=2
set softtabstop=2
set backspace=indent,eol,start
set nohidden
set noautowrite
set scrolloff=10
set nobackup
set backupcopy=yes
set nowritebackup
set noswapfile

" Highlight parenthesis.
set showmatch
" Highlight when CursorMoved.
set cpoptions-=m
set matchtime=1
" Highlight <>.
set matchpairs+=<:>

" Smart insert tab setting.
set smarttab
" Exchange tab to spaces.
set expandtab
" Autoindent width.
set shiftwidth=2
" Round indent by shiftwidth.
set shiftround

" Enable smart indent.
set autoindent smartindent

augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab
augroup END

" Enable modeline.
set modeline

" Use clipboard register.

if (!has('nvim') || $DISPLAY != '') && has('clipboard')
  if has('unnamedplus')
     set clipboard& clipboard^=unnamedplus
  else
     set clipboard& clipboard^=unnamed
  endif
endif

" Enable backspace delete indent and newline.
set backspace=indent,eol,start

" Highlight parenthesis.
set showmatch
" Highlight when CursorMoved.
set cpoptions-=m
set matchtime=1
" Highlight <>.
set matchpairs+=<:>

" Display another buffer when current buffer isn't saved.
set hidden

" Auto reload if file is changed.
" set autoread

" Ignore case on insert completion.
set infercase

" Search home directory path on cd.
" But can't complete.
"  set cdpath+=~

" Enable folding.
set foldenable
" set foldmethod=expr
set foldmethod=marker
" Show folding level.
set foldcolumn=1
set fillchars=vert:\|
set commentstring=%s

if exists('*FoldCCtext')
  " Use FoldCCtext().
   set foldtext=FoldCCtext()
endif

" Use vimgrep.
" set grepprg=internal
" Use grep.
set grepprg=grep\ -inH

" Exclude = from isfilename.
set isfname-==

" Keymapping timeout.
set timeout timeoutlen=3000 ttimeoutlen=100

" CursorHold time.
set updatetime=1000

" Set swap directory.
set directory-=.

if v:version >= 703
  " Set undofile.
   set undofile
  let &g:undodir=&directory
endif

if v:version < 703 || (v:version == 7.3 && !has('patch336'))
  " Vim's bug.
   set notagbsearch
endif

" Enable virtualedit in visual block mode.
set virtualedit=block

" Set keyword help.
set keywordprg=:help

" Check timestamp more for 'autoread'.
autocmd MyAutoCmd WinEnter * checktime

" Disable paste.
autocmd MyAutoCmd InsertLeave *
      \ if &paste | setlocal nopaste | echo 'nopaste' | endif |
      \ if &l:diff | diffupdate | endif

" Update diff.
autocmd MyAutoCmd InsertLeave * if &l:diff | diffupdate | endif

" Make directory automatically.
" --------------------------------------
" http://vim-jp.org/vim-users-jp/2011/02/20/Hack-202.html

autocmd MyAutoCmd BufWritePre *
      \ call s:mkdir_as_necessary(expand('<afile>:p:h'), v:cmdbang)
function! s:mkdir_as_necessary(dir, force) abort
  if !isdirectory(a:dir) && &l:buftype == '' &&
        \ (a:force || input(printf('"%s" does not exist. Create? [y/N]',
        \              a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

" Use autofmt.
set formatexpr=autofmt#japanese#formatexpr()

" Use blowfish2
" https://dgl.cx/2014/10/vim-blowfish
if has('cryptv')
  " It seems 15ms overhead.
  "  set cryptmethod=blowfish2
endif


" Restore cursor to file position in previous editing session
autocmd MyAutoCmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Re-select visual block after indenting
vnoremap > >gv
vnoremap < <gv

" clipboard settings for WSL2
" let output = system("iswsl")
" if v:shell_error == 0
"   " https://qiita.com/tMinamiii/items/0c6589806090c7fc3f8a
"   augroup Yank
"     au!
"     autocmd TextYankPost * :call system('win32yank.exe -i &', @")
"   augroup END
"   " https://github.com/miyase256/chikuwansible/blob/64da4b46695cbc21d744255f5c994713523cee82/src_files/nvim/init/windows.vim
"   " nnoremap <silent>p :r !win32yank.exe -o<CR>
"   " vnoremap <silent>p :r !win32yank.exe -o<CR>
"   " nnoremap <silent><S-p> :.-1read !win32yank.exe -o<CR>
"   " vnoremap <silent><S-p> :.-1read !win32yank.exe -o<CR>
"   nnoremap <silent>p "=system('win32yank.exe -o --lf')<CR>p
"   vnoremap <silent>p "=system('win32yank.exe -o --lf')<CR>p
"   nnoremap <silent><S-p> "=system('win32yank.exe -o --lf')<CR><S-p>
"   vnoremap <silent><S-p> "=system('win32yank.exe -o --lf')<CR><S-p>
" endif
