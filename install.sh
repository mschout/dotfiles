#!/bin/sh
# Root install script for this dotfiles repo. Invoked by `coder dotfiles`.
# Ensures yadm exists, then hands $HOME to yadm (checkout + bootstrap).
# OS-agnostic; safe to re-run.
set -eu

REPO="https://github.com/mschout/dotfiles.git"

# yadm is a single bash script — if missing, fetch it to ~/.local/bin.
# No package manager, no sudo; works on Linux/macOS/BSD alike.
if ! command -v yadm >/dev/null 2>&1; then
  mkdir -p "$HOME/.local/bin"
  URL="https://raw.githubusercontent.com/yadm-dev/yadm/master/yadm"
  if command -v curl >/dev/null 2>&1; then
    curl -fLo "$HOME/.local/bin/yadm" "$URL"
  else
    wget -O "$HOME/.local/bin/yadm" "$URL"
  fi
  chmod +x "$HOME/.local/bin/yadm"
  PATH="$HOME/.local/bin:$PATH"; export PATH
fi

# Clone (fresh) or update (existing), force-apply tracked files over anything the
# platform pre-seeded (~/.gitconfig, ~/.bashrc), THEN bootstrap — so .gitmodules
# is present before bootstrap.d runs `yadm submodule update`.
yadm clone --no-bootstrap "$REPO" 2>/dev/null || yadm pull --ff-only || true
yadm checkout "$HOME" || true
yadm bootstrap || true
