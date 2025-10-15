# Set the path to the oh-my-zsh installation directory
export ZSH=$HOME/.oh-my-zsh

# Use the agnoster theme for a clean, informative prompt with git status
# Agnoster shows current directory, git branch/status, and user context
export ZSH_THEME="agnoster"

# Keep case-insensitive tab completion (default behavior)
# Uncomment the line below to enable case-sensitive completion
# export CASE_SENSITIVE="true"

# Disable automatic updates to prevent interruptions during terminal use
# This ensures oh-my-zsh won't prompt for updates during work sessions
export DISABLE_AUTO_UPDATE="true"

# Keep ls colors enabled for better visual file type distinction
# Uncomment the line below to disable colors in ls output
# export DISABLE_LS_COLORS="true"

# Keep automatic terminal title setting for better window management
# Uncomment the line below to disable automatic terminal title updates
# export DISABLE_AUTO_TITLE="true"

# Load essential plugins for enhanced shell functionality
# Each plugin adds specific commands, completions, or features:
# - gitfast: faster git completions and aliases
# - git-extras: additional git commands (git-summary, git-repl, etc.)
# - jsontools: JSON formatting and manipulation tools (pp_json, is_json, etc.)
# - pip: Python package manager completions
# - web-search: search engines from terminal (google, stackoverflow, etc.)
# - wd: warp directory for quick navigation bookmarks
# - lol: humorous git aliases (git yolo, git such, etc.)
# - zsh-syntax-highlighting: real-time command syntax highlighting
# - catimg: display images in terminal
# - chucknorris: random Chuck Norris facts for entertainment
# - common-aliases: useful shell aliases (la, ll, grep colors, etc.)
# - vim: vim mode and key bindings
# - ssh-agent: automatic SSH key management
plugins=(gitfast git-extras jsontools pip web-search wd lol zsh-syntax-highlighting catimg chucknorris common-aliases vim ssh-agent)

# Enable SSH agent forwarding to allow using local SSH keys on remote servers
# This is useful when connecting through jump hosts or remote development environments
zstyle :omz:plugins:ssh-agent agent-forwarding on

# Automatically load specific SSH identity files for seamless authentication
# These keys provide access to: GitHub (personal), GitHub (Columbia), and Columbia DS cluster
zstyle :omz:plugins:ssh-agent identities spiliopoulos_github_id_rsa columbia_github_id_rsa ds_cluster_columbia_id_rsa

# Load system-wide profile settings before oh-my-zsh initialization
# Ensures compatibility with system-level environment configurations
source /etc/profile

# Initialize oh-my-zsh with all configured themes, plugins, and settings
# This must come after all configuration variables are set
source $ZSH/oh-my-zsh.sh

# Disable glob pattern failures - allows commands with unmatched patterns to run
# Without this, commands like "ls *.nonexistent" would fail instead of passing the pattern literally
unsetopt nomatch

# Disable automatic command correction to prevent unwanted command modifications
# This stops zsh from suggesting corrections for mistyped commands
unsetopt correctall

# Define custom color scheme for file listings and completions
# Color format: attribute=foreground;background where 00=normal, 01=bold, 04=underline
# Colors: 30-37=foreground, 40-47=background (0=black,1=red,2=green,3=yellow,4=blue,5=magenta,6=cyan,7=white)
# File types: no=normal, fi=file, di=directory, ln=symlink, pi=pipe, so=socket, bd=block, cd=char, or=orphan, ex=executable
LS_COLORS='no=00;32:fi=00:di=00;34:ln=01;36:pi=04;33:so=01;35:bd=33;04:cd=33;04:or=31;01:ex=00;32:*.rtf=00;33:*.txt=00;33:*.html=00;33:*.doc=00;33:*.pdf=00;33:*.ps=00;33:*.sit=00;31:*.hqx=00;31:*.bin=00;31:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.deb=00;31:*.dmg=00;36:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.ppm=00;35:*.tga=00;35:*.xbm=00;35:*.xpm=00;35:*.tif=00;35:*.mpg=00;37:*.avi=00;37:*.gl=00;37:*.dl=00;37:*.mov=00;37:*.mp3=00;35:'

# Export LS_COLORS for use by ls command and other utilities
export LS_COLORS;

