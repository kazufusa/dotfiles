let g:ref_cache_dir = expand('$CACHE/ref')
let g:ref_use_vimproc = 1
" if IsWindows()
"   let g:ref_refe_encoding = 'cp932'
" endif

" ref-lynx.
" if IsWindows()
"   let s:lynx = 'C:/lynx/lynx.exe'
"   let s:cfg  = 'C:/lynx/lynx.cfg'
"   let g:ref_lynx_cmd = s:lynx.' -cfg='.s:cfg.' -dump -nonumbers %s'
"   let g:ref_alc_cmd = s:lynx.' -cfg='.s:cfg.' -dump %s'
" endif

let g:ref_lynx_use_cache = 1
let g:ref_lynx_start_linenumber = 0 " Skip.
let g:ref_lynx_hide_url_number = 0

autocmd MyAutoCmd FileType ref call s:ref_my_settings()
function! s:ref_my_settings() abort "{{{
  " Overwrite settings.
  nmap <buffer> [Tag]t  <Plug>(ref-keyword)
  nmap <buffer> [Tag]p  <Plug>(ref-back)
  nnoremap <buffer> <TAB> <C-w>w
endfunction"}}}

let g:ref_source_webdict_sites = {
      \ 'weblio': {
      \   'url': 'http://ejje.weblio.jp/content/%s',
      \   'keyword_encoding': 'utf-8',
      \   'cache': 1
      \ } }

function g:ref_source_webdict_sites.weblio.filter(output)
  return join( split(a:output, "\n")[30 :], "\n" )
endfunction

" nnoremap [ref] <Nop>
" nmap     <Leader>r [ref]
nnoremap <expr> <C-e> ':Ref webdict weblio ' . expand('<cword>') . '<CR>'
vnoremap <C-e> "zy:Ref webdict weblio <C-r>"<CR>
autocmd FileType ref-* nnoremap <buffer> <silent> q :<C-u>close<CR>
