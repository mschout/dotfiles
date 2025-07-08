#!/bin/sh
#
# install the plenv perl-build plugin if necessary
#

set -xe

# Ensure plenv is present
[ -e "$HOME/.plenv/bin/plenv" ] || exit 0

if [ ! -e "$HOME/.plenv/plugins/perl-build/bin/perl-build" ]; then
  echo "Installing plenv perl-build plugin"
  git clone --depth 50 https://github.com/tokuhirom/Perl-Build.git \
    "$HOME/.plenv/plugins/perl-build/"
fi
