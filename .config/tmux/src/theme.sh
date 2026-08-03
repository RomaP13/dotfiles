#!/usr/bin/env bash
# shellcheck disable=SC2034

# Read @use_pywal_colors setting from tmux
USE_PYWAL=$(tmux show-option -gv @use_pywal_colors 2> /dev/null)

declare -A THEME

if [[ "$USE_PYWAL" == "1" ]]; then
  # --- Pywal Palette ---
  THEME[accent]="color4"
  THEME[accent_text]="color0"
  THEME[tab_bg]="color8"
  THEME[tab_fg]="color7"

  THEME[red]="color10"
  THEME[yellow]="color5"
  THEME[green]="color3"
  THEME[orange]="color2"
  THEME[gray]="color8"
  THEME[white]="color15"
else
  # --- Static Gruvbox Hex Palette ---
  THEME[accent]="#83a598"
  THEME[accent_text]="#1d2021"
  THEME[tab_bg]="#3c3836"
  THEME[tab_fg]="#ebdbb2"

  THEME[red]="#e06c75"
  THEME[green]="#98c379"
  THEME[yellow]="#e5c07b"
  THEME[orange]="#fabd2f"
  THEME[gray]="#5c6370"
  THEME[white]="#fbf1c7"
fi
