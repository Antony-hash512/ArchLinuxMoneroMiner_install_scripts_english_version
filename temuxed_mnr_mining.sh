#!/bin/bash
sudo sysctl vm.nr_hugepages=3072

# Start a new tmux session named my_session and don't detach
tmux new-session -d -s xmr_mining

# Split the window horizontally
tmux split-window -h

# Switch to the first pane (left)
tmux select-pane -t 0

# Split the left pane vertically
tmux split-window -v

# Switch to the second pane (right)
tmux select-pane -t 1

# Split the right pane vertically
tmux split-window -v

# Run commands in each pane

# First pane (upper left)
tmux select-pane -t 0
#tmux send-keys 'monerod --zmq-pub tcp://127.0.0.1:18083 --out-peers 32 --in-peers 64 --add-priority-node=p2pmd.xmrvsbeast.com:18080 --add-priority-node=nodes.hashvault.pro:18080 --disable-dns-checkpoints --enable-dns-blocklist' C-m
tmux send-keys '~/monerod_run.sh' C-m

# Second pane (lower left)
tmux select-pane -t 2
tmux send-keys 'sysctl vm.nr_hugepages' C-m
tmux send-keys 'p2pool --host 127.0.0.1 --mini --wallet 43UgFYo22kH47LqJnSUHXsPHzQh92caAv62jVvj7vvSmXebDXH5cpsr4iTQQwYMwRU2GcHMZrSowESmrmQ5XQEm58fFR3Nm'

# Third pane (upper right)
tmux select-pane -t 1
#tmux send-keys 'sudo xmrig -u x+1730000000 -o 127.0.0.1:3333 -t 16' #full
tmux send-keys 'sudo xmrig -u x+1730000000 -o 127.0.0.1:3333 -t 16' #mini


# Fourth pane (lower right)
tmux select-pane -t 3
tmux send-keys 'htop' C-m

# Connect to the session
tmux attach-session -t xmr_mining
