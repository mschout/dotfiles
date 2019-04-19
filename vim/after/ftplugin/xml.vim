set tabstop=2
set shiftwidth=2
map @@x !%xmllint --format --recover -<CR>
nmap ,px !!xmllint --format -<CR>
vmap ,px !xmllint --format -<CR>
