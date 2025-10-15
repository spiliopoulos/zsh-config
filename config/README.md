# Configuration Modules

This directory contains modular ZSH configuration files. Each file serves a specific purpose and is loaded in order by the main `zshrc`.

## 📁 Module Structure

| File | Purpose | When Loaded |
|------|---------|-------------|
| `init.zsh` | Zinit initialization | 1st - Required for all plugins |
| `options.zsh` | ZSH options and history settings | 2nd - Set behavior early |
| `theme.zsh` | Powerlevel10k theme configuration | 3rd - Requires zinit |
| `plugins.zsh` | All plugin loading via zinit | 4th - Requires zinit |
| `colors.zsh` | LS_COLORS and syntax highlighting | 5th - Can use plugin features |
| `keybindings.zsh` | All keyboard shortcuts | 6th - Independent |
| `aliases.zsh` | Aliases and shell functions | 7th - Independent |
| `environment.zsh` | PATH and environment variables | 8th - Before tools need them |
| `tools.zsh` | Modern CLI tools (zoxide, fzf, etc.) | 9th - Requires environment |
| `local.zsh` | Local customizations (not tracked) | Last - Machine-specific |

## 🎯 Loading Order

The main `zshrc` loads these modules in a specific order:

```
zshrc
  ├─→ init.zsh          (zinit setup)
  ├─→ options.zsh       (zsh behavior)
  ├─→ theme.zsh         (powerlevel10k)
  ├─→ plugins.zsh       (all plugins)
  ├─→ colors.zsh        (LS_COLORS, syntax)
  ├─→ keybindings.zsh   (keyboard shortcuts)
  ├─→ aliases.zsh       (aliases, functions)
  ├─→ environment.zsh   (PATH, EDITOR, etc)
  ├─→ tools.zsh         (zoxide, fzf, bat, etc)
  └─→ local.zsh         (your customizations)
```

## ✏️ Making Changes

### Editing Existing Modules

Simply edit the relevant file:

```bash
# Edit keybindings
vim config/keybindings.zsh

# Reload to test
source ~/.zshrc
```

### Adding Local Customizations

Create `config/local.zsh` for machine-specific settings:

```bash
# config/local.zsh (not tracked by git)

# Machine-specific aliases
alias work='cd ~/work-projects'

# Company-specific settings
export COMPANY_API_KEY='...'

# Local PATH additions
PATH="/opt/custom/bin:$PATH"
```

### Adding a New Module

1. Create your module: `config/mymodule.zsh`
2. Edit `zshrc` to source it in the appropriate order
3. Reload: `source ~/.zshrc`

## 🔍 Debugging

### Check which modules are loaded

```bash
# See what's being sourced
zsh -x -c 'source ~/.zshrc' 2>&1 | grep 'config/'
```

### Check load times

```bash
# Time each module (add this to test)
for file in ~/.zsh/config/*.zsh; do
  time source "$file"
done
```

### Missing module error

If a module fails to load, the error will show in your terminal. The config is designed to fail gracefully - if a module is missing, it won't break the shell.

## 📝 Module Details

### init.zsh
- Initializes zinit plugin manager
- Must be first - everything else depends on it
- Shows warning if zinit not installed

### options.zsh
- ZSH behavior options (pushd, history, etc.)
- History configuration (unlimited)
- Disables problematic defaults

### theme.zsh
- Powerlevel10k theme loading
- Instant prompt setup
- Sources your `~/.p10k.zsh` config

### plugins.zsh
- All zinit plugin declarations
- Completion plugins
- Autosuggestions
- Syntax highlighting
- Git, SSH, Python, etc.

### colors.zsh
- LS_COLORS via vivid (or fallback)
- Completion colors
- Syntax highlighting colors

### keybindings.zsh
- Keyboard shortcuts
- Word navigation (Option+f/b)
- Line navigation (Ctrl+A/E)
- Emacs-style bindings

### aliases.zsh
- User aliases (noh, nogit, etc.)
- Shell functions (vacuum_history)
- Command shortcuts

### environment.zsh
- PATH configuration
- EDITOR, RUBYOPT, etc.
- Environment variables

### tools.zsh
- zoxide initialization
- FZF configuration
- thefuck setup
- bat, ripgrep, fd aliases

### local.zsh (optional)
- Your personal customizations
- Not tracked by git
- Machine-specific settings

## 🎨 Benefits of This Structure

✅ **Organized** - Each file has a single responsibility  
✅ **Maintainable** - Easy to find and edit specific settings  
✅ **Portable** - Easy to enable/disable modules  
✅ **Debuggable** - Can comment out individual modules  
✅ **Shareable** - Clean structure for version control  
✅ **Extensible** - Easy to add new modules  

## 🔗 Related Files

- `../zshrc` - Main file that sources these modules
- `~/.p10k.zsh` - Powerlevel10k theme configuration
- `~/.zsh_history` - History file

