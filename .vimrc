" ================================
" Environment/Supports {{{1
" ================================
function! VimrcEnvironment()
    let env = {}
    let env.is_win = has('win32') || has('win64')
    let user_dir =  '~/.vim'
    let env.path = {
                \ 	'user':          user_dir,
                \ 	'bundledir':     user_dir . '/bundle',
                \ 	'neobundle':     user_dir . '/bundle/neobundle.vim',
                \ 	'local_vimrcs':  'conf.d',
                \ 	'local_bundle':  'conf.d.bundle',
                \ 	'tmp':           has("$TMP") ? $TMP.'/.vim_tmp' : '/tmp',
                \ }
    let env.github = 'https://github.com/'
    let env.term_mycolo = {
                \ 'name': 'term_forrest' ,
                \ 'bgcolor': 'dark' ,
                \ 'url': env.github . 'taka-vagyok/term_forrest_cls.vim',
                \ 'path': env.path.bundledir . '/term_forrest_cls.vim',
                \ }
    let env.gui_mycolo = {
                \ 'name': 'lucius',
                \ 'bgcolor': 'light' ,
                \ 'url': env.github . 'jonathanfilip/vim-lucius',
                \ 'path': env.path.bundledir . '/vim-lucius',
                \ }
    if has('gui')
        let env.mycolo = env.gui_mycolo
    else
        let env.mycolo = env.term_mycolo
    endif
    let env.url = {
                \ 'neobundle': env.github . 'Shougo/neobundle.vim',
                \ }
    return env
endfunction

function! VimrcSupports()
    let supports = {}
    "[Todo] bunddle support environment
    let supports.git = executable('git')
    let supports.neobundle = 0
    let supports.mycolorscheme = 0
    let supports.loaded_neobundle = 0
    let supports.neocomplete = has('lua')
                \ && (v:version > 703 || (v:version == 703 && has('patch885')))
    let supports.loadedneobundles = 0
    return supports
endfunction

function! InstallNeoBundleIfNot(dlurl,dlpath)
    " <TODO> catch error download
    "if !isdirectory( expand( a:dlpath . "/" . "autoload" ))
    if !isdirectory( expand( a:dlpath ))
        if g:supports.git
            try
                execute("r !git clone " . a:dlurl . " " . expand(a:dlpath))
            catch /:E117:/
                echo "E117: Fail to git clone(" . a:dlurl .")"
                return 0
            endtry
            return 1
        else
            echo "Error: Cannot fetch " . a:dlurl
            return 0
        endif
    endif
    return 1
endfunction

let s:env = VimrcEnvironment()
if !has('g:supports')
    let g:supports = VimrcSupports()
endif
" ================================
"}}}1
" ================================

"---------------------------------
" Install NeoBundle Plugins {{{1
"---------------------------------
"NeoBundle Config: Start Proc {{{2
if g:supports.neobundle == 0
    let g:supports.neobundle = InstallNeoBundleIfNot( s:env.url.neobundle , s:env.path.neobundle )
endif
if g:supports.mycolorscheme == 0
    let g:supports.mycolorscheme = InstallNeoBundleIfNot( s:env.gui_mycolo.url , s:env.gui_mycolo.path )
    let g:supports.mycolorscheme = InstallNeoBundleIfNot( s:env.term_mycolo.url , s:env.term_mycolo.path )
endif

