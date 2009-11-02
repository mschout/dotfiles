" VIM settings for GUI
let Tlist_Show_Menu = 1

" OS specific

if has("gui_macvim")

    set guioptions-=T " remove toolbar
    set stal=2 " tabs on by default

elseif has("gui_gtk2")

    set guioptions-=T " remove toolbar

elseif has("x11")
elseif has("gui_win32")
end

" General
set antialias

" Default win size
set columns=110
set lines=45

" Tab headings
set gtl=%t gtt=%F