# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# macports
[ -d /opt/local/sbin ] && PATH=/opt/local/sbin:$PATH
[ -d /opt/local/bin ]  && PATH=/opt/local/bin:$PATH

# look for /opt/maven on RHEL/CentOS
if [ -e /etc/redhat-release ]; then
    if [ -d /opt/maven/bin ]; then
        export M2_HOME=/opt/maven
        PATH=$M2_HOME/bin:$PATH
    fi
fi

export PATH

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

# csh style setenv
setenv() {
    export ${1}=${2}
}

# try to set JAVA_HOME to something sensible
if [ -z "$JAVA_HOME" ]; then
    if [ -x /usr/sbin/update-java-alternatives ]; then
        # Ubuntu
        export JAVA_HOME=`/usr/sbin/update-java-alternatives -l | head -1 | awk '{print $3}'`
    elif [ -l /etc/alternatives/java_sdk ]; then
        # RHEL/CentOS
        export JAVA_HOME=`readlink /etc/alternatives/java_sdk`
    fi
fi

# vim: ft=sh
