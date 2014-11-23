" Add runtime path
set rtp+=$HOME/.vim/

" temp colorscheme for indent plugin {{{
"set background=dark
"colorscheme evening
"}}}

" Environment {{{
function! VimrcEnvironment()
	let env = {}
	let env.is_win = has('win32') || has('win64')
	let user_dir =  '~/.vim'
	"let user_dir =  expand('~/.vim')
	let env.path = {
				\ 	'user':          user_dir,
				\ 	'local_vimrc':   user_dir . 'conf.d/*.vim',
				\ 	'bundledir':     user_dir . '/bundle',
				\ 	'neobundle':     user_dir . '/bundle/neobundle.vim',
				\ 	'localbundle':   user_dir . '/local.budle.conf',
				\ 	'tmp':           has("$TMP") ? $TMP.'/.vim_tmp' : '/tmp',
				\ }
	let env.url = {
				\ 'neobundle': 'https://github.com/Shougo/neobundle.vim',
				\}
	return env
endfunction

function! VimrcSupports()
	let supports = {}
	"[Todo] bunddle support environment
	let supports.git = executable('git')
	let supports.neobundle = 0
	let supports.loaded_neobundle = 0
	"let supports.neobundle =  isdirectory( expand(s:env.path.neobundle . "/" . "autoload" ))
	let supports.neocomplete = has('lua')
				\ && (v:version > 703 || (v:version == 703 && has('patch885')))
	let supports.loadedneobundles = 0
	return supports
endfunction

function! InstallNeoBundleIfNot()
	" If cannot find neobundle/autoload directory clone from github
	" ( not exist, it is not polite condition)
	"if !s:supports.neobundle
	if !isdirectory( expand(s:env.path.neobundle . "/" . "autoload" ))
		if s:supports.git
			try
				execute( "!git clone " . s:env.url.neobundle . " " . expand(s:env.path.neobundle) )
			catch /:E117:/
				echo "Cannot find neobundle and fail to git clone(" . s:env.url.neobundle .")"
				return 0
			endtry
			" Update support condition
			return 1
		else
			echo "Cannot find neobundle directory and git command."
			return 0
		endif
	endif
	return 1
endfunction

let s:env = VimrcEnvironment()
let g:supports = VimrcSupports()
let g:supports.neobundle = InstallNeoBundleIfNot()
" }}}


"  temp directory detect{{{
if $TMP == ''
 	let $TMP = '/tmp'
endif
if !isdirectory($TMP.'/.vim_tmp')
	call mkdir($TMP.'/.vim_tmp')
endif
"}}}


"==========================================
" All NeoBundle Configulation{{{1
"==========================================
function! SetMyNeobundleEnable()
"---------------------------------
 " Install NeoBundle Plugins {{{2
