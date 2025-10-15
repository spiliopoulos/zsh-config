# ============================================
# PLUGINS - Modern, Fast, Functional
# ============================================

# Load essential completion support
zinit ice wait lucid blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

# Fish-like autosuggestions (type and see suggestions from history)
zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# Syntax highlighting - must be loaded after compinit and other widgets
# Using the standalone version (faster than OMZ version)
zinit ice wait lucid atinit'zpcompinit; zpcdreplay'
zinit light zsh-users/zsh-syntax-highlighting

# Git library - single file snippet works fine
zinit ice wait lucid
zinit snippet OMZL::git.zsh

# Git plugin - load full directory from OMZ repo
zinit ice wait lucid pick"plugins/git/git.plugin.zsh"
zinit light ohmyzsh/ohmyzsh

# Git extras - additional git commands
zinit ice wait lucid pick"plugins/git-extras/git-extras.plugin.zsh"
zinit light ohmyzsh/ohmyzsh

# JSON tools - for JSON formatting
zinit ice wait lucid pick"plugins/jsontools/jsontools.plugin.zsh"
zinit light ohmyzsh/ohmyzsh

# Python pip completion
zinit ice wait lucid pick"plugins/pip/pip.plugin.zsh"
zinit light ohmyzsh/ohmyzsh

# Wd directory management
zinit ice wait lucid pick"plugins/wd/wd.plugin.zsh"
zinit light ohmyzsh/ohmyzsh

# Web search from terminal
zinit ice wait lucid pick"plugins/web-search/web-search.plugin.zsh"
zinit light ohmyzsh/ohmyzsh

# SSH agent management
zinit ice wait lucid pick"plugins/ssh-agent/ssh-agent.plugin.zsh"
zinit light ohmyzsh/ohmyzsh

# Configure SSH agent to forward connections and load your keys
zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent identities spiliopoulos_github_id_rsa columbia_github_id_rsa ds_cluster_columbia_id_rsa

