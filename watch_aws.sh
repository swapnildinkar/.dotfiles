#!/bin/bash

REFRESH_RATE=20
REGION1=us-west-2
REGION2=us-east-1
SESSION_NAME=watch-aws

tmux has-session -t $SESSION_NAME
if [ $? -eq 0 ]
then
	echo "killing existing session"
	tmux kill-session -t $SESSION_NAME
fi

tmux new-session -d -s $SESSION_NAME "watch -n $REFRESH_RATE awless list instances -e -r $REGION1"

tmux split-window -dh -t 0 "watch -n $REFRESH_RATE awless list instances -r $REGION2"
tmux split-window -v -t 0 "watch -n $REFRESH_RATE awless list volumes -r $REGION1"
tmux split-window -v -t 2 "watch -n $REFRESH_RATE awless list volumes -r $REGION2"

tmux -2 attach-session -t $SESSION_NAME
