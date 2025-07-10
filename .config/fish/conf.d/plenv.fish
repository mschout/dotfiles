status --is-interactive || return

# if plenv is available initialize it
if type -q plenv then
    source (plenv init -|psub)
end
