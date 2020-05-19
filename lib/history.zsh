## History wrapper
function omz_history {
  # Delete the history file if `-c' argument provided.
  # This won't affect the `history' command output until the next login.
  if [[ "${@[(i)-c]}" -le $# ]]; then
    echo -n >| "$HISTFILE"
    echo >&2 History file deleted. Reload the session to see its effects.
  else
    fc $@ -l 1
  fi
}

# Timestamp format
case $HIST_STAMPS in
  "mm/dd/yyyy") alias history='omz_history -f' ;;
  "dd.mm.yyyy") alias history='omz_history -E' ;;
  "yyyy-mm-dd") alias history='omz_history -i' ;;
  *) alias history='omz_history' ;;
esac

## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

## History command configuration
setopt append_history         # append history to HISTFILE on session exit
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data
