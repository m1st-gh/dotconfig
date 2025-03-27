#! /bin/env fish



tmux list-panes -F "#{pane_id} #{pane_current_command}" | grep "nvim" | head -n 1 | string split -f 1 " " | read -l pane_id; tmux select-pane -t "$pane_id"; tmux resize-pane -t "$pane_id" -Z

