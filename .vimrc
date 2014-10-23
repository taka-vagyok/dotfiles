" temp colorscheme for indent plugin {{{
set background=dark
colorscheme evening
"}}}
" temp directory detect{{{
if $TMP == ''
 	let $TMP = '/tmp'
endif
if !isdirectory($TMP.'/.vim_tmp')
	call mkdir($TMP.'/.vim_tmp')
endif
"}}}
"---------------------------------
" Start Neobundle Settings. {{{
"---------------------------------
set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))
"Manage neo bundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Common {{{
NeoBundle 'tyru/restart.vim'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimproc'
NeoBundle 'edsono/vim-matchit' "Improve Japanese words for w/b
NeoBundle 'gregsexton/VimCalc'
NeoBundle 'koron/codic-vim'
" }}} 

" Memo {{{
NeoBundle 'glidenote/memolist.vim'
NeoBundle 'fuenor/qfixgrep'
" }}}

" Script Quick Test {{{
NeoBundle 'thinca/vim-quickrun'
" }}}

" File handling {{{
NeoBundle 'Shougo/unite.vim'
NeoBundle 'mbbill/VimExplorer'
NeoBundle 'Shougo/vimfiler.git'
NeoBundle 'kmnk/vim-unite-giti.git'
NeoBundle 'eiginn/netrw'
 "}}}

" Writting Support {{{
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'tomtom/tcomment_vim.git'
"}}}

"Markdown {{{
NeoBundle 'godlygeek/tabular'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'
"}}}

"Visualize {{{
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'chriskempson/vim-tomorrow-theme'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'vim-scripts/AnsiEsc.vim'
"}}}


call neobundle#end()
" Required:
filetype plugin indent on

" Can be skip if you want to ask everytime up
NeoBundleCheck 
"------------------------------
" }}} End Neobundle Settings.
"------------------------------

"==================================
" NeoBundle Plugin Settings {{{
"==================================

"QuickRun {{{
let g:quickrun_config={'*': {'split':''}}
let g:quickrun_config={'*': {'hook/time/enable': 1},}
" temporally file for quickrun
" u can use :Tmp <ext> or :Temp <ext> (e.g. :Tmp py => we have tmp.py )
command! -nargs=1 -complete=filetype Tmp call EditTmpFile(<f-args>)
command! -nargs=1 -complete=filetype Temp call EditTmpFile(<f-args>)
function! EditTmpFile(ext)
	execute 'edit' $TMP.'/.vim_tmp/tmp.'.a:ext
endfunction
"}}} 

"memolist {{{
let g:memolist_memo_suffix = ".md.txt"
let g:memolist_qfixgrep = 1
let g:memolist_prompt_tags = 1
au BufNewFile,BufRead *.{md.txt,md,mdwn,mkd,mkdn,mark*} set filetype=markdown
"}}}

"vimfiler {{{
let g:vimfiler_data_directory = $TMP . '/.vimfiler'
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0
 
"デフォルトのキーマッピングを変更
nnoremap <silent> <Leader>fe :<C-u>VimFilerBufferDir -quit<CR>
nnoremap <silent> <Leader>fi :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>
augroup vimrc
	autocmd FileType vimfiler call s:vimfiler_my_settings()
augroup END
function! s:vimfiler_my_settings()
	nmap <buffer> q <Plug>(vimfiler_exit)
	nmap <buffer> Q <Plug>(vimfiler_hide)
endfunction
"}}}

"indent-guide {{{
let g:indent_guides_enable_on_vim_startup = 1
"}}}

"unite-outline {{{
let g:unite_winwidth = 40
let g:unite_split_rule = "rightbelow"
nnoremap <silent> <Leader>o :<C-u>Unite -vertical -no-quit outline<CR>
"}}} 

"==================================
" }}} End NeoBundle Plugin Settings
"==================================


"==================================
" General 
"==================================
set noswapfile
set nobackup
set noundofile
set tabstop=4
set shiftwidth=4
set clipboard+=unnamed  "Enable Windows Clipbord
set background=dark
set nonumber
set splitbelow "新しいウィンドウを下に開く
set splitright "新しいウィンドウを右に開く
set foldmethod=marker
colorscheme Tomorrow-Night

" Easy Todo {{{
" Replace todo list on/off on Visual mode and Normal mode
nn <buffer> <Leader><Leader> :call ToggleCheckbox()<CR>
vn <buffer> <Leader><Leader> :call ToggleCheckbox()<CR>
function! ToggleCheckbox()
  let l:line = getline('.')
  if l:line =~ '^\-\s\[\s\]'
    let l:result = substitute(l:line, '^-\s\[\s]', '- [x]', '') . ' [Done:' . strftime('%Y/%m/%d %H:%M') . ']'
    call setline('.', l:result)
  elseif l:line =~ '^\-\s\[x\]'
    let l:result = substitute( substitute(l:line, '^-\s\[x\]', '- [ ]', '') , '\s\[Done:\d\{4}.\+]$' , '','')
    call setline('.', l:result)
  end
endfunction
" }}}

"IME control for windows {{{
inoremap <silent> <ESC> <ESC>
inoremap <silent> <C-[> <ESC>
inoremap <silent> <C-j> <C-^>
"}}}

"Encoding Check{{{
if !has('kaoriya')
	set encoding=utf-8
	set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8
endif
"}}}
