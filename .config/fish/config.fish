if status is-interactive
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

    # use vi key bindings
    fish_vi_key_bindings --no-erase insert
end
