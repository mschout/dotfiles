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

set viminfo=%,'50,\"100,:100,n~/.viminfo

" directories
" set backup locations and enable
set backup
set backupdir=~/.backup//
set directory=~/.backup//

" always jump to the last cursor position
autocmd BufReadPost * if line("'\"") | exe "normal '\"" | endif

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

" closetag plugin
autocmd FileType html,xml,tt2html,xsl source ~/.vim/plugin/closetag.vim

"let perl_fold=1
let perl_include_pod=1

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

set statusline=\ Buffer\ %n:\ %([%R%M%H]%)\ %f\ %y%=%(\[Line:\ %l\ Col:\ %c\ (%v)]%)\ \[%L\ lines]\ %P\ 

autocmd BufEnter svn-commit.* set filetype=svn

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
" ,cd change to current file's directory
map ,cd :cd %:p:h <CR>

" insert date stamp with F2
imap <F2> <C-R>=strftime("%a %b %d %Y")<CR>

" auto create missing directories when saving
augroup AutoMkdir
    autocmd!
    autocmd  BufNewFile  *  :call EnsureDirExists()
augroup END

function! EnsureDirExists()
    let required_dir = expand("%:h")
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

