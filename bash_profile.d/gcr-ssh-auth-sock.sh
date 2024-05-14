if [ ! -z "$XDG_RUNTIME_DIR" ] && [ -e "$XDG_RUNTIME_DIR/gcr/ssh" ]; then
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gcr/ssh"
fi
