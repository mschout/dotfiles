#!/bin/sh
#
# install the plenv perl-build plugin if necessary
#

[ -d "$HOME/.plenv/plugins" ] || exit

if [ ! -e "$HOME/.plenv/plugins/perl-build/bin/perl-build" ]; then
  echo "Installing plenv perl-build plugin"
  git clone --depth 50 https://github.com/tokuhirom/Perl-Build.git \
    "$HOME/.plenv/plugins/perl-build/"
fi
