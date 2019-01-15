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

# java options for maven, Java 8 style
export MAVEN_OPTS="-Xmx1024M -Xss128M -XX:MetaspaceSize=512M -XX:MaxMetaspaceSize=1024M -XX:+CMSClassUnloadingEnabled"

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
# add date/time stamp to history output
HISTTIMEFORMAT="%h/%d - %H:%M:%S "

# aliases
alias ls='ls -F'
alias rm='rm -i'
alias renew='. ~/.bashrc'
alias ..='cd ..'
alias 2..='cd ../..'
alias 3..='cd ../../..'
alias 4..='cd ../../../..'
alias handbrake="HandBrakeCLI --preset Universal"

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

if [ -x /usr/bin/ack-grep ]; then
    alias ack='/usr/bin/ack-grep'
fi


if [ -e $HOME/perl5/perlbrew/etc/bashrc ]; then
    . $HOME/perl5/perlbrew/etc/bashrc
    no_perlbrew(){
        path_remove $HOME/perl5/perlbrew/perls/$PERLBREW_PERL/bin
        for var in $(env | grep ^PERL | awk -F'=' '{print $1}')
        do
            unset $var
        done
    }

    PERLBREW_BIN=$PERLBREW_ROOT/perls/$PERLBREW_PERL/bin

    if [ -x $PERLBREW_BIN/nopaste ]; then
        alias gist="nopaste --private --service Gist"
    fi

    if [ -f $HOME/.config/shcompgen.bashrc ]; then
        . $HOME/.config/shcompgen.bashrc
    fi
fi

if [ -e $HOME/.plenv/bin/plenv ]; then
    use_plenv() {
        # plenv conflicts with perlbrew, so clear out any perlbrew env vars
        no_perlbrew

        path_unshift $HOME/.plenv/bin
        eval "$(plenv init -)"
    }
fi

# Initialize NVM if it is installed
export NVM_DIR="$HOME/.nvm"
[ -s" $NVM_DIR/nvm.sh" ] && source "$NVM_DIR/bash_completion"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

# try to set JAVA_HOME to something sensible
if [ -z "$JAVA_HOME" ]; then
    if [ -x /usr/sbin/update-java-alternatives ]; then
        # Ubuntu
        export JAVA_HOME=`/usr/sbin/update-java-alternatives -l | head -1 | awk '{print $3}'`
    elif [ -e /etc/alternatives/java_sdk ]; then
        # RHEL/CentOS
        export JAVA_HOME=`readlink /etc/alternatives/java_sdk`
    elif [ -x  /usr/libexec/java_home ]; then
        # MacOS X
        export JAVA_HOME=$(/usr/libexec/java_home)
    fi
fi

if [ -d /opt/local/share/java/gradle ]; then
    export GRADLE_HOME=/opt/local/share/java/gradle
fi

# set CATALINA_HOME if appropriate
if [ -z "$CATALINA_HOME" ] && [ -d $HOME/tomcat5 ]; then
    export CATALINA_HOME=$HOME/tomcat5
fi

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

      source_if_present $HOME/perl5/perlbrew/etc/perlbrew-completion.bash

      # remove completions I do not want.
      complete -r kill

      # some custom completions
      complete -f -X '!*.tar.gz' cpan-upload-http

      complete -C perldoc-complete perldoc
    fi
    unset bash bmajor bminor
fi

if [ -f ~/.dir_colors/dircolors ]
    then eval `dircolors ~/.dir_colors/dircolors`
fi

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

# suck in RVM if its installed
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 
pathadd $HOME/.rvm/bin
# vim: ft=sh

export AZK_KILL_ON_STOP=1

