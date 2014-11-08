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
NeoBundle 'thinca/vim-singleton'
NeoBundle 'deton/jasegment.vim'
if !has('kaoriya')
	NeoBundle 'deton/jasentence.vim'
endif
NeoBundle 'koron/codic-vim'    "Conding Dict
NeoBundle 'taka-vagyok/prevent-win-closed.vim'
NeoBundle 'tyru/open-browser.vim'
if has("win32") || has("win64")
	NeoBundleLazy 'mattn/startmenu-vim', {'autoload': {'unite_sources': ['startmenu'], 'commands': ['StartMenu']}}
endif
NeoBundleLazy 'tyru/restart.vim', {'autoload': {'commands' : ['Restart']}}
NeoBundleLazy 'gregsexton/VimCalc', {'autoload': {'commands': ['Calc']}}
NeoBundleLazy 'itchyny/calendar.vim', {'autoload': {'commands': [{'complete': 'customlist,calendar#argument#complete', 'name': 'Calendar'}]}}
NeoBundleLazy 'mattn/benchvimrc-vim', {'autoload': {'commands': [{'complete': 'file', 'name': 'BenchVimrc'}]}}
" }}}2

" Memo {{{2 
NeoBundle 'thinca/vim-fontzoom'
NeoBundleLazy 'fuenor/qfixgrep', {'autoload': {'commands': ['ToggleGrepRecursiveMode', 'REGrepadd', 'OpenQFixWin', 'RFGrep', 'BGrepadd', 'ToggleGrepCurrentDirMode', 'VGrepadd', 'RFGrepadd', 'MyGrepWriteResult', 'MyGrepReadResult', 'Vimgrep', 'BGrep', 'RGrepadd', 'Vimgrepadd', 'FGrep', 'MoveToAltQFixWin', 'ToggleMultiEncodingGrep', 'QFixAltWincmd', 'REGrep', 'QFdo', 'QFixCclose', 'RGrep', 'CloseQFixWin', 'EGrep', 'ToggleDamemoji', 'Grepadd', 'EGrepadd', 'MoveToQFixWin', 'Grep', 'ToggleLocationListMode', 'VGrep', 'ToggleQFixWin', 'FList', 'FGrepadd', 'QFixCopen']}}
"NeoBundle 'glidenote/memolist.vim'
NeoBundleLazy 'glidenote/memolist.vim', { 'depends' : "vimfiler" , 'autoload': {'commands': ['MemoList', 'MemoGrep', 'MemoNew']}}
" }}}2

" Script Quick Test {{{2
NeoBundleLazy 'thinca/vim-quickrun', {'autoload': {'mappings': [['sxn', '<Plug>(quickrun']], 'commands': [{'complete': 'customlist,quickrun#complete', 'name': 'QuickRun'}]}}
" }}}2

" File handling {{{2
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundleLazy 'kien/ctrlp.vim', {'autoload': {'commands': ['CtrlPMixed', 'CtrlPClearAllCaches', 'CtrlPCurWD', 'CtrlP', 'CtrlPRTS', 'CtrlPBuffer', 'CtrlPMRUFiles', 'CtrlPBookmarkDirAdd', 'CtrlPDir', 'CtrlPRoot', 'CtrlPChange', 'ClearCtrlPCache', 'CtrlPLine', 'ClearAllCtrlPCaches', 'CtrlPBufTagAll', 'CtrlPClearCache', 'CtrlPQuickfix', 'CtrlPBufTag', 'CtrlPTag', 'CtrlPCurFile', 'CtrlPLastMode', 'CtrlPUndo', 'CtrlPChangeAll', 'CtrlPBookmarkDir']}}
NeoBundleLazy 'mbbill/VimExplorer', {'autoload': {'commands': [{'complete': 'file', 'name': 'VEC'}, {'complete': 'file', 'name': 'VE'}]}}
NeoBundleLazy 'Shougo/vimfiler.git' , {'autoload' : {'commands' : [ "VimFilerTab" , "VimFiler" , "VimFilerExplorer" ]},'explorer' : 1}
 "}}}

" Writting Support {{{2
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Townk/vim-autoclose'
"NeoBUndle 'jiangmiao/auto-pairs'
NeoBundle 'tpope/vim-surround'
NeoBundle 'vim-trailing-whitespace'
NeoBundle  'junegunn/vim-easy-align', { 'autoload': {'commands' : ['EasyAlign'] }}
NeoBundle 'AndrewRadev/linediff.vim'
NeoBundleLazy 'tomtom/tcomment_vim.git', {'autoload': {'commands': [{'complete': 'customlist,tcomment#CompleteArgs', 'name': 'TCommentBlock'}, {'complete': 'customlist,tcomment#CompleteArgs', 'name': 'TCommentRight'}, {'complete': 'customlist,tcomment#CompleteArgs', 'name': 'TComment'}, {'complete': 'customlist,tcomment#CompleteArgs', 'name': 'TCommentMaybeInline'}, {'complete': 'customlist,tcomment#Complete', 'name': 'TCommentAs'}, {'complete': 'customlist,tcomment#CompleteArgs', 'name': 'TCommentInline'}]}}
"}}}2

