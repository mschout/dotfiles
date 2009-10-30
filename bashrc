# .bashrc

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

# csh style setenv
setenv() {
    export ${1}=${2}
}

pathadd $HOME/bin

# macports
pathadd /opt/local/sbin
pathadd /opt/local/bin

# add sbin dirs
pathadd /usr/sbin
pathadd /sbin

# add /usr/local bindirs
pathadd /usr/local/bin
pathadd /usr/local/sbin

# CentOS 5 doesn't have a maven2 package.  I put it in /opt/maven.
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
export PAGER=less

# use vim if possible, otherwise vi
which vim >/dev/null 2>&1
if [ $? -eq 0 ]; then
    export EDITOR=vim
else
    export EDITOR=vi
fi

# on CentOS LESSOPEN causes sorrow
unset LESSOPEN

# are we an interactive shell?
if [ "$PS1" ]; then
    if [ -z "$PROMPT_COMMAND" ]; then
        case $TERM in
            xterm*)
                PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"; echo -ne "\007"'
                ;;
            *)
                ;;
        esac
    fi
fi

# use vi style keybindings
set -o vi

# aliases
alias ls='ls -F'
alias rm='rm -i'
alias renew='. ~/.bashrc'
alias ..='cd ..'
alias 2..='cd ../..'
alias 3..='cd ../../..'
alias 4..='cd ../../../..'

# common typo aliases
alias grpe='grep'
alias maek='make'

# csh style source
alias source='.'

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
      fi
    fi
    unset bash bmajor bminor
fi

# vim: ft=sh
