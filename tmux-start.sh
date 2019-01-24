#!/bin/bash

# Starting TMUX
$(which tmux) attach -t main || tmux new -s main
