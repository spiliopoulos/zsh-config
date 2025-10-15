# Modern ZSH Configuration

A modern, performant ZSH configuration using zinit plugin manager, Powerlevel10k theme, and curated productivity tools.

## 🚀 Quick Start

### 1. Install Dependencies

Run the installation script to install all required tools:

```bash
./install-dependencies.sh
```

This will install:
- **zinit** - Fast, flexible plugin manager
- **zoxide** - Smart directory jumping
- **fzf** - Fuzzy finder for history and files
- **jq** - JSON processor
- **bat** - Better cat with syntax highlighting
- **ripgrep** - Faster grep (rg command)
- **fd** - Faster find
- **vivid** - Modern LS_COLORS generator
- **thefuck** - Command corrector
- **tldr** - Simplified man pages
- **Meslo Nerd Font** - For Powerlevel10k icons

### 2. Install Configuration

Use the Makefile to symlink the configuration:

```bash
make install
```

This creates:
- `~/.zshrc` → symlink to this repo's `zshrc`
- `~/.oh-my-zsh` → symlink to this repo (for compatibility)

### 3. Configure Your Shell

Open a new terminal or reload:

```bash
source ~/.zshrc
```

If it's your first time using Powerlevel10k, you'll be prompted to configure it:

```bash
p10k configure
```

### 4. Set Terminal Font

For best visual experience, set your terminal font to **MesloLGS NF**:

- **iTerm2**: Preferences → Profiles → Text → Font
- **Terminal.app**: Preferences → Profiles → Font
- **VS Code**: Settings → Terminal › Integrated: Font Family

## 🎯 Key Features

### Performance
- ⚡ **Fast startup** - Lazy loading with zinit turbo mode
- 🚀 **Async operations** - Powerlevel10k instant prompt and async git
- 📦 **Minimal overhead** - Only functional plugins, no bloat

### Modern Tools
- 🐟 **Fish-like autosuggestions** - Type and see suggestions from history
- 🔍 **Fuzzy finder** - Press `Ctrl+R` for fuzzy history search
- 🎯 **Smart directory jumping** - Use `z` to jump anywhere
- 🌈 **Syntax highlighting** - Real-time command validation
- 📚 **Enhanced completions** - Better tab completion

### Productivity
- 📂 **Unlimited history** - Never lose a command
- 🧹 **History vacuum** - Clean old entries with `vacuum_history`
- 🔑 **SSH agent** - Automatic key loading
- 🎨 **Beautiful prompt** - Git status, context, and more

## 📚 Usage Guide

### Directory Navigation

**zoxide** learns from your habits and lets you jump quickly:

```bash
# Navigate normally to build up history
cd ~/projects/my-awesome-project
cd ~/documents/work

# Later, jump with just a fragment
z proj        # jumps to ~/projects/my-awesome-project
z work        # jumps to ~/documents/work
z awesome     # also jumps to my-awesome-project

# Interactive selection if multiple matches
zz proj       # shows menu of all matching directories
```

### History Management

```bash
# Search history with fuzzy finder
Ctrl+R        # Opens fzf for interactive search

# Vacuum old history (default: 90 days)
vacuum_history           # Remove entries older than 90 days
vacuum_history 180       # Remove entries older than 180 days
vacuum_history 365       # Remove entries older than 1 year
```

### Git Shortcuts

Provided by the git plugin:

```bash
gst           # git status
gco           # git checkout
gcm           # git commit -m
gp            # git push
gl            # git pull
glog          # git log with nice formatting
```

### Utility Aliases

```bash
noh           # Disable shared history for current session
nogit         # Disable git info in prompt (for large repos)
nog           # Short alias for nogit
npm_bin       # Add local node_modules/.bin to PATH
```

### Modern CLI Tools

**bat** - Better cat with syntax highlighting:
```bash
cat file.js           # Uses bat with syntax highlighting (pager disabled)
less file.js          # Uses bat with pager
\cat file.js          # Original cat command
```

**ripgrep (rg)** - Faster, smarter grep:
```bash
grep "pattern" dir    # Uses ripgrep (respects .gitignore)
rg "pattern"          # Direct ripgrep command
rg -i "pattern"       # Case-insensitive search
rg -t js "pattern"    # Search only JavaScript files
\grep "pattern"       # Original grep command
```