" Tagging {{{
" [TODO] -I is not worked my mingw64. so I need to add include path to make
" file and build by my self.
if has('win32') || has('win64')
	if executable('mingw32-make')
		let g:mingw_include = 'C:/bin/mingw64/include/'
		NeoBundle 'vim-jp/ctags', { 'build' : { 'windows' : 'mingw32-make.exe -I ' . g:mingw_include . ' -f mk_mingw.mak' , } }
	else
		NeoBundle 'vim-jp/ctags'
	endif
	if !exists("g:load_my_tag_path")
		let g:load_my_tag_path = 1
		" Add ctags to my repository
		let $PATH = $PATH . ";" . $HOME . "/.vim/bundle/ctags"
	endif
endif
if executable('ctags')
	NeoBundleLazy 'majutsushi/tagbar', {'augroup': 'TagbarAutoCmds', 'autoload': {'commands': ['TagbarGetTypeConfig', 'TagbarSetFoldlevel', 'TagbarOpen', 'TagbarDebug', 'Tagbar', 'TagbarClose', 'TagbarTogglePause', 'TagbarOpenAutoClose', 'TagbarDebugEnd', 'TagbarCurrentTag', 'TagbarShowTag', 'TagbarToggle']}}
endif
"}}}

" Markdown {{{2
NeoBundle 'godlygeek/tabular'
NeoBundle 'plasticboy/vim-markdown' , {'depends' : 'godlygeek/tabular'}
NeoBundle 'Shougo/unite-outline' , {'depends': 'Shougo/unite.vim' }
NeoBundleLazy 'kannokanno/previm', {'depends': 'tyru/open-browser.vim' , 'autoload': {'commands': ['PrevimOpen']}}
" }}}2

"Javascript{{{2
NeoBundle 'pangloss/vim-javascript'
"}}}2

" C# {{{
NeoBundle 'OrangeT/vim-csharp' "syntax
" MSBuild is in C:\\Windows
" ex) C:\Windows\Microsoft.NET\Framework64\v4.0.30319
" set path to such a path
if executable('python') && executable('msbuild')
NeoBundleLazy 'nosami/Omnisharp', {
\   'autoload': {'filetypes': ['cs'], 'commands' : ['OmniSharpStartServer', 'OmniSharpStartServerSolution']},
\   'build': {
\     'windows': 'MSBuild.exe server/OmniSharp.sln /p:Platform="Any CPU"',
\     'mac': 'xbuild server/OmniSharp.sln',
\     'unix': 'xbuild server/OmniSharp.sln',
\   }
\ }
endif
" }}}

"Visualize {{{2
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'chriskempson/vim-tomorrow-theme'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'vim-scripts/AnsiEsc.vim'
NeoBundle 'kien/rainbow_parentheses.vim'
"}}}2

" Redmine {{{
NeoBundle 'mattn/webapi-vim'
"ref[rmine:http://blog.basyura.org/entry/20130106/p1]
NeoBundle 'basyura/rmine.vim'
"}}}

" cmigeo {{{2
"NeoBundle 'haya14busa/cmigemo' 
"NeoBundleLazy 'koron/cmigemo', {
"\   'build': {
"\	  'windows': 'mingw32-make -f compile/Make_mingw.mak',
"\   }
"\ }
" }}}2 

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
let g:memolist_memo_suffix = "md.txt"
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

" CTRLP {{{
if has("win32") || has("win64")
	let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'
endif
"}}}
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
" [TODO] plugin
let g:toggle_complete_tag = "Done"
nn <buffer> <Leader><Leader> :call ToggleCheckbox()<CR>
vn <buffer> <Leader><Leader> :call ToggleCheckbox()<CR>
function! ToggleCheckbox()
  let l:line = getline('.')
  if l:line =~ '^\-\s\[\s\]'
    let l:result = substitute(l:line, '^-\s\[\s]', '- [x]', '') . ' [' . g:toggle_complete_tag . ':' . strftime('%Y/%m/%d %H:%M') . ']'
    call setline('.', l:result)
  elseif l:line =~ '^\-\s\[x\]'
    let l:result = substitute( substitute(l:line, '^-\s\[x\]', '- [ ]', '') , '\s\[' . g:toggle_complete_tag . ':\d\{4}.\+]$' , '','')
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

" Binary Edit {{{
augroup BinaryXXD
  autocmd!
  autocmd BufReadPre  *.bin let &binary =1
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | execute "%!xxd -r" | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END
"}}}

" ColorSyntax {{{2
augroup omnisharp_commands
    autocmd!
    "Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
    autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
    " Synchronous build (blocks Vim)
    "autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
    " Builds can also run asynchronously with vim-dispatch installed
    autocmd FileType cs nnoremap <leader>b :wa!<cr>:OmniSharpBuildAsync<cr>
    " automatic syntax check on events (TextChanged requires Vim 7.4)
    autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck
    " Automatically add new cs files to the nearest project on save
    autocmd BufWritePost *.cs call OmniSharp#AddToProject()
    "show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()
augroup END


" () をハイライト
augroup rainbowparentheses
	au VimEnter * RainbowParenthesesToggle
	au Syntax * RainbowParenthesesLoadRound
	au Syntax * RainbowParenthesesLoadSquare
	au Syntax * RainbowParenthesesLoadBraces
augroup END
"2}}}

set rtp+=$HOME/.vim/
runtime!  conf.d/*.vim

"%EOF
