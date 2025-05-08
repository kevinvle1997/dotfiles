# Shell Aliases

This repository contains my shell aliases that work across both Zsh and Bash shells.

## Installation

1. Clone this repository:
```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
```

2. Create a symbolic link to the aliases file:
```bash
ln -s ~/dotfiles/.shell_aliases ~/.shell_aliases
```

3. Add the following to your `.zshrc` or `.bashrc`:
```bash
if [ -f ~/.shell_aliases ]; then
    . ~/.shell_aliases
fi
```

## Available Aliases

The `.shell_aliases` file includes shortcuts for:
- Directory navigation
- Git commands
- Python/Django development
- Node.js development
- Docker commands
- System utilities
- Network commands
- And more!

## Customization

Feel free to modify the `.shell_aliases` file to add your own custom aliases or remove ones you don't use. 