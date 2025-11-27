#!/bin/bash

# Terminal Tools Installation Script
# This script installs various terminal utilities and tools, sets up symlinks,
# and configures shell files

# Note: We don't use 'set -e' here because we want to continue even if some
# operations fail (e.g., symlink creation for optional files)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR"
HOME_DIR="$HOME"

echo "🚀 Installing terminal tools and setting up dotfiles..."
echo "📁 Dotfiles directory: $DOTFILES_DIR"

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "❌ Homebrew is not installed. Please install Homebrew first:"
    echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    exit 1
fi

echo "✅ Homebrew is installed"

# Update Homebrew
echo "📦 Updating Homebrew..."
brew update

# Install core tools (only if not already installed)
echo "🔧 Installing core tools..."

# Check and install tldr
if ! brew list tldr &> /dev/null; then
    echo "📖 Installing tldr..."
    brew install tldr
else
    echo "✅ tldr already installed"
fi

# Check and install ncdu
if ! brew list ncdu &> /dev/null; then
    echo "💾 Installing ncdu..."
    brew install ncdu
else
    echo "✅ ncdu already installed"
fi

# Check and install fd
if ! brew list fd &> /dev/null; then
    echo "🔍 Installing fd..."
    brew install fd
else
    echo "✅ fd already installed"
fi

# Check and install trash
if ! brew list trash &> /dev/null; then
    echo "🗑️ Installing trash..."
    brew install trash
else
    echo "✅ trash already installed"
fi

# Check and install timer for Pomodoro
if ! brew list timer &> /dev/null; then
    echo "⏰ Installing timer for Pomodoro..."
    brew install caarlos0/tap/timer
else
    echo "✅ timer already installed"
fi

# Check and install terminal-notifier
if ! brew list terminal-notifier &> /dev/null; then
    echo "🔔 Installing terminal-notifier..."
    brew install terminal-notifier
else
    echo "✅ terminal-notifier already installed"
fi

# Check and install zoxide
if ! brew list zoxide &> /dev/null; then
    echo "📁 Installing zoxide..."
    brew install zoxide
else
    echo "✅ zoxide already installed"
fi

# Check and install ripgrep
if ! brew list ripgrep &> /dev/null; then
    echo "🔍 Installing ripgrep..."
    brew install ripgrep
else
    echo "✅ ripgrep already installed"
fi

# Check and install fzf
if ! brew list fzf &> /dev/null; then
    echo "🔎 Installing fzf..."
    brew install fzf
else
    echo "✅ fzf already installed"
fi

# Check and install atuin
if ! brew list atuin &> /dev/null; then
    echo "📜 Installing atuin..."
    brew install atuin
else
    echo "✅ atuin already installed"
fi

echo ""
echo "🔗 Setting up symlinks..."

# Function to create symlink safely
create_symlink() {
    local source_file="$1"
    local target_file="$2"
    local description="$3"
    
    if [ ! -f "$source_file" ]; then
        echo "⚠️  Warning: Source file not found: $source_file"
        return 1
    fi
    
    # Check if target already exists
    if [ -e "$target_file" ] || [ -L "$target_file" ]; then
        if [ -L "$target_file" ]; then
            # Check if it's already pointing to the right place
            local current_target=$(readlink "$target_file")
            if [ "$current_target" = "$source_file" ]; then
                echo "✅ $description already linked correctly"
                return 0
            else
                echo "⚠️  $description exists but points to different location: $current_target"
                echo "   Removing old symlink..."
                rm "$target_file"
            fi
        else
            echo "⚠️  $description already exists as a regular file: $target_file"
            echo "   Backing up to ${target_file}.backup..."
            mv "$target_file" "${target_file}.backup"
        fi
    fi
    
    # Create symlink
    ln -s "$source_file" "$target_file"
    echo "✅ Created symlink: $description"
}

# Create symlinks for dotfiles
create_symlink "$DOTFILES_DIR/.shell_aliases" "$HOME_DIR/.shell_aliases" "Shell aliases" || true
create_symlink "$DOTFILES_DIR/.wezterm.lua" "$HOME_DIR/.wezterm.lua" "WezTerm configuration" || true

echo ""
echo "⚙️  Configuring shell files..."

