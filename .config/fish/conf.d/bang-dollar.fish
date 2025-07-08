# This makes !$ work like it does in bash
status is-interactive || return

function _bang_dollar_expand_bang
    switch (commandline -t)
      case '!'
        commandline -t $history[1]
      case '*'
        commandline -i '!'
    end
end

function _bang_dollar_expand_lastarg
    switch (commandline -t)
      case '!'
        commandline -t ""
        commandline -f history-token-search-backward
      case '*'
        commandline -i '$'
    end
end

function _bang_dollar_key_bindings --on-variable fish_key_bindings
    set -l modes
    if test "$fish_key_bindings" = fish_default_key_bindings
        set modes default insert
    else
        set modes insert default
    end

    bind --mode $modes[1] ! _bang_dollar_expand_bang
    bind --mode $modes[1] '$' _bang_dollar_expand_lastarg
    bind --mode $modes[2] --erase . ! '$'
end

_bang_dollar_key_bindings

set -l uninstall_event bang_dollar_key_bindings_uninstall

function _$uninstall_event --on-event $uninstall_event
    bind -e .
    bind -e '$'
end
