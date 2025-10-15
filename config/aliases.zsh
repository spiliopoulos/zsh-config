# ============================================
# ALIASES - Productivity Shortcuts
# ============================================

# Disable shared history between sessions when needed
alias noh="unsetopt sharehistory"

# Disable git prompt and completions for performance in large repos
alias nogit="disable_git_prompt_info; compdef -d git"
alias nog="nogit"

# ============================================
# FUNCTIONS
# ============================================

# Vacuum old history - removes entries older than X days
# Usage: vacuum_history 90  (removes entries older than 90 days)
# Usage: vacuum_history 180 (removes entries older than 180 days)
vacuum_history() {
  local days="${1:-90}"  # Default to 90 days if not specified
  local cutoff_timestamp=$(date -v-${days}d +%s 2>/dev/null || date -d "${days} days ago" +%s 2>/dev/null)
  
  if [[ -z "$cutoff_timestamp" ]]; then
    echo "Error: Unable to calculate cutoff date"
    return 1
  fi
  
  local backup_file="${HISTFILE}.backup.$(date +%Y%m%d_%H%M%S)"
  local temp_file="${HISTFILE}.tmp"
  
  echo "📦 Backing up history to: $backup_file"
  cp "$HISTFILE" "$backup_file"
  
  echo "🧹 Removing history entries older than $days days (before $(date -r $cutoff_timestamp '+%Y-%m-%d %H:%M:%S'))..."
  
  # Process the history file
  local removed=0
  local kept=0
  
  while IFS= read -r line; do
    # Check if line starts with timestamp format ': <timestamp>:'
    if [[ "$line" =~ ^:[[:space:]]*([0-9]+):[0-9]+\; ]]; then
      local entry_timestamp="${match[1]}"
      if (( entry_timestamp >= cutoff_timestamp )); then
        echo "$line" >> "$temp_file"
        ((kept++))
      else
        ((removed++))
      fi
    else
      # Keep lines that don't have timestamps (shouldn't happen with EXTENDED_HISTORY)
      echo "$line" >> "$temp_file"
      ((kept++))
    fi
  done < "$HISTFILE"
  
  mv "$temp_file" "$HISTFILE"
  
  echo "✅ Done! Removed $removed entries, kept $kept entries"
  echo "💾 Backup saved to: $backup_file"
  echo "🔄 Reload your shell or run 'fc -R' to reload history"
}

