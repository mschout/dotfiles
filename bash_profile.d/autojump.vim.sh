function jvim {
    file="$(AUTOJUMP_DATA_DIR=~/.autojump.vim/global autojump $@)"
    if [ -n "$file" ]; then
        vim "$file";
    fi
}
