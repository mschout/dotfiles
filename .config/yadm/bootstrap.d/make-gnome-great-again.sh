#!/bin/sh

# bail out if gesttings is not installed
[ -n "$(command -v gsettings)" ] && exit

# disable gnome donation notification
gsettings set org.gnome.settings-daemon.plugins.housekeeping \
  donation-reminder-enabled false >/dev/null 2>&1

# disabling middle button paste by default with no exposed setting.
# Seriously Gnome?!?!?!
gsettings set org.gnome.desktop.interface gtk-enable-primary-paste true

