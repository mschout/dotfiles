# ~/.cshrc

set MYHOST=`echo $HOST | sed 's/\./ /g' | awk '{print $1}'`

set noclobber
set nobeep
set promptchars = ">#"
set prompt = "%n@%m %#"
set path = ($HOME/bin $path /usr/sbin /sbin /usr/local/bin)

# directories to be searched by the cd command
set cdpath = (. $HOME)

# aliases
alias rm        rm -i
alias logoff    exit
alias renew     'source ~/.cshrc; source ~/.login'
alias ls        'ls -F'
alias ..        'cd ..'
alias ....      'cd ../..'
alias ......    'cd ../../..'
alias ........  'cd ../../../..'

# Ubuntu ruby gems
if (-d /var/lib/gems/1.8/bin) then
    set path = ($path /var/lib/gems/1.8/bin)
endif

# enable vi-line bindings
bindkey -v
bindkey -a "k" history-search-backward
bindkey -k up history-search-backward
bindkey -a "j" history-search-forward
bindkey -k down history-search-forward

# if ack-grep exists, alias ack as ack-grep
if ( -x /usr/bin/ack-grep ) then
    alias ack /usr/bin/ack-grep
endif

# GKG CVSROOT.
setenv CVSROOT mschout@cvs.gkg.net:/usr/local/cvsroot
setenv CVS_RSH ssh

# use less as default pager
setenv PAGER less

# on CentOS, LESSOPEN causes sorrow
unsetenv LESSOPEN

# use vim if possible
which vim >& /dev/null
if ( $? == 0  ) then
    setenv EDITOR vim
else
    setenv EDITOR vi
endif

if ( ! $?JAVA_HOME ) then
    # try to set JAVA_HOME to something sensible
    if (-x /usr/sbin/update-java-alternatives) then
        # Ubuntu
        setenv JAVA_HOME `/usr/sbin/update-java-alternatives -l | head -1 | awk '{print $3}'`
    else if (-l /etc/alternatives/java_sdk) then
        # RHEL/CentOS
        setenv JAVA_HOME `readlink /etc/alternatives/java_sdk`
    endif
endif

# vim: ft=csh
