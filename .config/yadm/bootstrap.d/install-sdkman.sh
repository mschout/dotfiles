#!/bin/sh

cd "$HOME"

# bail out if we don't have curl
[ -n "$(command -v curl)" ] || exit

# if sdkman is already installed, bail out
[ -e "$HOME/.sdkman/bin/sdkman-init.sh" ] && exit

# If sdkman is not installed, try to install it if we have curl
echo "Installing sdkman"
curl -s "https://get.sdkman.io" | bash
