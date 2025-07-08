#!/bin/sh
# On a fresh machine, I would have cloned the https repo, but after pulling switch to ssh

echo "Updating the yadm repo origin URL"

yadm remote set-url origin "git@github.com:mschout/dotfiles.git"
