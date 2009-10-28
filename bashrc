# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# macports
[ -d /opt/local/sbin ] && PATH=/opt/local/sbin:$PATH
[ -d /opt/local/bin ]  && PATH=/opt/local/bin:$PATH

export PATH
