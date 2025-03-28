* temuxed_mnr_mining.sh - startup script for mining
* monerod_run.sh - runs inside the tmux session, no need to launch separately

switching between windows: `ctrl+b`, then `o`

To detach from a `tmux` session and then reconnect to it, follow these steps:

### 1. **Detaching from a `tmux` session:**

To detach from the current `tmux` session without terminating it, use the following key combination:

```
Ctrl + b, then d
```

- Press and hold `Ctrl`, then press `b`.
- After releasing these keys, press `d`. This action will detach you from the session, but the session will continue to run in the background.

### 2. **Reconnecting to a `tmux` session:**

To reconnect to the same session, execute the command:

```bash
tmux attach-session -t <session_name>
```

Replace `<session_name>` with the name or number of the session you want to connect to. To see a list of active sessions, run the command:

```bash
tmux ls
```

Example:

- If you have one active session, you can connect to it like this:
  ```bash
  tmux attach-session
  ```

Now you can detach from the session and reconnect to it at any time.

To terminate a `tmux` session, there are several methods:

### 1. Terminating a session from within:
- Inside an active `tmux` session, you can simply close all windows and panes, which will automatically end the session. To do this, close the current command shell (for example, using the `exit` command):
   ```bash
   exit
   ```

### 2. Terminating using the `tmux kill-session` command:
- If you want to terminate a specific `tmux` session without being in it, execute the command:
   ```bash
   tmux kill-session -t <session_name>
   ```
   Replace `<session_name>` with the name of the session you want to terminate. To find out the session name, you can use the command:
   ```bash
   tmux ls
   ```

### 3. Terminating all sessions:
- To terminate all active `tmux` sessions, execute the command:
   ```bash
   tmux kill-server
   ```

This method terminates all active `tmux` sessions and stops the `tmux` server itself.
