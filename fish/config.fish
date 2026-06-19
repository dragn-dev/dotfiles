set fish_greeting ""

set -gx TERM xterm-256color

if command -q dircolors
    eval (dircolors -c | string replace -r '^setenv (\S+) (.*)$' 'set -gx $1 $2;')
end

# aliases
alias ls "eza -lh --git --icons --group-directories-first"
alias la "eza -lha --git --icons --group-directories-first"
alias ll "eza -l --git --icons --group-directories-first"
alias lla "eza -la --git --icons --group-directories-first"
alias tree "eza --tree --icons"
alias cat "bat --paging=never"
alias find fd
abbr -a g git
abbr -a gs 'git status'
abbr -a gss 'git status -s'
abbr -a gd 'git diff'
abbr -a gds 'git diff --staged'
abbr -a gp 'git push'
abbr -a gl 'git pull'
abbr -a glog 'git log --oneline --graph --decorate'
abbr -a gc 'git commit'
abbr -a gcm 'git commit -m'
abbr -a gca 'git commit --amend'
abbr -a gco 'git checkout'
abbr -a gcb 'git checkout -b'
abbr -a gb 'git branch'
abbr -a gr 'git restore'
abbr -a grs 'git restore --staged'
abbr -a lg lazygit
abbr -a v nvim
abbr -a t tmux
abbr -a ta 'tmux attach'
abbr -a tls 'tmux ls'
abbr -a tm 'tmux new-session -A -s main'   # attach-or-create main
abbr -a tn 'tmux new-session -A -s'        # named: tn <name>
abbr -a tk 'tmux kill-session -t'          # kill: tk <name>
abbr -a tks 'tmux kill-server'             # nuke all sessions

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

# NodeJS
set -gx PATH node_modules/.bin $PATH

# Go
set -gx GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

set CONFIG_DIR (dirname (status --current-filename))

# OS-specific config (Homebrew, clipboard, PATH, etc.)
switch (uname)
    case Linux
        source $CONFIG_DIR/config-linux.fish
    case Darwin
        source $CONFIG_DIR/config-macos.fish
end

# Per-machine config (gitignored): secrets, host-only overrides.
if test -f $CONFIG_DIR/config-local.fish
    source $CONFIG_DIR/config-local.fish
end

if status is-interactive
    # Thin bar cursor instead of the fat block.
    # (variables cover vi-mode; the escape covers default emacs bindings)
    set -g fish_cursor_default line
    set -g fish_cursor_insert line
    printf '\e[6 q'

    starship init fish | source
    zoxide init fish | source
    direnv hook fish | source
    fzf --fish | source
    atuin init fish | source

    # Fresh shells (and the tmux session they spawn) start in ~/projects.
    # Guarded to $HOME so it never overrides panes opened in a project dir.
    if test "$PWD" = "$HOME"
        cd ~/projects
    end

    if not set -q TMUX
        exec tmux new-session -A -s main
    end
end
