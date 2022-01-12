#!/bin/bash

# Starting TMUX
$(which tmux) attach -t main || $(which tmux) new -s main
