#!/bin/sh

# bail out if gesttings is not installed
[ -n "$(command -v gsettings)" ] && exit

# disable gnome donation notification
gsettings set org.gnome.settings-daemon.plugins.housekeeping \
  donation-reminder-enabled false >/dev/null 2>&1