# Apply the same color scheme to tab completion listings for consistency
# This makes completion menus use the same file type colors as ls
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Configure syntax highlighting colors for the zsh-syntax-highlighting plugin
# This provides real-time coloring of command line elements as you type
ZSH_HIGHLIGHT_STYLES+=(
  default                       'none'            # Default text style - no highlighting
  unknown-token                 'fg=red,bold'     # Invalid/unknown commands - bold red for visibility
  reserved-word                 'fg=yellow'       # Shell keywords (if, for, while) - yellow for distinction
  alias                         'fg=none,bold'    # User-defined aliases - bold to show they're custom
  builtin                       'fg=none,bold'    # Shell built-in commands - bold for emphasis
  function                      'fg=none,bold'    # User-defined functions - bold to differentiate
  command                       'fg=none,bold'    # External commands - bold for clarity
  hashed-command                'fg=none,bold'    # Commands found via hash table - bold for consistency
  path                          'fg=cyan'         # File/directory paths - cyan for easy identification
  globbing                      'fg=cyan'         # Glob patterns (*, ?, []) - cyan like paths
  history-expansion             'fg=blue'         # History expansions (!!, !$) - blue for special syntax
  single-hyphen-option          'fg=magenta'      # Short options (-h, -v) - magenta for parameters
  double-hyphen-option          'fg=magenta'      # Long options (--help, --version) - magenta for parameters
  back-quoted-argument          'fg=magenta,bold' # Command substitution (`cmd`) - bold magenta for execution
  single-quoted-argument        'fg=green'        # Single-quoted strings - green for literals
  double-quoted-argument        'fg=green'        # Double-quoted strings - green for literals
  dollar-double-quoted-argument 'fg=cyan'         # Variable expansion in quotes ($var) - cyan for variables
  back-double-quoted-argument   'fg=cyan'         # Escaped characters in quotes (\n) - cyan for special
  assign                        'none'            # Variable assignments - no special highlighting
)

# Configure key bindings for better terminal navigation
# Home key - jump to beginning of command line
bindkey "\e[H" beginning-of-line

# End key - jump to end of command line
bindkey "\e[F" end-of-line

# Ctrl+Left Arrow - move backward by whole words for faster editing
bindkey "\e[1;5D" backward-word

# Ctrl+Right Arrow - move forward by whole words for faster editing
bindkey "\e[1;5C" forward-word

# Alternative Left Arrow sequence - move backward by words (compatibility)
bindkey "^[OD" backward-word

# Alternative Right Arrow sequence - move forward by words (compatibility)
bindkey "^[OC" forward-word

# Disable shared history between terminal sessions when needed
# Useful when you want separate command histories for different tasks/projects
alias noh="unsetopt sharehistory"

# Disable auto directory naming to fix RVM compatibility issues
# This prevents zsh from automatically creating directory shortcuts that conflict with RVM
unsetopt auto_name_dirs # rvm_rvmrc_cwd fix

# Clear Ruby optimization variable to avoid potential conflicts
# Some Ruby gems or tools may set RUBYOPT which can interfere with normal operation
unset RUBYOPT

# Disable git information in prompt and completions for faster terminal performance
# Useful in large repositories where git operations are slow
alias nogit="disable_git_prompt_info; compdef -d git"

# Short alias for nogit - convenient for quick use
alias nog="nogit"

# Add local node_modules/.bin to PATH and refresh command hash
# Allows running locally installed npm packages without npx
alias npm_bin='PATH=`pwd`/node_modules/.bin:$PATH; rehash'

# Configure PATH to prioritize local binaries and development tools
# Order: personal bin -> local node modules -> Homebrew -> system paths
# This ensures local/custom tools take precedence over system versions
PATH=~/bin:~/node_modules/.bin:/usr/local/bin:/usr/local/sbin:$PATH

# Set vim as the default text editor for command-line operations
# Used by git commits, crontab editing, and other tools that need an editor
export EDITOR=vim

# Add rbenv to PATH for Ruby version management
# This must come before rbenv init to ensure rbenv command is available
export PATH="$HOME/.rbenv/bin:$PATH"

# Initialize rbenv for automatic Ruby version switching
# This sets up shims and enables automatic .ruby-version file detection
eval "$(rbenv init -)"

# Continuous monitoring alias for RQ (Redis Queue) status
# Displays queue information every 5 seconds for job monitoring
alias rqqueues="while true; do; rqinfo -Q; sleep 5; done;"
