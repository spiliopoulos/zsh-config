# ============================================
# KEY BINDINGS - Better Terminal Navigation
# ============================================

# Home key - jump to beginning of line
bindkey "\e[H" beginning-of-line
bindkey "^[[H" beginning-of-line

# End key - jump to end of line
bindkey "\e[F" end-of-line
bindkey "^[[F" end-of-line

# Standard Emacs-style word navigation (works everywhere)
# Option+f - move forward by word (requires iTerm2: Left Option = Esc+)
bindkey "^[f" forward-word
bindkey "\ef" forward-word

# Option+b - move backward by word (requires iTerm2: Left Option = Esc+)
bindkey "^[b" backward-word
bindkey "\eb" backward-word

# Ctrl+Left/Right Arrow (for terminals that support it)
bindkey "\e[1;5D" backward-word
bindkey "\e[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

# Option+Left/Right Arrow in iTerm2 (if configured as Esc+)
bindkey "\e\e[D" backward-word
bindkey "\e\e[C" forward-word

# Additional useful bindings
bindkey "^A" beginning-of-line  # Ctrl+A
bindkey "^E" end-of-line        # Ctrl+E
bindkey "^K" kill-line          # Ctrl+K - delete to end of line
bindkey "^U" backward-kill-line # Ctrl+U - delete to start of line
bindkey "^W" backward-kill-word # Ctrl+W - delete word backward
bindkey "^Y" yank               # Ctrl+Y - paste (yank)

