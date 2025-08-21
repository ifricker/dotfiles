#!/bin/bash
# macOS Development Environment Setup Script
# Optimized for Rails/Ruby development
# Author: Generated for ifricker's dotfiles

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Logging functions
log() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }
header() { echo -e "\n${BLUE}=== $1 ===${NC}"; }

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
        log "Detected macOS"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS="linux"
        log "Detected Linux"
    else
        error "Unsupported OS: $OSTYPE"
        exit 1
    fi
}

# Check if running on macOS
require_macos() {
    if [[ "$OS" != "macos" ]]; then
        error "This feature requires macOS"
        return 1
    fi
}

# Install Xcode Command Line Tools (macOS)
install_xcode_tools() {
    require_macos || return 0

    if xcode-select -p &>/dev/null; then
        log "Xcode Command Line Tools already installed"
    else
        header "Installing Xcode Command Line Tools"
        xcode-select --install
        log "Please complete the Xcode Command Line Tools installation and re-run this script"
        exit 0
    fi
}

# Install Homebrew (macOS) or Linuxbrew (Linux)
install_homebrew() {
    if command -v brew &>/dev/null; then
        log "Homebrew already installed"
        # Update Homebrew
        brew update
    else
        header "Installing Homebrew"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # Add Homebrew to PATH based on OS
        if [[ "$OS" == "macos" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        fi
    fi
}

# Install essential tools via Homebrew
install_homebrew_packages() {
    header "Installing Homebrew packages"

    # Essential development tools (Rails-optimized)
    brew install git
    brew install neovim
    brew install tmux
    brew install fzf
    brew install ripgrep  # Better grep for code search
    brew install fd       # Better find for file search
    brew install bat      # Better cat with syntax highlighting
    brew install exa      # Better ls
    brew install htop     # Better top
    brew install jq       # JSON processor (great for Rails API debugging)
    brew install curl
    brew install wget
    brew install tree
    brew install postgresql@14  # Rails standard DB
    brew install redis          # Rails caching/background jobs
    brew install imagemagick    # Rails image processing
    brew install node           # For Rails asset pipeline

    # macOS specific tools
    if [[ "$OS" == "macos" ]]; then
        brew install --cask iterm2
        brew install --cask google-chrome
        brew install --cask visual-studio-code  # Backup editor
        brew install --cask docker
        brew install --cask postman            # API testing
        brew install --cask tableplus          # Database GUI
        brew install mas                        # Mac App Store CLI
    fi
}

# Install Ruby version manager (rbenv - preferred for Rails)
install_rbenv() {
    header "Installing rbenv (Ruby Version Manager)"

    if command -v rbenv &>/dev/null; then
        log "rbenv already installed"
    else
        brew install rbenv ruby-build
        log "rbenv installed successfully"
    fi

    # Initialize rbenv for current session
    eval "$(rbenv init -)"

    # Install latest stable Ruby
    LATEST_RUBY=$(rbenv install -l | grep -v - | grep -v preview | tail -1 | tr -d ' ')
    if ! rbenv versions | grep -q "$LATEST_RUBY"; then
        log "Installing Ruby $LATEST_RUBY"
        rbenv install $LATEST_RUBY
    else
        log "Ruby $LATEST_RUBY already installed"
    fi
    rbenv global $LATEST_RUBY

    # Install essential Rails gems
    log "Installing essential Rails gems"
    gem update --system --quiet
    gem install bundler
    gem install rails
    gem install rubocop        # Ruby linter (matches your vim config)
    gem install solargraph     # Ruby language server
    gem install pry           # Better Rails console
    gem install pry-rails
}

# Install Node version manager (nvm)
install_nvm() {
    header "Installing nvm (Node Version Manager)"

    if [[ -s "$HOME/.nvm/nvm.sh" ]]; then
        log "nvm already installed"
        # Load nvm for current session
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    else
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        log "nvm installed successfully"
    fi

    # Install latest LTS Node
    nvm install --lts
    nvm use --lts
    nvm alias default node

    # Install global packages useful for Rails
    npm install -g yarn         # Preferred package manager for Rails 7+
    npm install -g prettier     # Code formatter (matches your vim config)
    npm install -g eslint       # JS linter
}

# Install Oh My Zsh with Powerlevel10k
install_oh_my_zsh() {
    header "Installing Oh My Zsh with Powerlevel10k"

    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        log "Oh My Zsh already installed"
    else
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi

    # Install Powerlevel10k theme
    if [[ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]]; then
        log "Powerlevel10k already installed"
    else
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    fi

    # Install useful plugins (matches your .zshrc)
    if [[ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/alias-tips" ]]; then
        git clone https://github.com/djui/alias-tips.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/alias-tips
    fi
}

# Install vim-plug and Neovim plugins
install_neovim_plugins() {
    header "Installing Neovim plugins"

    # Install vim-plug if not exists
    if [[ ! -f "$HOME/.vim/autoload/plug.vim" ]]; then
        log "Installing vim-plug"
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        log "vim-plug already installed"
    fi

    # Install plugins automatically
    log "Installing Neovim plugins (this may take a moment)..."
    nvim --headless +PlugInstall +qall
    log "Neovim plugins installed successfully"
}

# Setup iTerm2 with your custom profile
setup_iterm_profile() {
    require_macos || return 0

    header "Configuring iTerm2"

    # Check if iTerm2 is installed
    if ! command -v iterm2 &>/dev/null && ! ls /Applications/iTerm.app &>/dev/null; then
        warn "iTerm2 not found. Installing via Homebrew..."
        brew install --cask iterm2
    fi

    DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
    ITERM_PLIST="$HOME/Library/Preferences/com.googlecode.iterm2.plist"

    if [[ -f "$DOTFILES_DIR/iterm2-profile.plist" ]]; then
        # Backup existing iTerm settings
        if [[ -f "$ITERM_PLIST" ]]; then
            cp "$ITERM_PLIST" "$ITERM_PLIST.backup.$(date +%Y%m%d_%H%M%S)"
            log "Backed up existing iTerm2 settings"
        fi

        # Copy your custom iTerm profile
        cp "$DOTFILES_DIR/iterm2-profile.plist" "$ITERM_PLIST"
        log "Applied custom iTerm2 profile with all your settings"
        warn "Please restart iTerm2 for changes to take effect"
    else
        warn "iTerm2 profile not found in dotfiles"
    fi
}

# Setup dotfiles with symlinks
setup_dotfiles() {
    header "Setting up dotfiles"

    DOTFILES_DIR="$HOME/.dotfiles"

    # Clone or update dotfiles
    if [[ -d "$DOTFILES_DIR" ]]; then
        log "Updating existing dotfiles"
        cd "$DOTFILES_DIR"
        git pull
    else
        log "Cloning dotfiles repository"
        git clone https://github.com/ifricker/dotfiles.git "$DOTFILES_DIR"
    fi

    # Backup existing files
    backup_dir="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir"

    for file in .zshrc .config/nvim/init.vim; do
        if [[ -f "$HOME/$file" ]] && [[ ! -L "$HOME/$file" ]]; then
            log "Backing up existing $file"
            mkdir -p "$backup_dir/$(dirname "$file")"
            cp "$HOME/$file" "$backup_dir/$file"
        fi
    done

    # Create symlinks
    log "Creating symlinks"
    ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
    mkdir -p "$HOME/.config/nvim"
    ln -sf "$DOTFILES_DIR/.config/nvim/init.vim" "$HOME/.config/nvim/init.vim"
    
    # Setup environment variables
    if [[ ! -f "$HOME/.env" ]]; then
        log "Creating .env file from example"
        cp "$DOTFILES_DIR/.env.example" "$HOME/.env"
        warn "Please edit ~/.env and add your actual API keys and secrets"
    else
        log ".env file already exists"
    fi

    log "Dotfiles installed successfully"
    if [[ -d "$backup_dir" ]] && [[ "$(ls -A "$backup_dir")" ]]; then
        log "Backup created at: $backup_dir"
    fi

    # Export DOTFILES_DIR for other functions
    export DOTFILES_DIR
}

# Setup development authentication and CLI tools
install_development_auth() {
    header "Installing Development Authentication & CLI Tools"

    # Install GitHub CLI
    if ! command -v gh &>/dev/null; then
        log "Installing GitHub CLI"
        brew install gh
    else
        log "GitHub CLI already installed"
    fi

    # Install Claude Code CLI
    if ! command -v claude &>/dev/null; then
        log "Installing Claude Code CLI"
        npm install -g @anthropic-ai/claude-code
    else
        log "Claude Code CLI already installed"
    fi

    # Set up Git global configuration
    log "Setting up Git global configuration"
    # Load environment variables for git config
    if [[ -f "$HOME/.env" ]]; then
        source "$HOME/.env"
    else
        warn "No .env file found. Using placeholder values for Git config."
        warn "Please create ~/.env and set GIT_USER_NAME and GIT_USER_EMAIL"
    fi
    
    git config --global user.name "${GIT_USER_NAME:-'Your Name'}"
    git config --global user.email "${GIT_USER_EMAIL:-'your-email@example.com'}"
    git config --global init.defaultBranch main
    git config --global pull.rebase false

    # Generate SSH key if it doesn't exist
    if [[ ! -f "$HOME/.ssh/id_ed25519" ]]; then
        log "Generating SSH key for GitHub"
        ssh-keygen -t ed25519 -C "${GIT_USER_EMAIL:-'your-email@example.com'}" -f "$HOME/.ssh/id_ed25519" -N ""

        # Start SSH agent and add key
        eval "$(ssh-agent -s)"
        ssh-add "$HOME/.ssh/id_ed25519"

        log "SSH key generated at ~/.ssh/id_ed25519.pub"
    else
        log "SSH key already exists"
    fi

    log "Development authentication setup complete"
    warn "Manual steps required:"
    warn "1. Add SSH key to GitHub: cat ~/.ssh/id_ed25519.pub | pbcopy"
    warn "2. Run: gh auth login (to authenticate GitHub CLI)"
    warn "3. Run: :Copilot setup (in nvim to authenticate Copilot)"
    warn "4. Set up Claude Code API key when prompted"
}

# Start essential services
start_services() {
    require_macos || return 0

    header "Starting essential services"

    # Start PostgreSQL
    if brew services list | grep postgresql@14 | grep -q stopped; then
        log "Starting PostgreSQL"
        brew services start postgresql@14
    else
        log "PostgreSQL already running"
    fi

    # Start Redis
    if brew services list | grep redis | grep -q stopped; then
        log "Starting Redis"
        brew services start redis
    else
        log "Redis already running"
    fi
}

# Final setup steps and instructions
final_setup() {
    header "Setup Complete! 🎉"

    log "Your development environment has been set up successfully!"
    log ""
    log "🔧 What was installed/configured:"
    log "  • Homebrew and essential development tools"
    log "  • Ruby (via rbenv) with Rails and essential gems"
    log "  • Node.js (via nvm) with Yarn, Prettier, ESLint"
    log "  • Oh My Zsh with Powerlevel10k theme"
    log "  • Neovim with all your plugins"
    log "  • iTerm2 with your custom profile"
    log "  • PostgreSQL and Redis (installed but not started)"
    log ""
    log "📝 Next steps:"
    log "  1. Restart iTerm2 to apply new settings"
    log "  2. Configure your OpenAI API key in ~/.zshrc:"
    log "     export OPENAI_API_KEY=\"your-api-key-here\""
    log "  3. Run 'p10k configure' to customize your prompt"
    log "  4. Start services when needed:"
    log "     • PostgreSQL: brew services start postgresql@14"
    log "     • Redis: brew services start redis"
    log ""
    log "🚀 You're ready to start developing!"
    log "   Try: 'rails new myapp && cd myapp && rails server'"
}

# Main execution function
main() {
    header "🚀 macOS Rails Development Environment Setup"
    log "This script will set up a complete Rails development environment"
    log "Optimized for Ruby on Rails development with your personal dotfiles"
    log ""

    detect_os
    install_xcode_tools
    install_homebrew
    install_homebrew_packages
    install_rbenv
    install_nvm
    install_oh_my_zsh
    setup_dotfiles
    install_neovim_plugins
    setup_iterm_profile
    # install_development_auth  # Uncomment to install development authentication tools
    # start_services            # Uncomment to start services automatically
    final_setup
}

# Allow individual function calls for testing
# Usage: ./setup.sh [function_name]
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    if [[ -n "$1" ]]; then
        # Run specific function for testing
        "$1" "${@:2}"
    else
        # Run full setup
        main "$@"
    fi
fi