function! SetMyNeobundleEnable()
    execute "set runtimepath+=" . s:env.path.neobundle
    call neobundle#begin( expand( s:env.path.bundledir . "/" ))
    execute "set runtimepath+=" . s:env.path.user
    execute "runtime! " . s:env.path.local_bundle . "/*.vim"
    execute "set runtimepath-=" . s:env.path.user
    "}}}2

    "  Manage NeoBundle {{{2
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
    "}}}2

    " Common {{{2
    NeoBundle 'Shougo/unite.vim'
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
    "}}}2

    " Memo {{{2
    NeoBundle 'thinca/vim-fontzoom'
    NeoBundleLazy 'fuenor/qfixgrep', {'autoload': {'commands': ['ToggleGrepRecursiveMode', 'REGrepadd', 'OpenQFixWin', 'RFGrep', 'BGrepadd', 'ToggleGrepCurrentDirMode', 'VGrepadd', 'RFGrepadd', 'MyGrepWriteResult', 'MyGrepReadResult', 'Vimgrep', 'BGrep', 'RGrepadd', 'Vimgrepadd', 'FGrep', 'MoveToAltQFixWin', 'ToggleMultiEncodingGrep', 'QFixAltWincmd', 'REGrep', 'QFdo', 'QFixCclose', 'RGrep', 'CloseQFixWin', 'EGrep', 'ToggleDamemoji', 'Grepadd', 'EGrepadd', 'MoveToQFixWin', 'Grep', 'ToggleLocationListMode', 'VGrep', 'ToggleQFixWin', 'FList', 'FGrepadd', 'QFixCopen']}}
    NeoBundleLazy 'glidenote/memolist.vim', { 'depends' : "vimfiler" , 'autoload': {'commands': ['MemoList', 'MemoGrep', 'MemoNew']}}
    "}}}2

    " Script Quick Test {{{2
    NeoBundle 'thinca/vim-quickrun'
    "}}}2

    " File handling {{{2
    NeoBundle 'Shougo/neomru.vim'
    NeoBundleLazy 'kien/ctrlp.vim', {'autoload': {'commands': ['CtrlPMixed', 'CtrlPClearAllCaches', 'CtrlPCurWD', 'CtrlP', 'CtrlPRTS', 'CtrlPBuffer', 'CtrlPMRUFiles', 'CtrlPBookmarkDirAdd', 'CtrlPDir', 'CtrlPRoot', 'CtrlPChange', 'ClearCtrlPCache', 'CtrlPLine', 'ClearAllCtrlPCaches', 'CtrlPBufTagAll', 'CtrlPClearCache', 'CtrlPQuickfix', 'CtrlPBufTag', 'CtrlPTag', 'CtrlPCurFile', 'CtrlPLastMode', 'CtrlPUndo', 'CtrlPChangeAll', 'CtrlPBookmarkDir']}}
    NeoBundleLazy 'mbbill/VimExplorer', {'autoload': {'commands': [{'complete': 'file', 'name': 'VEC'}, {'complete': 'file', 'name': 'VE'}]}}
    NeoBundleLazy 'Shougo/vimfiler.git' , {'autoload' : {'commands' : [ "VimFilerTab" , "VimFiler" , "VimFilerExplorer" ]},'explorer' : 1}
    "}}}2

    " Writting Support {{{2
    NeoBundle 'terryma/vim-multiple-cursors'
    NeoBundle 'scrooloose/syntastic'
    NeoBundle 'Townk/vim-autoclose'
    "NeoBUndle 'jiangmiao/auto-pairs'
    if g:supports.neocomplete
        NeoBundle 'Shougo/neocomplete.vim'
    endif
    NeoBundle 'kana/vim-textobj-user'
    NeoBundle 'tpope/vim-surround'
    NeoBundle 'bronson/vim-trailing-whitespace'
    NeoBundle  'junegunn/vim-easy-align', { 'autoload': {'commands' : ['EasyAlign'] }}
    NeoBundle 'AndrewRadev/linediff.vim'
    NeoBundleLazy 'tomtom/tcomment_vim.git', {'autoload': {'commands': [{'complete': 'customlist,tcomment#CompleteArgs', 'name': 'TCommentBlock'}, {'complete': 'customlist,tcomment#CompleteArgs', 'name': 'TCommentRight'}, {'complete': 'customlist,tcomment#CompleteArgs', 'name': 'TComment'}, {'complete': 'customlist,tcomment#CompleteArgs', 'name': 'TCommentMaybeInline'}, {'complete': 'customlist,tcomment#Complete', 'name': 'TCommentAs'}, {'complete': 'customlist,tcomment#CompleteArgs', 'name': 'TCommentInline'}]}}
    "}}}2

    " Tagging {{{2
    " [TODO] -I is not worked my mingw64. so I need to add include path to make
    " file and build by my self.
    if has('win32') || has('win64')
        if executable('mingw32-make')
            let g:mingw_include = 'C:/bin/mingw64/include/'
            let $PATH = $PATH .";" . g:mingw_include
            NeoBundle 'vim-jp/ctags', { 'build' : { 'windows' : 'mingw32-make.exe -I' . g:mingw_include . ' -f mk_mingw.mak' , } }
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
    "}}}2

    " Markdown {{{2
    NeoBundle 'godlygeek/tabular'
    NeoBundle 'plasticboy/vim-markdown' , {'depends' : 'godlygeek/tabular'}
    NeoBundle 'Shougo/unite-outline' , {'depends': 'Shougo/unite.vim' }
    NeoBundleLazy 'kannokanno/previm', {'depends': 'tyru/open-browser.vim' , 'autoload': {'commands': ['PrevimOpen']}}
    "}}}2

    "Java ascript{{{2
    NeoBundle 'pangloss/vim-javascript'
    "}}}2

    " C# {{{2
    NeoBundle 'OrangeT/vim-csharp' "syntax
    " MSBuild is in C:\Windows\Microsoft.N
    " ex) C:\Windows\Microsoft.NET\Framework64\v4.0.30319
    if executable('python') && ( executable('msbuild') || executable('xbuild') )
        NeoBundleLazy 'nosami/Omnisharp', {
                    \   'autoload': {'filetypes': ['cs'], 'commands' : ['OmniSharpStartServer', 'OmniSharpStartServerSolution']},
                    \   'build': {
                    \     'windows': 'MSBuild.exe server/OmniSharp.sln /p:Platform="Any CPU"',
                    \     'mac': 'xbuild server/OmniSharp.sln',
                    \     'unix': 'xbuild server/OmniSharp.sln',
                    \   }
                    \ }
    endif
    " }}}2

    "Visualize {{{2
    NeoBundle 'itchyny/lightline.vim'
    NeoBundle 'nathanaelkane/vim-indent-guides'
    NeoBundle 'vim-scripts/AnsiEsc.vim'
    NeoBundle 'kien/rainbow_parentheses.vim'
    " }}}2

    "colorscheme {{{2
    NeoBundle 'w0ng/vim-hybrid'
    NeoBundle 'jonathanfilip/vim-lucius'
    NeoBundle 'chriskempson/vim-tomorrow-theme'
    NeoBundle 'taka-vagyok/term_forrest_cls.vim'
    "}}}2

    " Redmine {{{2
    NeoBundle 'mattn/webapi-vim'
    "ref[rmine:http://blog.basyura.org/entry/20130106/p1]
    NeoBundle 'basyura/rmine.vim'
    " }}}2

    " cmigeo {{{2
    " [Todo] Fix that building automatically
    "NeoBundle 'haya14busa/cmigemo'
    "NeoBundleLazy 'koron/cmigemo', {
    "\   'build': {
    "\	  'windows': 'mingw32-make -f compile/Make_mingw.mak',
    "\   }
    "\ }
    " }}}2

    " Presentation {{{2
    NeoBundle "sotte/presenting.vim"
    NeoBundle "thinca/vim-showtime"
    "}}}2

    " Ref Doc {{{2
    NeoBundleLazy 'thinca/vim-ref', {'autoload': {'unite_sources': ['ref'], 'mappings': [['sxn', '<Plug>(ref-keyword)']], 'commands': [{'complete': 'customlist,ref#complete', 'name': 'Ref'}, 'RefHistory']}}
    " }}}2

    " Web access {{{2
    if executable("w3m")
        NeoBundle "yuratomo/w3m.vim"
    endif
    "}}}2

    "VCS {{{2
    NeoBundle 'tpope/vim-fugitive'
    NeoBundle 'vim-scripts/vcscommand.vim'
    "}}}2

    " NeoBundle Config: End Proc{{{5
    call neobundle#end()
    filetype plugin indent on
    NeoBundleCheck "Can be skip if you want to ask everytime up
    return 1
