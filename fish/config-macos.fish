# macOS only.

# Homebrew (Apple Silicon).
if test -d /opt/homebrew
    /opt/homebrew/bin/brew shellenv | source
# Homebrew (Intel).
else if test -d /usr/local/Homebrew
    /usr/local/bin/brew shellenv | source
end