**fd** - Faster, simpler find:
```bash
find name             # Uses fd (simpler syntax, respects .gitignore)
fd "pattern"          # Find files/directories matching pattern
fd -e js              # Find all .js files
fd -t f "pattern"     # Find only files (not directories)
\find -name "test"    # Original find command
```

**thefuck** - Auto-correct mistakes:
```bash
# After making a mistake:
$ apt-get install package
E: Could not open lock file /var/lib/dpkg/lock - open (13: Permission denied)

$ fuck
sudo apt-get install package [enter/↑/↓/ctrl+c]
```

**tldr** - Simplified man pages:
```bash
tldr tar              # Quick examples for tar command
tldr git-commit       # Quick examples for git commit
man tar               # Full manual (still available)
```

### FZF Keybindings

```bash
Ctrl+R                # Search command history (fuzzy)
Ctrl+T                # Find files and paste path (with preview)
Alt+C                 # Fuzzy cd into directory
```

**FZF with previews:**
- File preview uses `bat` for syntax highlighting
- Directory preview shows contents
- Respects `.gitignore` when using `fd`

## 🎨 Customization

### Update Plugins

Edit the plugins section in `zshrc` and reload:

```bash
source ~/.zshrc
```

### Reconfigure Theme

Run the Powerlevel10k configuration wizard:

```bash
p10k configure
```

### Change Vivid Color Theme

Edit line 109 in `zshrc` to use a different vivid theme:

```bash
export LS_COLORS="$(vivid generate snazzy)"
```

Available themes:
- `snazzy` (default) - Dark, vibrant
- `molokai` - Dark, classic
- `nord` - Cool blues
- `dracula` - Popular dark theme
- `solarized-dark` / `solarized-light`
- `ayu` - Warm colors
- `one-dark` / `one-light`

View all themes: `vivid themes`

### Adjust BAT Theme

Edit line 320 in `zshrc`:

```bash
export BAT_THEME="Dracula"
```

View available themes: `bat --list-themes`

### Add Custom Aliases

Add your own aliases at the bottom of the `ALIASES` section in `zshrc`.

### Adjust History

Edit the `HISTSIZE` and `SAVEHIST` variables in `zshrc`.

## 🔄 Updates

### Update zinit and plugins

```bash
zinit self-update    # Update zinit itself
zinit update --all   # Update all plugins
```

### Update Homebrew packages

```bash
brew update && brew upgrade
```

### Update this configuration

```bash
cd ~/.zsh  # or wherever you cloned this repo
git pull
```

## 🛠️ Troubleshooting

### Slow startup

1. Check which plugins are taking time:
   ```bash
   zinit times
   ```

2. Ensure you're using turbo mode (plugins with `wait lucid`)

### Missing icons or weird characters

Install and configure the Nerd Font (MesloLGS NF) in your terminal.

### Zoxide not jumping correctly

Zoxide learns over time. Use `cd` normally for a while, then it will work better.
You can also manually add directories:

```bash
zoxide add /path/to/directory
```

### History not working

Ensure `HISTFILE` points to the right location:

```bash
echo $HISTFILE    # Should show ~/.zsh_history
```

## 📦 What's Different from Oh-My-Zsh?

| Feature | Old (OMZ) | New (Modern) |
|---------|-----------|--------------|
| Plugin Manager | Oh-My-Zsh | zinit |
| Theme | agnoster | Powerlevel10k |
| Directory Jump | wd (manual) | zoxide (smart) |
| Startup Time | ~1-2s | ~0.1-0.3s |
| History | 50k lines | Unlimited |
| Autosuggestions | ❌ | ✅ |
| Fuzzy History | ❌ | ✅ (fzf) |

## 📄 Files

- `zshrc` - Main configuration file
- `install-dependencies.sh` - Dependency installer
- `Makefile` - Installation automation
- `README-MODERN.md` - This file

## 🤝 Contributing

This is a personal configuration, but feel free to fork and customize for your needs!

## 📝 License

MIT License - See `MIT-LICENSE.txt`

