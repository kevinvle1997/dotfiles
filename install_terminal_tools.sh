#!/bin/bash

# Terminal Tools Installation Script
# This script installs various terminal utilities and tools

echo "🚀 Installing terminal tools..."

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
echo "🔄 To apply changes, run: source ~/.zshrc"
