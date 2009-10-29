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

# aliases
alias ls='ls -F'
alias rm='rm -i'
alias renew='. ~/.bashrc'
alias ..='cd ..'
alias 2..='cd ../..'
alias 3..='cd ../../..'
alias 4..='cd ../../../..'

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
    fi
fi

# vim: ft=sh
