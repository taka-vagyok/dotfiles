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
" NeoBundle Plugins {{{1
"---------------------------------
" NeoBundle Config: Start Proc {{{5
set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))
"}}}5
" Manage NeoBundle {{{2
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundleLazy 'LeafCage/nebula.vim', {'autoload': {'commands': ['NebulaPutLazy', 'NebulaPutFromClipboard', 'NebulaYankOptions', 'NebulaYankConfig', 'NebulaPutConfig', 'NebulaYankTap']}}
NeoBundle 'Shougo/vimproc', {'build' : {
\	'windows': 'tools\\update-dll-mingw',
\	'cygwin' : 'make -f make_cygwin.mak',
\	'mac'	 : 'make -f make_mac.mak',
\	'linux'	 : 'make',
\	'unix' 	 : 'gmake',
\	}
\}
NeoBundleLazy 'Shougo/vimshell', { 'depends' : "Shougo/vimproc" , 'autoload': {'unite_sources': ['vimshell_external_history', 'vimshell_history', 'vimshell_zsh_complete'], 'mappings': [['n', '<Plug>(vimshell_']], 'commands': [{'complete': 'customlist,vimshell#complete', 'name': 'VimShell'}, {'complete': 'customlist,vimshell#complete', 'name': 'VimShellPop'}, {'complete': 'customlist,vimshell#complete', 'name': 'VimShellCreate'}, {'complete': 'customlist,vimshell#complete', 'name': 'VimShellCurrentDir'}, {'complete': 'customlist,vimshell#helpers#vimshell_execute_complete', 'name': 'VimShellExecute'}, {'complete': 'customlist,vimshell#complete', 'name': 'VimShellBufferDir'}, 'VimShellSendString', {'complete': 'customlist,vimshell#complete', 'name': 'VimShellTab'}, {'complete': 'customlist,vimshell#helpers#vimshell_execute_complete', 'name': 'VimShellTerminal'}, {'complete': 'customlist,vimshell#helpers#vimshell_execute_complete', 'name': 'VimShellInteractive'}, {'complete': 'buffer', 'name': 'VimShellSendBuffer'}]}}
" }}}2

" Common {{{2
NeoBundle 'edsono/vim-matchit' "Improve Japanese words for w/b
NeoBundle 'koron/codic-vim'    "Conding Dict
NeoBundle 'tyru/open-browser.vim'
NeoBundleLazy 'tyru/restart.vim', {'autoload': {'commands' : ['Restart']}}
NeoBundleLazy 'gregsexton/VimCalc', {'autoload': {'commands': ['Calc']}}
NeoBundleLazy 'itchyny/calendar.vim', {'autoload': {'commands': [{'complete': 'customlist,calendar#argument#complete', 'name': 'Calendar'}]}}
NeoBundleLazy 'mattn/benchvimrc-vim', {'autoload': {'commands': [{'complete': 'file', 'name': 'BenchVimrc'}]}}
" }}}2

" Memo {{{2 
NeoBundle 'fuenor/qfixgrep'
"NeoBundle 'glidenote/memolist.vim'
NeoBundleLazy 'glidenote/memolist.vim', { 'depends' : "vimfiler" , 'autoload': {'commands': ['MemoList', 'MemoGrep', 'MemoNew']}}
" }}}2

" Script Quick Test {{{2
NeoBundleLazy 'thinca/vim-quickrun', {'autoload': {'commands': [{'complete': 'customlist,quickrun#complete', 'name': 'QuickRun'}]}}
" }}}2

" File handling {{{2
NeoBundle 'Shougo/unite.vim'
NeoBundleLazy 'mbbill/VimExplorer', {'autoload': {'commands': [{'complete': 'file', 'name': 'VEC'}, {'complete': 'file', 'name': 'VE'}]}}
"NeoBundle 'Shougo/vimfiler.git'
NeoBundleLazy 'Shougo/vimfiler.git' , {'autoload' : {'commands' : [ "VimFilerTab" , "VimFiler" , "VimFilerExplorer" ]},'explorer' : 1}
 "}}}

" Writting Support {{{2
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Townk/vim-autoclose'
NeoBundleLazy 'tomtom/tcomment_vim.git', {'autoload': {'commands': [{'complete': 'customlist,tcomment#CompleteArgs', 'name': 'TCommentBlock'}, {'complete': 'customlist,tcomment#CompleteArgs', 'name': 'TCommentRight'}, {'complete': 'customlist,tcomment#CompleteArgs', 'name': 'TComment'}, {'complete': 'customlist,tcomment#CompleteArgs', 'name': 'TCommentMaybeInline'}, {'complete': 'customlist,tcomment#Complete', 'name': 'TCommentAs'}, {'complete': 'customlist,tcomment#CompleteArgs', 'name': 'TCommentInline'}]}}
"}}}2

