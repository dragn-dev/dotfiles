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

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

# NodeJS
set -gx PATH node_modules/.bin $PATH

# Go
set -gx GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

source (dirname (status --current-filename))/config-linux.fish

set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish

if test -f $LOCAL_CONFIG
    source $LOCAL_CONFIG
end

if test -d /home/linuxbrew/.linuxbrew
    # Homebrew is installed on Linux

    set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
    set -gx HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar"
    set -gx HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew"
    set -gx PATH "/home/linuxbrew/.linuxbrew/bin" "/home/linuxbrew/.linuxbrew/sbin" $PATH
    set -q MANPATH; or set MANPATH ''
    set -gx MANPATH "/home/linuxbrew/.linuxbrew/share/man" $MANPATH
    set -q INFOPATH; or set INFOPATH ''
    set -gx INFOPATH "/home/linuxbrew/.linuxbrew/share/info" $INFOPATH

else if test -d /opt/homebrew
    # Homebrew is installed on MacOS

    /opt/homebrew/bin/brew shellenv | source
end

if status is-interactive
    starship init fish | source
    zoxide init fish | source
    direnv hook fish | source
    fzf --fish | source
    atuin init fish | source

    if not set -q TMUX
        exec tmux
    end
end
