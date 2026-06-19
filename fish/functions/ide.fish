function ide --description "Window [1] nvim, window [2] lazygit + dev server"
    if not set -q TMUX
        echo "ide: run this inside tmux"
        return 1
    end

    set -l dir (pwd)

    # Window [1]: neovim in the current window.
    set -l wnvim (tmux display-message -p '#{window_id}')
    tmux send-keys -t $wnvim "nvim ." Enter

    # Window [2]: split into lazygit (left) + dev server (right).
    set -l wide (tmux new-window -c $dir -P -F '#{window_id}')
    set -l pleft (tmux list-panes -t $wide -F '#{pane_id}' | head -n1)
    set -l pright (tmux split-window -h -c $dir -t $pleft -P -F '#{pane_id}')

    # Left: lazygit.
    tmux send-keys -t $pleft "lazygit" Enter

    # Right: dev server, but only in a node project with a dev script.
    if command -q npm; and test -f $dir/package.json; and grep -q '"dev"' $dir/package.json
        tmux send-keys -t $pright "npm run dev" Enter
    end

    tmux select-pane -t $pright
    tmux select-window -t $wnvim
end
