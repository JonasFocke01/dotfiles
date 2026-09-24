#!/bin/bash

tmux new-session -d -s gh-actions

echo -n "Starting-gh-actions-runners: ";

INDEX=0

for dir in $HOME/actions-runners/*; do
    [ -d "$dir" ] || continue
    echo -n "$(basename "$dir") ";

    tmux rename-window -t gh-actions:$INDEX "$dir"
    tmux send-keys -t gh-actions:$INDEX "cd $dir && ./run.sh" C-m
    tmux new-window -t gh-actions

    INDEX=$(( INDEX + 1 ))
done

tmux send-keys -t gh-actions:$INDEX "exit" C-m

echo ""
echo "Done"
