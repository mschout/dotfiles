# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

umask 027

# append an entry to PATH if it is a dir, and not already in path.
pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$PATH:$1"
    fi
}

path_unshift() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1:$PATH"
    fi
}

path_remove() {
    if [[ ":$PATH:" = *":$1:"* ]]; then
        PATH=$(IFS=':';t=($PATH);unset IFS;t=(${t[@]%%*$1*});IFS=':';echo "${t[*]}");
    fi
}

# csh style setenv/unsetenv
setenv() {
    export ${1}=${2}
}

unsetenv() {
    unset ${1}
}

source_if_present() {
    if [ -f "$1" ]; then
        . "$1"
    fi
}

gi() {
    curl -L -s https://www.gitignore.io/api/$@
}

pathadd $HOME/bin
pathadd $HOME/Dropbox/bin

# Haskell stack tool
path_unshift $HOME/.local/bin

# add azk
path_unshift $HOME/bin/azk/bin

# macports
path_unshift /opt/local/sbin
path_unshift /opt/local/bin

# add sbin dirs
pathadd /usr/sbin
pathadd /sbin

# add /usr/local bindirs
pathadd /usr/local/bin
pathadd /usr/local/sbin

# ruby gems
pathadd /var/lib/gems/1.8/bin

# macports pgsql.  must come before other paths because Lion ships with psql 8.3
path_unshift /opt/local/lib/postgresql84/bin
path_unshift /opt/local/lib/postgresql83/bin

pathadd /snap/om26er-gradle/current/opt/gradle/bin

pathadd $HOME/bin/eclipse

export LANG=en_US.UTF-8
export CVSROOT=mschout@cvs.gkg.net:/usr/local/cvsroot
export CVS_RSH=ssh

# use less by default
if [ -x `which less` ]; then
    export PAGER=less
fi

# use vim if possible, otherwise vi
if [ -x `which vim` ]; then
    export EDITOR=vim
else
    export EDITOR=vi
fi

# on CentOS LESSOPEN causes sorrow
unset LESSOPEN

# expermiental
export LESS='-iMFXSx4R'

# set cpansign default key
export MODULE_SIGNATURE_AUTHOR=mschout@cpan.org

# are we an interactive shell?
if [ "$PS1" ] && [ -z "$PROMPT_COMMAND" ]; then
    if [[ $TERM == xterm* ]]; then
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"; echo -ne "\007"'
    fi
fi

# use vi style keybindings
set -o vi
set -o noclobber

# do not offer completions for empty command
shopt -s no_empty_cmd_completion

CDPATH=.:$HOME
HISTSIZE=40000
# add date/time stamp to history output
HISTTIMEFORMAT="%h/%d - %H:%M:%S "

if [ -n "$(command -v dircolors)" ]; then
    if [ -f ~/.dir_colors/dircolors ]; then
        eval `dircolors ~/.dir_colors/dircolors`
    fi
fi

# aliases
alias ls='ls -F'
alias rm='rm -i'
alias renew='. ~/.bashrc'
alias ..='cd ..'
alias 2..='cd ../..'
alias 3..='cd ../../..'
alias 4..='cd ../../../..'

# alias g to git (with completions)
alias g='git'
complete -o default -o nospace -F _git g

top10() {
    history | awk '{print $2}' | sort | uniq -c | sort -k1 -rn | head
}

tardir() {
    if [ -d "$1" ]; then
        tar czf "$1.tar.gz" "$1"
    fi
}

# common typo aliases
alias grpe='grep'
alias maek='make'

# csh style source
alias source='.'

# plenv
if [ -e $HOME/.plenv/bin/plenv ]; then
    path_unshift $HOME/.plenv/bin
    eval "$(plenv init -)"
fi

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

# Ruby/RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 
pathadd $HOME/.rvm/bin

# set up completion
# -n $TMUX means re-do this if we are within tmux
if [ -z "$BASH_COMPLETION" ] || [ -n "$TMUX" ]; then
    bash=${BASH_VERSION%.*}; bmajor=${bash%.*}; bminor=${bash#*.}
    if [ "$PS1" ] && [ \( $bmajor -eq 2 -a $bminor '>' 04 \) -o $bmajor -ge 3 ] ; then

      if [ -f $HOME/bin/bash_completion   ] ; then
        BASH_COMPLETION=$HOME/bin/bash_completion
        BASH_COMPLETION_DIR=$HOME/.bash_completion.d
        export BASH_COMPLETION BASH_COMPLETION_DIR
        . $HOME/bin/bash_completion

        # set prompt to show git branch
        PS1='\u@\h:\W$(__git_ps1 " (%s)")\$ '
      fi

      # remove completions I do not want.
      complete -r kill

      # some custom completions
      complete -f -X '!*.tar.gz' cpan-upload-http

      complete -C perldoc-complete perldoc
    fi
    unset bash bmajor bminor
fi

# OS Specific bashrc's
case "$OSTYPE" in
    darwin*)
        . $HOME/.bashrc.darwin
        ;;
    freebsd*)
        . $HOME/.bashrc.freebsd
        ;;
    linux*)
        . $HOME/.bashrc.linux
        ;;
    *)
esac

# pull in local profile.d scripts
for prof_script in $HOME/.bash_profile.d/*.sh; do
    . $prof_script
done

# Default fd options
FD_OPTIONS="--follow --exclude .git --exclude node_modules"

# Initialize fzf
if [ -e "$HOME/.fzf" ]; then
    pathadd "$HOME/.fzf/bin"

    # Auto Completion
    if [[ $- == *i* ]]; then
        source "$HOME/.fzf/shell/completion.bash" 2>/dev/null
    fi

    # Key bindings
    if [ -f "$HOME/.fzf/shell/key-bindings.bash" ]; then
        source "$HOME/.fzf/shell/key-bindings.bash"
    fi

    alias preview="fzf --preview 'bat --color \"always\" {}'"

    # add support for ctrl+o to open selected file in gvim
    export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info \
        --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2>/dev/null | head -300' \
        --preview-window='right:hidden:wrap' \
        --bind='f2:toggle-preview,f3:execute(bat --style=numbers {}),ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | xclip),ctrl-o:execute(gvim {})+abort'"

    # use git ls-files inside a git repo, otherwise fd
    export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fd --type f --type l $FD_OPTIONS"
    export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
    export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"

    # enable FZF extras, if available
    source_if_present "$HOME/.fzf-extras/fzf-extras.sh"
fi

export BAT_PAGER="less -R"

# vim: ft=sh
