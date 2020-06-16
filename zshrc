# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="agnoster"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(ssh-agent git-extras jsontools pip web-search wd lol zsh-syntax-highlighting catimg chucknorris common-aliases zsh-autosuggestions virtualenv)

zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent identities id_rsa

source /etc/profile
source $ZSH/oh-my-zsh.sh

unsetopt nomatch
unsetopt correctall

# Customize to your needs...
LS_COLORS='no=00;32:fi=00:di=00;34:ln=01;36:pi=04;33:so=01;35:bd=33;04:cd=33;04:or=31;01:ex=00;32:*.rtf=00;33:*.txt=00;33:*.html=00;33:*.doc=00;33:*.pdf=00;33:*.ps=00;33:*.sit=00;31:*.hqx=00;31:*.bin=00;31:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.deb=00;31:*.dmg=00;36:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.ppm=00;35:*.tga=00;35:*.xbm=00;35:*.xpm=00;35:*.tif=00;35:*.mpg=00;37:*.avi=00;37:*.gl=00;37:*.dl=00;37:*.mov=00;37:*.mp3=00;35:'
export LS_COLORS;
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
ZSH_HIGHLIGHT_STYLES+=(
  default                       'none'
  unknown-token                 'fg=red,bold'
  reserved-word                 'fg=yellow'
  alias                         'fg=none,bold'
  builtin                       'fg=none,bold'
  function                      'fg=none,bold'
  command                       'fg=none,bold'
  hashed-command                'fg=none,bold'
  path                          'fg=cyan'
  globbing                      'fg=cyan'
  history-expansion             'fg=blue'
  single-hyphen-option          'fg=magenta'
  double-hyphen-option          'fg=magenta'
  back-quoted-argument          'fg=magenta,bold'
  single-quoted-argument        'fg=green'
  double-quoted-argument        'fg=green'
  dollar-double-quoted-argument 'fg=cyan'
  back-double-quoted-argument   'fg=cyan'
  assign                        'none'
)

bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
bindkey "\e[1;5D" backward-word
bindkey "\e[1;5C" forward-word
bindkey "^[OD" backward-word
bindkey "^[OC" forward-word

alias noh="unsetopt sharehistory"

unsetopt auto_name_dirs # rvm_rvmrc_cwd fix
unset RUBYOPT

alias nogit="disable_git_prompt_info; compdef -d git"
alias nog="nogit"
alias npm_bin='PATH=`pwd`/node_modules/.bin:$PATH; rehash'

PATH=~/bin:~/node_modules/.bin:/usr/local/bin:/usr/local/sbin:$PATH
export EDITOR=vim


#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"

#alias rqqueues="while true; do; rqinfo -Q; sleep 5; done;"

# ASANA related stuff
export CODEZ=~/sandbox/asana
export ASANA_GIT_NAME="Yannis Spiliopoulos"
export ASANA_GIT_EMAIL="yannisspiliopoulos@asana.com"
export ASANA_ARCH=x64
export MYSQL=mysql5
export CONFIG=sand
export JAVA_HOME="$(/usr/libexec/java_home)"
export MAC_CONFIGURE_VERSION=2
source $CODEZ/admin/mac.bashrc
alias codez="cd $CODEZ"
alias python3="PYTHONPATH=\"python3:$CODEZ:$CODEZ/3rdparty\" python3"
alias ipython3="PYTHONPATH=\"python3:$CODEZ:$CODEZ/3rdparty\" ipython"
alias pip3="PYTHONPATH=\"python3:$CODEZ:$CODEZ/3rdparty\" pip3"

#export PS1="[$PS_GIT_BRANCH] \w: "
# Use homebrew's python
export PATH=/usr/local/bin:$PATH

# MAC-RELATED
alias mac_restart_audio="sudo kill -9 `ps ax|grep 'coreaudio[a-z]' | awk '{print $1}'`"
alias tmux="TERM=xterm-256color tmux"

#Check for files that start with empty lines
check_for_files_starting_with_empty_lines () {
  gawk 'FNR>1 {nextfile} /^\s*$/ { print FILENAME ; nextfile }' $(find $1 -name '*.py')
}

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=91'

sf() {
  if [ "$#" -lt 1 ]; then echo "Supply string to search for!"; return 1; fi
  printf -v search "%q" "$*"
  include="yml,js,json,php,md,styl,pug,jade,html,config,py,cpp,c,go,hs,rb,conf,fa,lst"
  exclude=".config,.git,node_modules,vendor,build,yarn.lock,*.sty,*.bst,*.coffee,dist,*bazel-*/*"
  rg_command='rg --column --line-number --no-heading --ignore-case --no-ignore --hidden --follow --color "always" -g "*.{'$include'}" -g "[!.]*" -g "!{'$exclude'}/*" '
  files=`eval $rg_command $search 2> /dev/null | fzf --ansi --multi --reverse | awk -F ':' '{printf "%s ", $1":"$2":"$3}'`
  echo $files
  [[ -n "$files" ]] && ${EDITOR:-vim} $=files
}

alias vig="FZF_DEFAULT_COMMAND='(git ls-tree -r --name-only HEAD || find . -path \"*/\.*\" -prune -o -type f -print -o -type l -print | sed s/^..//) 2> /dev/null' vim +FZF"

. ~/.zsh/asanarc

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"
# marker templete select
_fzf_marker_main_widget() {
  if echo "$BUFFER" | ggrep -q -P "{{"; then
    _fzf_marker_placeholder
  else
    local selected
    if selected=$(cat ${FZF_MARKER_CONF_DIR:-~/.config/marker}/*.txt |
      sed -e "s/\(^[a-zA-Z0-9_-]\+\)\s/${FZF_MARKER_COMMAND_COLOR:-\x1b[38;5;255m}\1\x1b[0m /" \
          -e "s/\s*\(#\+\)\(.*\)/${FZF_MARKER_COMMENT_COLOR:-\x1b[38;5;8m}  \1\2\x1b[0m/" |
      fzf --bind 'tab:down,btab:up' --height=80% --ansi -q "$LBUFFER"); then
      LBUFFER=$(echo $selected | sed 's/\s*#.*//')
    fi
    zle redisplay
  fi
}

_fzf_marker_placeholder() {
  local strp pos placeholder
  strp=$(echo $BUFFER | ggrep -Z -P -b -o "\{\{[\w]+\}\}")
  strp=$(echo "$strp" | head -1)
  pos=$(echo $strp | cut -d ":" -f1)
  placeholder=$(echo $strp | cut -d ":" -f2)
  if [[ -n "$1" ]]; then
    BUFFER=$(echo $BUFFER | sed -e "s/{{//" -e "s/}}//")
    CURSOR=$(($pos + ${#placeholder} - 4))
  else
    BUFFER=$(echo $BUFFER | sed "s/$placeholder//")
    CURSOR=pos
  fi
}

_fzf_marker_placeholder_widget() { _fzf_marker_placeholder "defval" }

zle -N _fzf_marker_main_widget
zle -N _fzf_marker_placeholder_widget
bindkey "${FZF_MARKER_MAIN_KEY:-\C-@}" _fzf_marker_main_widget
bindkey "${FZF_MARKER_PLACEHOLDER_KEY:-\C-v}" _fzf_marker_placeholder_widget
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