endfunction
" }}}5
if g:supports.loaded_neobundle == 0
    let g:supports.loaded_neobundle = SetMyNeobundleEnable()
endif

"------------------------------
"  }}}1 Install NeoBundle Plugins
"------------------------------

"==================================
" VIM General Settings
"==================================
set noswapfile
set nobackup
set noundofile
set tabstop=4
set shiftwidth=4
set clipboard+=unnamed  "Enable Windows Clipbord
set backspace=indent,eol,start
set nonumber
set splitbelow "新しいウィンドウを下に開く
set splitright "新しいウィンドウを右に開く
set foldmethod=marker
set ruler
set incsearch
set showcmd
set modeline
set modelines=5
set smarttab
set expandtab
syntax on
set t_Co=256

" Move Current Directory when opening file {{{
" Disable 2014/12/11 because this config have some plugin worked not file.
"augroup filelcd
"	autocmd!
"	autocmd BufEnter * lcd %:p:h
"augroup END
" }}}

" Easy  Todo {{{
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

" ColorSyntax {{{
if g:supports.neobundle
    if exists("syntax_on")
        syntax reset
    endif
    "colorscheme hybrid
    "set background=light
    if g:supports.loaded_neobundle == 1 && g:supports.mycolorscheme == 1
        execute ":set background=" . s:env.mycolo.bgcolor
        execute ":colorscheme " . s:env.mycolo.name
    endif
