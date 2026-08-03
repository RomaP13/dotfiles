#!/usr/bin/env bash

SHOW_GIT_STATUS=$(tmux show-option -gv @show_git_status)
if [ "$SHOW_GIT_STATUS" == "0" ]; then
  exit 0
fi

cd "$1" 2> /dev/null || exit 0

BRANCH=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
if [[ -z "$BRANCH" ]]; then
  exit 0
fi

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CURRENT_DIR/theme.sh"

RESET="#[default]"
STATUS=$(git status --porcelain 2> /dev/null | grep -cE "^(M| M)")

SYNC_MODE=0
NEED_PUSH=0

if [[ ${#BRANCH} -gt 25 ]]; then
  BRANCH="${BRANCH:0:25}…"
fi

STATUS_CHANGED=""
STATUS_INSERTIONS=""
STATUS_DELETIONS=""
STATUS_UNTRACKED=""

if [[ $STATUS -ne 0 ]]; then
  read -r -a DIFF_COUNTS <<< "$(git diff --numstat 2> /dev/null | awk 'NF==3 {changed+=1; ins+=$1; del+=$2} END {printf("%d %d %d", changed, ins, del)}')"
  CHANGED_COUNT=${DIFF_COUNTS[0]:-0}
  INSERTIONS_COUNT=${DIFF_COUNTS[1]:-0}
  DELETIONS_COUNT=${DIFF_COUNTS[2]:-0}

  SYNC_MODE=1
fi

UNTRACKED_COUNT=$(git ls-files --other --directory --exclude-standard 2> /dev/null | wc -l)

if [[ ${CHANGED_COUNT:-0} -gt 0 ]]; then
  STATUS_CHANGED="${RESET}#[fg=${THEME[yellow]},bold] ${CHANGED_COUNT} "
fi

if [[ ${INSERTIONS_COUNT:-0} -gt 0 ]]; then
  STATUS_INSERTIONS="${RESET}#[fg=${THEME[green]},bold] ${INSERTIONS_COUNT} "
fi

if [[ ${DELETIONS_COUNT:-0} -gt 0 ]]; then
  STATUS_DELETIONS="${RESET}#[fg=${THEME[red]},bold] ${DELETIONS_COUNT} "
fi

if [[ ${UNTRACKED_COUNT:-0} -gt 0 ]]; then
  STATUS_UNTRACKED="${RESET}#[fg=${THEME[gray]},bold] ${UNTRACKED_COUNT} "
fi

# Determine repository sync status
if [[ $SYNC_MODE -eq 0 ]]; then
  NEED_PUSH=$(git log '@{push}..' 2> /dev/null | wc -l)
  if [[ ${NEED_PUSH:-0} -gt 0 ]]; then
    SYNC_MODE=2
  else
    FETCH_FILE="$(git rev-parse --git-dir 2> /dev/null)/FETCH_HEAD"
    if [[ -f "$FETCH_FILE" ]]; then
      LAST_FETCH=$(stat -c %Y "$FETCH_FILE" 2> /dev/null || echo 0)
      NOW=$(date +%s)

      if [[ $((NOW - LAST_FETCH)) -gt 300 ]]; then
        git fetch --atomic origin --negotiation-tip=HEAD 2> /dev/null
      fi
    fi

    REMOTE_DIFF=$(git diff --numstat "${BRANCH}" "origin/${BRANCH}" 2> /dev/null)
    if [[ -n $REMOTE_DIFF ]]; then
      SYNC_MODE=3
    fi
  fi
fi

# Apply dynamic palette to sync indicator too
case "$SYNC_MODE" in
  1) REMOTE_STATUS="$RESET#[fg=${THEME[red]},bold]▒ 󱓎" ;;
  2) REMOTE_STATUS="$RESET#[fg=${THEME[red]},bold]▒ 󰛃" ;;
  3) REMOTE_STATUS="$RESET#[fg=${THEME[yellow]},bold]▒ 󰛀" ;;
  *) REMOTE_STATUS="$RESET#[fg=${THEME[green]},bold]▒ " ;;
esac

echo "$REMOTE_STATUS $RESET$BRANCH $STATUS_CHANGED$STATUS_INSERTIONS$STATUS_DELETIONS$STATUS_UNTRACKED"