# Detect shell config file (.zshrc for zsh, .bashrc for bash)
SHELL_CONFIG=""
if [ -n "$ZSH_VERSION" ] || [ -f "$HOME_DIR/.zshrc" ]; then
    SHELL_CONFIG="$HOME_DIR/.zshrc"
elif [ -n "$BASH_VERSION" ] || [ -f "$HOME_DIR/.bashrc" ]; then
    SHELL_CONFIG="$HOME_DIR/.bashrc"
else
    # Default to .zshrc on macOS
    SHELL_CONFIG="$HOME_DIR/.zshrc"
fi

# Add shell aliases loading if not already present
ALIASES_SNIPPET='if [ -f ~/.shell_aliases ]; then
      echo "adding my own aliases"
    . ~/.shell_aliases
fi'

# Configure shell file
if [ -f "$SHELL_CONFIG" ]; then
    # Add shell aliases if not present
    if grep -q "\.shell_aliases" "$SHELL_CONFIG"; then
        echo "✅ Shell aliases already configured in $SHELL_CONFIG"
    else
        echo "📝 Adding shell aliases configuration to $SHELL_CONFIG..."
        echo "" >> "$SHELL_CONFIG"
        echo "# Load custom shell aliases" >> "$SHELL_CONFIG"
        echo "$ALIASES_SNIPPET" >> "$SHELL_CONFIG"
        echo "✅ Added shell aliases configuration"
    fi
    
    # Add atuin initialization if not present (only for zsh)
    if [[ "$SHELL_CONFIG" == *".zshrc"* ]]; then
        if grep -q "atuin init" "$SHELL_CONFIG"; then
            echo "✅ Atuin already configured in $SHELL_CONFIG"
        else
            echo "📝 Adding Atuin initialization to $SHELL_CONFIG..."
            echo "" >> "$SHELL_CONFIG"
            echo "# Initialize Atuin (shell history)" >> "$SHELL_CONFIG"
            echo 'eval "$(atuin init zsh)"' >> "$SHELL_CONFIG"
            echo "✅ Added Atuin configuration"
        fi
    fi
else
    echo "📝 Creating $SHELL_CONFIG with shell configuration..."
    echo "# Shell configuration" > "$SHELL_CONFIG"
    echo "$ALIASES_SNIPPET" >> "$SHELL_CONFIG"
    
    # Add atuin initialization if creating .zshrc
    if [[ "$SHELL_CONFIG" == *".zshrc"* ]]; then
        echo "" >> "$SHELL_CONFIG"
        echo "# Initialize Atuin (shell history)" >> "$SHELL_CONFIG"
        echo 'eval "$(atuin init zsh)"' >> "$SHELL_CONFIG"
    fi
    echo "✅ Created $SHELL_CONFIG"
fi

# Import existing shell history into Atuin (if atuin is installed and we're using zsh)
if command -v atuin &> /dev/null && [[ "$SHELL_CONFIG" == *".zshrc"* ]]; then
    echo ""
    echo "📜 Setting up Atuin history..."
    if [ -f "$HOME_DIR/.zsh_history" ] && [ -s "$HOME_DIR/.zsh_history" ]; then
        echo "📥 Importing existing zsh history into Atuin..."
        atuin import auto 2>/dev/null || echo "⚠️  Could not import history (this is okay if Atuin database is new)"
    else
        echo "ℹ️  No existing zsh history found to import"
    fi
    echo "✅ Atuin setup complete"
    echo "   Note: You can set up Atuin sync later with 'atuin register' and 'atuin sync'"
fi

echo ""
echo "✅ All tools installed successfully!"
echo ""
echo "📋 Installed tools:"
echo "   - tldr: Simplified man pages"
echo "   - ncdu: Interactive disk usage analyzer"
echo "   - fd: User-friendly find alternative"
echo "   - trash: Safer file deletion"
echo "   - timer: Pomodoro timer"
echo "   - terminal-notifier: macOS notifications"
echo "   - zoxide: Smarter cd command"
echo "   - ripgrep: Fast text search"
echo "   - fzf: Fuzzy finder"
echo "   - atuin: Better shell history"
echo ""
echo "🔗 Symlinks created:"
echo "   - ~/.shell_aliases -> $DOTFILES_DIR/.shell_aliases"
echo "   - ~/.wezterm.lua -> $DOTFILES_DIR/.wezterm.lua"
echo ""
echo "🔄 To apply changes, run: source $SHELL_CONFIG"
echo "   Or restart your terminal"
