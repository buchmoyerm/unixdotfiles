#!/bin/bash


# Run only in tmux
if [ "$TMUX_PANE" == "" ]
then
        exit 0
fi

# Retrieve information about tmux
WINDOW=`/usr/bin/tmux display -pt $TMUX_PANE '#S:#I' 2> /dev/null`
IS_WINDOW_ACTIVE=`/usr/bin/tmux display -pt $TMUX_PANE '#{window_active}' 2> /dev/null`

if [ "$IS_WINDOW_ACTIVE" == "0" ] && [ "$WINDOW" != "" ]
then
    # Enable visual activity
    /usr/bin/tmux set-window-option -t $WINDOW monitor-activity on > /dev/null

    # Print nothing, but this triggers the activity monitor. Requires bash to not fuck up the output.
    echo -ne "\0"

    # Alternative, but not tested
    # /usr/bin/tmux send-keys -t $WINDOW Space C-H

    # Disable visual activity again
    /usr/bin/tmux set-window-option -t $WINDOW monitor-activity off > /dev/null
fi
