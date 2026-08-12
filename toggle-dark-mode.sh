#!/usr/bin/env bash

set -euo pipefail

current=$(gsettings get org.gnome.desktop.interface color-scheme)

if [[ "$current" == "'prefer-dark'" ]]; then
  gsettings set org.gnome.desktop.interface gtk-theme Yaru
  gsettings set org.gnome.desktop.interface color-scheme prefer-light
  echo "Switched to light mode"
else
  gsettings set org.gnome.desktop.interface gtk-theme Yaru-dark
  gsettings set org.gnome.desktop.interface color-scheme prefer-dark
  echo "Switched to dark mode"
fi
