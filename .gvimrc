"colorscheme
if g:supports.loaded_neobundle
	set background=dark
	if ($ft=='python')
		colorscheme Tomorrow-Night
	else
		"colorscheme iceberg
		colorscheme hybrid
	endif
else
	colorscheme evening
endif
"singleton
call singleton#enable()

" ime setting
if has('multi_byte_ime') || has('xim') || has('gui_macvim')
  " Insert mode: lmap off, IME ON
  set iminsert=2
  " Serch mode: lmap off, IME ON
  set imsearch=2
  " Normal mode: IME off
  inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif

"window size
set lines=50 columns=100
"transparency
if has('kaoriya')
	gui
	set transparency=235
endif
"misc
set showtabline=2
set guioptions-=T
