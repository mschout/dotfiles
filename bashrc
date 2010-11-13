# .bashrc

# where I have local::lib bootstrapped
LOCALLIB="$HOME/perl5"
LOCALENV="$LOCALLIB/bin/localenv"

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

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

# csh style setenv/unsetenv
setenv() {
    export ${1}=${2}
}

unsetenv() {
    unset ${1}
}

pathadd $HOME/bin

# add vuze if its there
pathadd $HOME/bin/vuze

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

# macports pgsql 8.3
pathadd /opt/local/lib/postgresql83/bin

# CentOS 5 doesn't have a maven2 package, so look for it in /opt/maven.
if [ -e /etc/redhat-release ]; then
    if [ -d /opt/maven/bin ]; then
        export M2_HOME=/opt/maven
        pathadd $M2_HOME/bin
    fi
fi

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

# are we an interactive shell?
if [ "$PS1" ]; then
    if [ -z "$PROMPT_COMMAND" ]; then
        if [[ $TERM == xterm* ]]; then
            PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"; echo -ne "\007"'
        fi
    fi
fi

# use vi style keybindings
set -o vi
set -o noclobber

# do not offer completions for empty command
shopt -s no_empty_cmd_completion

CDPATH=.:$HOME
HISTSIZE=5000

# aliases
alias ls='ls -F'
alias rm='rm -i'
alias renew='. ~/.bashrc'
alias ..='cd ..'
alias 2..='cd ../..'
alias 3..='cd ../../..'
alias 4..='cd ../../../..'

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

if [ -x /usr/bin/ack-grep ]; then
    alias ack='/usr/bin/ack-grep'
fi

# if we have a local::lib install, intialize it.
if [ -d $LOCALLIB ]; then
    eval $(perl -I$LOCALLIB/lib/perl5 -Mlocal::lib)
fi

# set up gist alias if nopaste is available
if [ -x $LOCALLIB/bin/nopaste ]; then
    alias gist="nopaste --private --service Gist"
fi

# try to set JAVA_HOME to something sensible
if [ -z "$JAVA_HOME" ]; then
    if [ -x /usr/sbin/update-java-alternatives ]; then
        # Ubuntu
        export JAVA_HOME=`/usr/sbin/update-java-alternatives -l | head -1 | awk '{print $3}'`
    elif [ -e /etc/alternatives/java_sdk ]; then
        # RHEL/CentOS
        export JAVA_HOME=`readlink /etc/alternatives/java_sdk`
    elif [ -e /System/Library/Frameworks/JavaVM.framework/Home ]; then
        # MacOS X
        export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home
    fi
fi

# set CATALINA_HOME if appropriate
if [ -z "$CATALINA_HOME" ] && [ -d $HOME/tomcat5 ]; then
    export CATALINA_HOME=$HOME/tomcat5
fi

# set up completion
if [ -z "$BASH_COMPLETION" ]; then
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

if [[ $OSTYPE == darwin* ]]; then
    . $HOME/.bashrc.darwin
fi

# vim: ft=sh
