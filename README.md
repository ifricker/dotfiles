# Ian's Dotfiles

A complete macOS development environment setup optimized for Ruby on Rails development.

## 🚀 Quick Start

```bash
git clone https://github.com/ifricker/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./setup.sh
```

That's it! The script will handle everything automatically.

## 📋 What Gets Installed

### Development Tools
- **Homebrew** - Package manager for macOS
- **Git** - Version control
- **Neovim** - Modern text editor with custom configuration
- **Tmux** - Terminal multiplexer

### Ruby/Rails Stack
- **rbenv** - Ruby version manager (preferred over RVM for Rails)
- **Latest Ruby** - Automatically installs the latest stable version
- **Rails** - Web application framework
- **Bundler** - Gem dependency manager
- **RuboCop** - Ruby linter (integrated with Neovim)
- **Solargraph** - Ruby language server
- **Pry & Pry-Rails** - Enhanced Rails console

### Node.js/Frontend
- **nvm** - Node version manager
- **Node.js LTS** - Latest long-term support version
- **Yarn** - Package manager (Rails 7+ default)
- **Prettier** - Code formatter (integrated with Neovim)
- **ESLint** - JavaScript linter

### Shell & Terminal
- **Zsh** - Modern shell
- **Oh My Zsh** - Zsh framework
- **Powerlevel10k** - Beautiful and fast prompt theme
- **iTerm2** - Enhanced terminal with custom profile
- **Useful aliases** - Rails and development shortcuts

### Database & Services
- **PostgreSQL 14** - Primary database for Rails
- **Redis** - Caching and background jobs
- **ImageMagick** - Image processing

### GUI Applications
- **Google Chrome** - Primary browser
- **Visual Studio Code** - Backup editor
- **Docker** - Containerization
- **Postman** - API testing
- **TablePlus** - Database GUI

### CLI Utilities
- **ripgrep (rg)** - Fast code search
- **fd** - Better find command
- **bat** - Better cat with syntax highlighting
- **exa** - Better ls command
- **fzf** - Fuzzy finder
- **htop** - Better top command
- **jq** - JSON processor
- **tree** - Directory tree viewer

## 🔧 Manual Steps After Installation

1. **Restart iTerm2** to apply custom profile settings
2. **Configure environment variables**:
   ```bash
   # Edit ~/.env and add your actual information:
   nvim ~/.env
   
   # Example:
   GIT_USER_NAME="Your Full Name"
   GIT_USER_EMAIL="your-email@example.com"
   OPENAI_API_KEY="your-actual-api-key-here"
   ```
3. **Customize your prompt**:
   ```bash
   p10k configure
   ```
4. **Start services when needed**:
   ```bash
   brew services start postgresql@14
   brew services start redis
   ```

## 📁 File Structure

```
~/.dotfiles/
├── setup.sh              # Main installation script
├── .zshrc                 # Shell configuration
├── .env.example           # Environment variables template
├── .gitignore             # Git ignore rules
├── .config/
│   └── nvim/
│       └── init.vim       # Neovim configuration
├── iterm2-profile.plist   # iTerm2 settings backup
└── README.md             # This file

# Created during setup:
~/.env                     # Your actual environment variables (not in git)
```

## 🛠 Advanced Usage

### Test Individual Functions
You can run specific parts of the setup script:

```bash
# Install only Ruby/Rails stack
./setup.sh install_rbenv

# Install only Neovim plugins
./setup.sh install_neovim_plugins

# Setup only iTerm2 profile
./setup.sh setup_iterm_profile
```

### Update Dotfiles
```bash
cd ~/.dotfiles
git pull
# Re-run setup if needed
./setup.sh
```

### Backup Your Settings
If you make changes to your configurations, commit them:

```bash
cd ~/.dotfiles
git add .
git commit -m "Update configuration"
git push
```

## 🔒 Security Features

### Environment Variables
- **No secrets in git** - API keys stored in `~/.env` (gitignored)
- **Example template** - `.env.example` shows required variables
- **Automatic setup** - Script copies example to `~/.env` for you to edit

### Safe Configuration
- **Backup before changes** - Existing configs backed up automatically
- **Symlinks not copies** - Easy to revert changes
- **Gitignore protection** - Prevents accidental secret commits

## 🔍 Key Features

### Neovim Configuration
- **Rails-optimized plugins**: vim-rails, vim-test, vim-rubocop
- **Modern enhancements**: Telescope (fuzzy finder), Treesitter (syntax highlighting), LSP support
- **GitHub Copilot** integration
- **Smart paste handling** - no more indentation issues!
- **Consistent code formatting** with Prettier integration

### Shell Configuration  
- **Rails-focused aliases**: Quick commands for common Rails tasks
- **Development shortcuts**: Docker, Git, and testing aliases
- **Smart prompt**: Shows git status, Ruby version, and more
- **Auto-suggestions** and helpful tips

### iTerm2 Profile
- **Bracketed paste mode** - fixes vim paste indentation automatically
- **Optimized for development** - proper colors, fonts, and shortcuts
- **Consistent experience** - same settings across all machines

## 🐛 Troubleshooting

### Script Fails During Installation
```bash
# Check what failed and re-run
./setup.sh

# If Xcode tools needed, install first:
xcode-select --install
# Then re-run setup.sh
```

### Neovim Plugins Not Working
```bash
# Manually install plugins
nvim
:PlugInstall
```

### Ruby/Rails Issues
```bash
# Reinitialize rbenv
rbenv init
source ~/.zshrc

# Install Rails again if needed
gem install rails
```

### iTerm2 Settings Not Applied
```bash
# Restart iTerm2 completely
# Check that iterm2-profile.plist exists in ~/.dotfiles
```

## 🔄 System Requirements

- **macOS** (tested on Big Sur and newer)
- **Internet connection** for downloading packages
- **Administrator access** for some installations

## 📝 Customization

### Adding New Packages
Edit `setup.sh` and add to the `install_homebrew_packages()` function:

```bash
brew install your-new-package
```

### Modifying Neovim Config
Edit `.config/nvim/init.vim` and commit changes:

```bash
nvim ~/.dotfiles/.config/nvim/init.vim
# Make your changes
cd ~/.dotfiles
git add .config/nvim/init.vim
git commit -m "Update Neovim configuration"
```

### Shell Customization
Edit `.zshrc` for new aliases or environment variables:

```bash
nvim ~/.dotfiles/.zshrc
# Make your changes
cd ~/.dotfiles
git add .zshrc
git commit -m "Update shell configuration"
```

## 🎯 Rails Development Quick Start

After setup, create a new Rails app:

```bash
# Create new Rails app with PostgreSQL and React
rails new myapp --database=postgresql --javascript=react
cd myapp

# Start services
brew services start postgresql@14
brew services start redis

# Setup database
rails db:create db:migrate

# Start server
rails server
```

## 📚 Useful Commands

```bash
# Rails shortcuts (from .zshrc)
bym          # bundle && yarn && rails db:migrate && rails db:create RAILS_ENV=test && spring stop
rspec        # bundle exec rspec
skiq         # bundle exec sidekiq

# Git shortcuts
gl           # git log --pretty=oneline -10

# Docker shortcuts
dc           # docker compose
dcps         # docker compose ps
```

## 📄 License

MIT License - feel free to use this configuration for your own development setup.
