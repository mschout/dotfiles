" send visual selection through pandoc, converting github-flavored-markdown to HTML5
vnoremap <silent> <Leader>th :! pandoc --quiet
    \ --from gfm
    \ --to html5
    \ --standalone
    \ --highlight-style=tango
    \ --template=bootstrap.html5
    \ --include-in-header=$HOME/.pandoc/templates/email.css<CR>
