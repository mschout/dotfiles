#!/bin/sh
#
# install the plenv perl-build plugin if necessary
#

set -e

function install_plenv_plugin() {
  local plugin_name=$1
  local plugin_repo=$2

  if [ ! -e "$HOME/.plenv/plugins/$plugin_name/.git" ]; then
    echo "Installing plenv $plugin_name plugin"
    git clone --depth 50 $plugin_repo "$HOME/.plenv/plugins/$plugin_name/"
  fi
}

# Ensure plenv is present
[ -e "$HOME/.plenv/bin/plenv" ] || exit 0

install_plenv_plugin perl-build https://github.com/tokuhirom/Perl-Build.git

install_plenv_plugin plenv-freeze https://github.com/skaji/plenv-freeze
