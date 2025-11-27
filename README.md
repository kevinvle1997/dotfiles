# Dotfiles

This repository contains my dotfiles including shell aliases (works across both Zsh and Bash) and WezTerm configuration.

## Installation

1. Clone this repository:
```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
```

2. Create symbolic links to the configuration files:
```bash
# Shell aliases
ln -s ~/dotfiles/.shell_aliases ~/.shell_aliases

# WezTerm configuration
ln -s ~/dotfiles/.wezterm.lua ~/.wezterm.lua
```

3. Add the following to your `.zshrc` or `.bashrc`:
```bash
if [ -f ~/.shell_aliases ]; then
      echo "adding my own aliases"
    . ~/.shell_aliases
fi

```


some linuix commands


# Utility Commands
alias tldr='tldr'  # Simpler man pages with practical examples
alias timeout='timeout'  # Run commands with time limit
alias ncdu='ncdu'  # Interactive disk usage analyzer
alias fd='fd'  # User-friendly alternative to find
alias trash='trash'  # Safer file deletion (moves to trash)
alias trash-restore='trash-restore'  # Restore files from trash

# Note: To use these commands, you'll need to install them first:
# - tldr: brew install tldr
# - ncdu: brew install ncdu
# - fd: brew install fd
# - trash: brew install trash

brew install tldr ncdu fd trash