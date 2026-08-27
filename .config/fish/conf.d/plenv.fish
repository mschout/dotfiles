status --is-interactive || return

fish_add_path --global $HOME/.plenv/bin

# if plenv is available initialize it
if type -q plenv then
    source (plenv init -|psub)
end
