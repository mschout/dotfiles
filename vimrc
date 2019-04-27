set nocompatible   " no vi compatibility
set ruler
set showmode
set showcmd
set smarttab
set showmatch " flashes matching brackets and paren's
set matchpairs+=<:>
set autowrite " automatically write contents on :make, :rewind :last, ...
set laststatus=2
set list
set listchars=tab:»·,trail:·
set wildmenu
set background=light
syntax on

filetype plugin indent on

set visualbell t_vb= " turn off the bell
set scrolloff=8 " keep lines below the cursor 

" Tabs
set tabstop=4
set shiftwidth=4
set autoindent
set expandtab
set backspace=start,indent,eol
autocmd FileType make   set noexpandtab
autocmd FileType python set noexpandtab
autocmd FileType gitconfig set noexpandtab
autocmd Filetype mvn_pm set ts=2 sw=2

set viminfo=%,'50,\"100,:100,n~/.viminfo

" directories
" set backup locations and enable
set backup
set backupdir=~/.backup//
set directory=~/.backup//

" spelling check settings
set spelllang=en
set spellfile=$HOME/Dropbox/vim/spell/en.utf-8.add
set spell
" insert mode, jump back to prev spelling mistake, fix it, return to position
inoremap <C-l> <Esc>[s1z=<C-o>a

" init pathogen
execute pathogen#infect()

" always jump to the last cursor position
autocmd BufReadPost * if line("'\"") | exe "normal '\"" | endif

" auto +x these on write
autocmd BufWritePost    *.pl !chmod +x %
autocmd BufWritePost    *.py !chmod +x %
autocmd BufWritePost    *.t  !chmod +x %

" use 256 color scheme in terminal if TERM supports it
if $TERM =~ '^xterm-color'
    " OSX Termnal.app reports as this, and only supports 16 colors
    set t_Co=16
elseif $TERM =~ '^xterm'
    set t_Co=256
endif

if &t_Co == 256
    colorscheme mustang
endif

" searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" press space to turn off highlighting and clear any messages displayed
noremap <silent> <Space> :silent noh<Bar>echo<CR>

" svn plugin
let SVNCommandEdit = "split"
let SVNCommandSplit = "horizontal"

" Taglist plugin
let Tlist_Show_One_File = 1
let Tlist_Show_Menu = 1
nnoremap <silent> <F8> :TlistToggle<CR>

" Ctrl-P -> Fuzzy File Finder with Git Files
nnoremap <C-P> :GFiles<CR>

" vim completes me
let g:vcm_default_maps = 0
imap <C-CR> <Plug>vim_completes_me_forward
imap <CR> <Plug>vim_completes_me_backward

" :w!! - write file with sudo
cmap w!! %!sudo tee >/dev/null %

" closetag plugin
autocmd FileType html,xml,tt2html,xsl source ~/.vim/plugin/closetag.vim

" lightline
let g:lightline = {
    \ 'colorscheme': 'solarized',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head'
    \ },
    \ }

" vimwiki
let g:vimwiki_list = [{'path': '~/Dropbox/Vimwiki',
    \ 'syntax': 'markdown',
    \ 'ext': '.md'
    \ }]

let perl_include_pod=1
let perl_want_scope_in_variables=1
let perl_fold=1
let perl_nofold_packages=1

" set up file explorer to split right.
let g:explVertical=1    " Split vertically
let g:explSplitRight=1  " Put new window right of the explorer window

" autocomplpop off by default
let g:acp_enableAtStartup = 0

" zen coding for vim
let g:user_zen_settings = {
\  'indentation' : '  ',
\  'tt2html': {
\      'extends': 'html'
\  }
\}

" localvimrc plugin
let g:localvimrc_ask = 0
let g:localvimrc_sandbox = 0

set statusline=%n:\ %f\ %(%h%y%r%m%)\ %{fugitive#statusline()}%=%(\[%c,%l/%L]%)\ %P\ 

autocmd BufEnter svn-commit.* set filetype=svn
autocmd BufEnter psql.edit.* set filetype=sql
autocmd BufEnter *.less set filetype=less

" Resize splits when the window is resized
autocmd VimResized * exe "normal! \<c-w>="

" window movement
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l

" tab cycle
nnoremap <silent> <C-S-h> :tabprev<CR>
nnoremap <silent> <C-S-l> :tabnext<CR>

" buffer cycling
nnoremap <silent> <S-h> :bprev<CR>
nnoremap <silent> <S-l> :bnext<CR>

" ,e opens file in current file's directory
map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
map ,te :tabe <C-R>=expand("%:p:h") . "/" <CR>
" ,cd change to current file's directory
map ,cd :cd %:p:h <CR>

" insert date stamp with F2
imap <F2> <C-R>=strftime("%Y-%m-%d")<CR>

" mappings for moving lines/selections up or down
nnoremap <silent> <C-k> mz:m-2<CR>`z==
vnoremap <silent> <C-j> :m'>+<CR>gv=`<my`>mzgv`yo`z
nnoremap <silent> <C-j> mz:m+<CR>`z==
vnoremap <silent> <C-k> :m'<-2<CR>gv=`>my`<mzgv`yo`z

" auto create missing directories when saving
augroup AutoMkdir
    autocmd!
    autocmd  BufNewFile  *  :call EnsureDirExists()
augroup END

function! EnsureDirExists()
    let required_dir = expand("%:h")

    " current directory, older vim returns blank
    if !isdirectory(required_dir)
        call AskQuit("Directory '" . required_dir . "' doesn't exist.", "&Create it?")

        try
            call mkdir(required_dir, 'p')
        catch
            call AskQuit("Can't create '" . required_dir . "'", "&Continue anyway?")
        endtry
    endif
endfunction

function! AskQuit(msg, action)
    if confirm(a:msg, "&Quit?\n" . a:action) == 1
        exit
    endif
endfunction

if exists(":Tabularize")
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    nmap <Leader>a: :Tabularize /:\zs<CR>
    vmap <Leader>a: :Tabularize /:\zs<CR>
endif
