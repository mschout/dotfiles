" VIM settings for GUI
let Tlist_Show_Menu = 1

" OS specific

if has("gui_macvim")

    set guioptions-=T " remove toolbar
    set stal=2 " tabs on by default
    set guifont=Droid\ Sans\ Mono\ Dotted\ 13
    colorscheme mustang

elseif has("gui_gtk2")

    set guioptions-=T " remove toolbar
    set guifont=Droid\ Sans\ Mono\ Dotted\ 10
    colorscheme mustang

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

" CTRL-S for saving, also in insert mode
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