else
    set background=dark
    colorscheme evening
endif
"}}}

"------------------------------
" Configure NeoBundle Plugins {{{
"------------------------------
if g:supports.loaded_neobundle

    " QuickRun {{{2
    let g:quickrun_config={
                \ '*':{
                \ 'hook/time/enable': 1 ,
                \ 'split':'' },
                \ '_':{
                \ 'runner' : 'vimproc',
                \ 'runner/vimproc/updatetime' : 60
                \ },
                \}
    " For ez script using :Tmp <ext> or :Temp <ext> (e.g. :Tmp py => we have tmp.py )
    command! -nargs=1 -complete=filetype Tmp call EditTmpFile(<f-args>)
    command! -nargs=1 -complete=filetype Temp call EditTmpFile(<f-args>)
    function! EditTmpFile(ext)
        if !isdirectory( s:env.path.tmp )
            call mkdir( s:env.path.tmp )
        endif
        execute 'edit' s:env.path.tmp . 'tmp.' . a:ext
    endfunction
    "}}}2

    "memolist {{{2
    let g:memolist_memo_suffix = "md.txt"
    let g:memolist_prompt_tags = 1
    let g:memolist_qfixgrep = 1
    let g:memolist_vimfiler = 1
    let g:memolist_vimfiler_option ="" "No split
    au BufNewFile,BufRead *.{md.txt,md,mdwn,mkd,mkdn,mark*} set filetype=markdown
    "}}}2

    "vimfiler {{{2
    let g:vimfiler_as_default_explorer = 1
    let s:bundle = neobundle#get("vimfiler")
    function! s:bundle.hooks.on_source(bundle)
        let g:vimfiler_data_directory = s:env.path.tmp . '/.vimfiler'
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
    "}}}2

    "indent-guide {{{2
    let g:indent_guides_auto_colors = 1
    let g:indent_guides_enable_on_vim_startup = 1
    "let g:indent_guides_guide_size = &tabstop
    let g:indent_guides_guide_size = 1
    let g:indent_guides_color_change_percent = 20
    let g:indent_guides_start_level = 1
    "}}}2

    "unite-outline {{{2
    let g:unite_winwidth = 40
    let g:unite_split_rule = "rightbelow"
    nnoremap <silent> <Leader>o :<C-u>Unite -vertical -no-quit outline<CR>
    "}}}2

    " CTRLP {{{2
    if s:env.is_win
        let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'
    endif
    "}}}2

    " neocomplete{{{2
    let g:neocomplete#acp_enableAtStartUp = 0
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_ignore_case = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#min_keyword_length = 4
    let g:neocomplete#use_vimproc = 1
    let g:neocomplete#auto_completion_start_length = 2
    let g:neocomplete#max_keyword_width = 50
    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'
    "Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
    endif
    inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
    "}}}2

    " W3M {{{2
    "let g:w3m#command = ''
    "}}}2

    "ref-vim {{{2
    let g:ref_use_vimproc=1
    "webdictサイトの設定
    let g:ref_source_webdict_sites = {
                \   'jj': {
                \     'url': 'http://dictionary.infoseek.ne.jp/word/%s',
                \   },
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
    let g:ref_webdict_cmd="w3c -s -dump %s"
    let g:ref_webdict_use_cache = 1
    let g:ref_webdict_encoding = 'utf-8'
    let g:ref_cache_dir = expand("$TMP")
    let g:ref_webdict_cache_dir = expand("$TMP/.cache")
    "デフォルトサイト
    let g:ref_source_webdict_sites.default = 'ej'
    if !has('$LANG')
        let $LANG="C.CP932"
    end
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
    "
    "}}}2

    "Omni C# {{{
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
    "}}}

    " () をハイライト {{{2
    augroup rainbowparentheses
        au VimEnter * RainbowParenthesesToggle
        au Syntax * RainbowParenthesesLoadRound
        au Syntax * RainbowParenthesesLoadSquare
        au Syntax * RainbowParenthesesLoadBraces
    augroup END
    " }}}2

endif
"----------------------------------------
" }}} End of Configure NeoBundle Plugins
"----------------------------------------

" Load Local Setting {{{
execute "set runtimepath+=" . s:env.path.user
execute "runtime! " . s:env.path.local_vimrcs . "/" . "*vim"
execute "set runtimepath-=" . s:env.path.user
" }}}

" vim: set ts=4 sw=4 smarttab expandtab :
"%EOF
