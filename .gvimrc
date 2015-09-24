"colorscheme
if g:supports.loaded_neobundle
    "set background=dark
    if ($ft=='python')
        colorscheme Tomorrow-Night
    else
        set background=light
        colorscheme lucius
    endif
    call singleton#enable()
else
    colorscheme evening
endif
"singleton

" ime setting
if has('multi_byte_ime') || has('xim') || has('gui_macvim')
    " Insert mode: lmap off, IME ON
    set iminsert=0
    " Serch mode: lmap off, IME ON
    set imsearch=0
    " Normal mode: IME off
    inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif

"window size
set lines=50 columns=100
"transparency
if has('kaoriya')
    gui
    set transparency=245
endif
if filereadable("C:/Windows/Fonts/MyricaM.ttc")
    set guifont=Myrica_M:h11
elseif filereadable("C:/Windows/Fonts/RictyDiminishedDiscord-Regular.ttf")
    " hÇÕ1.5ÇÃî{êîÇ…Ç∑ÇÈÇ∆åÎç∑Ç™èÊÇËÇ…Ç≠Ç¢ÇÁÇµÇ¢
    set guifont=Ricty_Diminished_Discord:h12.5
endif

"misc
set antialias
set showtabline=2
set guioptions-=T
set guioptions+=m
