#!/usr/bin/env zsh

if [ -z $TMUX ] && [ -z $SKIP_TMUX ]; then
  delimiter=","
  sessions=$(tmux list-sessions -F "#{session_attached}${delimiter}#{session_id}")
  unused_sessions=$(echo $sessions | grep ^0)
  unused_sessions_ids=$(echo $unused_sessions | cut --delimiter=$delimiter --fields=2)
  sorted_unused_sessions_ids=$(echo $unused_sessions_ids | sort --numeric)
  first_unused_session_id=$(echo $sorted_unused_sessions_ids | head --lines 1)
  if [ -z $first_unused_session_id ]; then
    exec tmux new-session
  else
    exec tmux attach-session -t $first_unused_session_id
  fi
fi
