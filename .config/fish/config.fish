fish_add_path --append "$HOME/bin"

fish_add_path --append "$HOME/Dropbox/bin"

fish_add_path --append /usr/local/bin /usr/local/sbin

set -gx LANG en_US.UTF-8

# the rest should only be done in interactive mode
status is-interactive || return

if type -q less then
    set -gx PAGER less
    set -gx LESS '-iMFXSx4R'
end

if type -q vim then
    set -gx EDITOR vim
else
    set -gx EDITOR vi
end

# make cd search current path and $HOME
set -gx CDPATH $CDPATH . $HOME

# set history size
set -U fish_history_max 40000

alias history='history -R --show-time="%h/%d - %H:%M:%S "'

# Commands to run in interactive sessions can go here
alias ls='ls -F'

# move upwards n directories
alias .1='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

if type -q fzf && type -q bat
    alias preview="fzf --preview 'bat --color \"always\" {}'"
end

# if we are on a graphical display, use gvim instead of vim
if type -q gvim && test -n "$DISPLAY"
    alias vim='gvim'
end

# use vi key bindings
fish_vi_key_bindings --no-erase insert

# "jq" colors
# Solarized Dark:
set -gx JQ_COLORS "0;37:0;31:0;32:0;33:0;36:0;34:1;36:0;35"
# 256 color variant:
#set -gx JQ_COLORS "38;5;245:38;5;160:38;5;64:38;5;136:38;5;37:38;5;33:38;5;81:38;5;125"

# for Solarized Light:
# 16 color version:
#set -gz JQ_COLORS "1;30:0;31:0;32:0;33:0;36:0;34:1;36:0;35"
# 256 color variant:
#set -gx JQ_COLORS "38;5;240:38;5;160:38;5;64:38;5;136:38;5;37:38;5;33:38;5;81:38;5;125"