" Markdown {{{2
NeoBundle 'godlygeek/tabular'
NeoBundle 'plasticboy/vim-markdown' , {'depends' : 'godlygeek/tabular'}
NeoBundle 'Shougo/unite-outline' , {'depends': 'Shougo/unite.vim' }
NeoBundleLazy 'kannokanno/previm', {'depends': 'tyru/open-browser.vim' , 'autoload': {'commands': ['PrevimOpen']}}
" }}}2

"Javascript{{{2
NeoBundle 'pangloss/vim-javascript'
"}}}2

"Visualize {{{2
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'chriskempson/vim-tomorrow-theme'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'vim-scripts/AnsiEsc.vim'
"}}}2

NeoBundle 'taka-vagyok/prevent-win-closed.vim'


"NeoBundle Config: End Proc{{{5
call neobundle#end()
filetype plugin indent on
NeoBundleCheck "Can be skip if you want to ask everytime up
" }}}5

"------------------------------
" }}}1 NeoBundle Plugins 
"------------------------------

"==================================
" NeoBundle Plugin Settings {{{1
"==================================

"QuickRun {{{2
" config{{{3
let s:bundle = neobundle#get("vim-quickrun")
function! s:bundle.hooks.on_source(bundle)
let g:quickrun_config={'*': {'hook/time/enable': 1},{'split':''} }
endfunction
unlet s:bundle
"}}}3
" For ez using :Tmp <ext> or :Temp <ext> (e.g. :Tmp py => we have tmp.py )
command! -nargs=1 -complete=filetype Tmp call EditTmpFile(<f-args>)
command! -nargs=1 -complete=filetype Temp call EditTmpFile(<f-args>)
function! EditTmpFile(ext)
	execute 'edit' $TMP.'/.vim_tmp/tmp.'.a:ext
endfunction
"}}} 

"memolist {{{2
let g:memolist_memo_suffix = ".md.txt"
let g:memolist_prompt_tags = 1
let g:memolist_qfixgrep = 1
let g:memolist_vimfiler = 1
let g:memolist_vimfiler_option ="" "No split
au BufNewFile,BufRead *.{md.txt,md,mdwn,mkd,mkdn,mark*} set filetype=markdown
"}}}

"vimfiler {{{2
let g:vimfiler_as_default_explorer = 1
let s:bundle = neobundle#get("vimfiler")
function! s:bundle.hooks.on_source(bundle)
	let g:vimfiler_data_directory = $TMP . '/.vimfiler'
	let g:vimfiler_safe_mode_by_default = 0
	"デフォルトのキーマッピングを変更
	"nnoremap <silent> <Leader>fe :<C-u>VimFilerBufferDir -quit<CR>
	"nnoremap <silent> <Leader>fi :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>
	augroup vimrc
		autocmd FileType vimfiler call s:vimfiler_my_settings()
	augroup END
	function! s:vimfiler_my_settings()
		nmap <buffer> q <Plug>(vimfiler_exit)
		nmap <buffer> Q <Plug>(vimfiler_hide)
	endfunction
endfunction
unlet s:bundle
"}}}

"indent-guide {{{2
let g:indent_guides_enable_on_vim_startup = 1
"}}}

"unite-outline {{{2
let g:unite_winwidth = 40
let g:unite_split_rule = "rightbelow"
nnoremap <silent> <Leader>o :<C-u>Unite -vertical -no-quit outline<CR>
"}}} 

"let g:prevent_win_closed_enable = 0 

"==================================
" }}}1 End NeoBundle Plugin Settings
"==================================


"==================================
" General Settings
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
set ruler
set incsearch
set showcmd
colorscheme Tomorrow-Night

" Easy Todo {{{
" Replace todo list on/off on Visual mode and Normal mode
nn <buffer> <Leader><Leader> :call ToggleCheckbox()<CR>
vn <buffer> <Leader><Leader> :call ToggleCheckbox()<CR>
function! ToggleCheckbox()
  let l:line = getline('.')
  if l:line =~ '^\-\s\[\s\]'
    let l:result = substitute(l:line, '^-\s\[\s]', '- [x]', '') . ' [Chkd:' . strftime('%Y/%m/%d %H:%M') . ']'
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


"%EOF
