# Quick Reference Guide

Essential commands and shortcuts for your modern ZSH setup.

## 🗂️ Navigation

```bash
z project              # Jump to directory matching 'project'
zz                     # Interactive directory selection (all)
zz proj                # Interactive selection (filtered)
Alt+C                  # FZF: cd into directory (fuzzy)
```

## 🔍 Search & Find

```bash
Ctrl+R                 # FZF: Search command history
Ctrl+T                 # FZF: Find and paste file path
grep "text"            # ripgrep: Fast search (respects .gitignore)
rg -i "text"           # Case-insensitive search
fd filename            # Fast find (simpler syntax)
fd -e js               # Find all .js files
```

## 📄 File Operations

```bash
cat file.js            # bat: View with syntax highlighting
less file.log          # bat: View with pager
\cat file              # Original cat (if needed)
```

## 🔧 Command Help

```bash
tldr tar               # Quick examples for any command
man tar                # Full manual page
command --help         # Built-in help
```

## 🎯 Command Correction

```bash
fuck                   # Auto-correct last command
                       # (or just press up and edit)
```

## 📚 History

```bash
Ctrl+R                 # Fuzzy search history
history                # Show all history
vacuum_history         # Clean old entries (default: 90 days)
vacuum_history 180     # Clean entries older than 180 days
noh                    # Disable shared history (current session)
```

## 🌿 Git

```bash
gst                    # git status
gco branch             # git checkout branch
gcm "message"          # git commit -m "message"
gp                     # git push
gl                     # git pull
glog                   # Pretty git log
nogit                  # Disable git prompt (large repos)
```

## 🔄 Plugin Management

```bash
zi update --all        # Update all zinit plugins
zi self-update         # Update zinit itself
zi times               # Show plugin load times
```

## 🎨 Customization

```bash
p10k configure         # Configure Powerlevel10k theme
vivid themes           # List available color themes
bat --list-themes      # List bat syntax themes
```

## 💡 Pro Tips

### Original Commands

If you want the original command instead of the alias:
```bash
\cat file              # Original cat
\grep pattern          # Original grep
\find -name "test"     # Original find
```

### FZF Preview

When using `Ctrl+T`:
- See syntax-highlighted previews
- Navigate with arrow keys
- Select multiple files with `Tab`
- Confirm with `Enter`

### Zoxide Learning

Zoxide learns as you navigate:
```bash
cd ~/projects/my-app   # Navigate normally
cd ~/documents/work
# Later...
z app                  # Jumps to my-app
z work                 # Jumps to work
```

### History Search

In `Ctrl+R` fuzzy search:
- Type any part of the command
- Use arrow keys to navigate
- `Enter` to execute
- `Ctrl+C` to cancel

### Thefuck

Works best when you:
1. Try a command and it fails
2. Type `fuck`
3. It suggests the correct command
4. Press `Enter` to accept or `Ctrl+C` to cancel

Common corrections:
- Missing `sudo`
- Typos in command names
- Wrong git commands
- Missing arguments

## ⌨️ Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `Ctrl+R` | Fuzzy history search |
| `Ctrl+T` | Fuzzy file finder |
| `Alt+C` | Fuzzy directory change |
| `Home` | Jump to line start |
| `End` | Jump to line end |
| `Ctrl+←` | Move backward by word |
| `Ctrl+→` | Move forward by word |
| `Ctrl+U` | Clear line before cursor |
| `Ctrl+K` | Clear line after cursor |
| `Ctrl+W` | Delete word before cursor |
| `Ctrl+L` | Clear screen |
| `Ctrl+C` | Cancel current command |
| `Ctrl+D` | Exit shell |

## 🛠️ Troubleshooting

```bash
# Shell feels slow?
zi times               # Check plugin load times

# Command not found after install?
rehash                 # Rebuild command cache

# Weird characters/missing icons?
# Set terminal font to 'MesloLGS NF'

# FZF not showing previews?
which bat              # Ensure bat is installed
which fd               # Ensure fd is installed

# Zoxide not finding directories?
zoxide query -l        # List tracked directories
cd ~/path              # Navigate normally to train it
```

## 📦 Installed Tools Reference

| Tool | Command | Purpose |
|------|---------|---------|
| zoxide | `z`, `zz` | Smart directory jumping |
| fzf | `Ctrl+R/T` | Fuzzy finder |
| bat | `cat`, `less` | Pretty file viewer |
| ripgrep | `grep`, `rg` | Fast text search |
| fd | `find`, `fd` | Fast file finder |
| vivid | (auto) | Modern colors |
| thefuck | `fuck` | Command corrector |
| tldr | `tldr` | Quick command examples |
| jq | `jq` | JSON processor |

## 🔗 Documentation Links

- [Zoxide](https://github.com/ajeetdsouza/zoxide)
- [FZF](https://github.com/junegunn/fzf)
- [bat](https://github.com/sharkdp/bat)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fd](https://github.com/sharkdp/fd)
- [vivid](https://github.com/sharkdp/vivid)
- [thefuck](https://github.com/nvbn/thefuck)
- [tldr](https://github.com/tldr-pages/tldr)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [zinit](https://github.com/zdharma-continuum/zinit)

