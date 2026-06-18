function tmux --description 'Attach to existing tmux session or create new'
    if test (count $argv) -eq 0
        if command tmux has-session 2>/dev/null
            command tmux attach
        else
            command tmux new
        end
    else
        command tmux $argv
    end
end