"---------------------------------
" NeoBundle Config: Start Proc {{{5
execute "set runtimepath+=" . s:env.path.neobundle
call neobundle#begin( expand( s:env.path.bundledir . "/" ))
runtime! conf.neobundle.d/*.vim "for each enviroments bundles
"}}}5
"  Manage NeoBundle {{{3
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
"}}}3

" Common {{{3
NeoBundle 'thinca/vim-singleton' "Prevent multi window
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
"}}}3

" Memo {{{3
NeoBundle 'thinca/vim-fontzoom'
NeoBundleLazy 'fuenor/qfixgrep', {'autoload': {'commands': ['ToggleGrepRecursiveMode', 'REGrepadd', 'OpenQFixWin', 'RFGrep', 'BGrepadd', 'ToggleGrepCurrentDirMode', 'VGrepadd', 'RFGrepadd', 'MyGrepWriteResult', 'MyGrepReadResult', 'Vimgrep', 'BGrep', 'RGrepadd', 'Vimgrepadd', 'FGrep', 'MoveToAltQFixWin', 'ToggleMultiEncodingGrep', 'QFixAltWincmd', 'REGrep', 'QFdo', 'QFixCclose', 'RGrep', 'CloseQFixWin', 'EGrep', 'ToggleDamemoji', 'Grepadd', 'EGrepadd', 'MoveToQFixWin', 'Grep', 'ToggleLocationListMode', 'VGrep', 'ToggleQFixWin', 'FList', 'FGrepadd', 'QFixCopen']}}
NeoBundleLazy 'glidenote/memolist.vim', { 'depends' : "vimfiler" , 'autoload': {'commands': ['MemoList', 'MemoGrep', 'MemoNew']}}
"}}}3

" Script Quick Test {{{3
NeoBundle 'thinca/vim-quickrun'
"}}}3

" File handling {{{3
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundleLazy 'kien/ctrlp.vim', {'autoload': {'commands': ['CtrlPMixed', 'CtrlPClearAllCaches', 'CtrlPCurWD', 'CtrlP', 'CtrlPRTS', 'CtrlPBuffer', 'CtrlPMRUFiles', 'CtrlPBookmarkDirAdd', 'CtrlPDir', 'CtrlPRoot', 'CtrlPChange', 'ClearCtrlPCache', 'CtrlPLine', 'ClearAllCtrlPCaches', 'CtrlPBufTagAll', 'CtrlPClearCache', 'CtrlPQuickfix', 'CtrlPBufTag', 'CtrlPTag', 'CtrlPCurFile', 'CtrlPLastMode', 'CtrlPUndo', 'CtrlPChangeAll', 'CtrlPBookmarkDir']}}
NeoBundleLazy 'mbbill/VimExplorer', {'autoload': {'commands': [{'complete': 'file', 'name': 'VEC'}, {'complete': 'file', 'name': 'VE'}]}}
NeoBundleLazy 'Shougo/vimfiler.git' , {'autoload' : {'commands' : [ "VimFilerTab" , "VimFiler" , "VimFilerExplorer" ]},'explorer' : 1}
"}}}3

" Writting Support {{{3
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Townk/vim-autoclose'
"NeoBUndle 'jiangmiao/auto-pairs'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle  'junegunn/vim-easy-align', { 'autoload': {'commands' : ['EasyAlign'] }}
NeoBundle 'AndrewRadev/linediff.vim'
NeoBundleLazy 'tomtom/tcomment_vim.git', {'autoload': {'commands': [{'complete': 'customlist,tcomment#CompleteArgs', 'name': 'TCommentBlock'}, {'complete': 'customlist,tcomment#CompleteArgs', 'name': 'TCommentRight'}, {'complete': 'customlist,tcomment#CompleteArgs', 'name': 'TComment'}, {'complete': 'customlist,tcomment#CompleteArgs', 'name': 'TCommentMaybeInline'}, {'complete': 'customlist,tcomment#Complete', 'name': 'TCommentAs'}, {'complete': 'customlist,tcomment#CompleteArgs', 'name': 'TCommentInline'}]}}
"}}}3

" Tagging {{{3
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
"}}}3

" Markdown {{{3
NeoBundle 'godlygeek/tabular'
NeoBundle 'plasticboy/vim-markdown' , {'depends' : 'godlygeek/tabular'}
NeoBundle 'Shougo/unite-outline' , {'depends': 'Shougo/unite.vim' }
NeoBundleLazy 'kannokanno/previm', {'depends': 'tyru/open-browser.vim' , 'autoload': {'commands': ['PrevimOpen']}}
"}}}3

"Java ascript{{{3
NeoBundle 'pangloss/vim-javascript'
"}}}3

" C# {{{3
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
" }}}3

"Visualize {{{3
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'vim-scripts/AnsiEsc.vim'
NeoBundle 'kien/rainbow_parentheses.vim'
"colorscheme
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'chriskempson/vim-tomorrow-theme'
"}}}3

" Redmine {{{3
NeoBundle 'mattn/webapi-vim'
"ref[rmine:http://blog.basyura.org/entry/20130106/p1]
NeoBundle 'basyura/rmine.vim'
" }}}3

" cmigeo {{{3
" [Todo] Fix that building automatically
"NeoBundle 'haya14busa/cmigemo'
"NeoBundleLazy 'koron/cmigemo', {
"\   'build': {
"\	  'windows': 'mingw32-make -f compile/Make_mingw.mak',
"\   }
"\ }
" }}}3

" Presentation {{3
NeoBundle "sotte/presenting.vim"
NeoBundle "thinca/vim-showtime"
"}}}3

" Ref Doc {{{3
NeoBundleLazy 'thinca/vim-ref', {'autoload': {'unite_sources': ['ref'], 'mappings': [['sxn', '<Plug>(ref-keyword)']], 'commands': [{'complete': 'customlist,ref#complete', 'name': 'Ref'}, 'RefHistory']}}
" }}}3

" Web access {{{3
if executable("w3m")
	NeoBundle "yuratomo/w3m.vim"
endif
"}}}3

" NeoBundle Config: End Proc{{{5
call neobundle#end()
filetype plugin indent on
NeoBundleCheck "Can be skip if you want to ask everytime up
" }}}5


"------------------------------
"  }}}2 Install NeoBundle Plugins
"------------------------------

"------------------------------
" Configure NeoBundle Plugins {{{2
"------------------------------

 "QuickRun {{{3
" config{{{4
let s:bundle = neobundle#get("vim-quickrun")
function! s:bundle.hooks.on_source(bundle)
let g:quickrun_config={'*': {'hook/time/enable': 1},{'split':''} }
endfunction
unlet s:bundle
"}}}4
" For ez using :Tmp <ext> or :Temp <ext> (e.g. :Tmp py => we have tmp.py )
command! -nargs=1 -complete=filetype Tmp call EditTmpFile(<f-args>)
command! -nargs=1 -complete=filetype Temp call EditTmpFile(<f-args>)
function! EditTmpFile(ext)
	execute 'edit' $TMP.'/.vim_tmp/tmp.'.a:ext
endfunction
"}}}3

"memolist {{{3
let g:memolist_memo_suffix = "md.txt"
let g:memolist_prompt_tags = 1
let g:memolist_qfixgrep = 1
let g:memolist_vimfiler = 1
let g:memolist_vimfiler_option ="" "No split
au BufNewFile,BufRead *.{md.txt,md,mdwn,mkd,mkdn,mark*} set filetype=markdown
"}}}3

"vimfiler {{{3
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
"}}}3

"indent-guide {{{3
set background=dark
colorscheme evening
let g:indent_guides_enable_on_vim_startup = 1
"}}}3

"unite-outline {{{3
let g:unite_winwidth = 40
let g:unite_split_rule = "rightbelow"
nnoremap <silent> <Leader>o :<C-u>Unite -vertical -no-quit outline<CR>
"}}}3

" CTRLP {{{3
if has("win32") || has("win64")
	let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'
endif
"}}}3

" neocomplete{{{3
let g:neocomplete#acp_enableAtStartUp = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 4
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME . '/.cache/.vimshell/command_history'
    \ }
"Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
	let g:neocomplete#sources#omni#input_patterns = {}
endif
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
"}}}3

" W3M {{{3
"let g:w3m#command = ''
"}}}3

"----------------------------------------
" }}}2 End of Configure NeoBundle Plugins
"----------------------------------------
return 1
endfunction
let g:supports.loaded_neobundle = SetMyNeobundleEnable()
"==========================================
"}}}1 End of All NeoBundle Configulation
"==========================================

"==================================
" General Settings
"==================================
set noswapfile
set nobackup
set noundofile
set tabstop=4
set shiftwidth=4
set clipboard+=unnamed  "Enable Windows Clipbord
set nonumber
set splitbelow "新しいウィンドウを下に開く
set splitright "新しいウィンドウを右に開く
set foldmethod=marker
set ruler
set incsearch
set showcmd
set modeline
set modelines=5

" ファイルを開いたときに, カレントディレクトリを編集中のファイルディレクトリに変更
augroup filelcd
  autocmd!
  autocmd BufEnter * lcd %:p:h
augroup END

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
if !has("gui-running")
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
inoremap <silent> <C-[> <ESC>
inoremap <silent> <C-j> <C-^>
endif
" }}}

"Add Encording if not kaoriya vim{{{
if !has('kaoriya')
	set encoding=utf-8
	set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8
endif
"} }}

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

if g:supports.neobundle
	set background=dark
	colorscheme Tomorrow-Night
else
	set background=dark
	colorscheme evening
endif
if g:supports.neobundle
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
endif

"set rtp+=$HOME/.vim/
execute "runtime! " . s:env.path.local_vimrc

"%EOF
