# ============================================
# CUSTOM COLORS - LS_COLORS & SYNTAX HIGHLIGHTING
# ============================================

# Use vivid for modern LS_COLORS if available, otherwise fallback to custom colors
if command -v vivid &> /dev/null; then
  # Use vivid with a modern theme (try different themes: molokai, snazzy, nord, etc.)
  export LS_COLORS="$(vivid generate snazzy)"
else
  # Fallback to custom LS_COLORS if vivid not installed
  LS_COLORS='no=00;32:fi=00:di=00;34:ln=01;36:pi=04;33:so=01;35:bd=33;04:cd=33;04:or=31;01:ex=00;32:'
  LS_COLORS+='*.rtf=00;33:*.txt=00;33:*.html=00;33:*.doc=00;33:*.pdf=00;33:*.ps=00;33:'
  LS_COLORS+='*.sit=00;31:*.hqx=00;31:*.bin=00;31:*.tar=00;31:*.tgz=00;31:*.arj=00;31:'
  LS_COLORS+='*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:'
  LS_COLORS+='*.deb=00;31:*.dmg=00;36:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.ppm=00;35:'
  LS_COLORS+='*.tga=00;35:*.xbm=00;35:*.xpm=00;35:*.tif=00;35:*.mpg=00;37:*.avi=00;37:'
  LS_COLORS+='*.gl=00;37:*.dl=00;37:*.mov=00;37:*.mp3=00;35:'
  LS_COLORS+='*.rs=00;33:*.go=00;33:*.ts=00;33:*.tsx=00;33:*.jsx=00;33:*.vue=00;33:'
  LS_COLORS+='*.yml=00;33:*.yaml=00;33:*.toml=00;33:*.json=00;33:*.md=00;33:*.py=00;33:'
  export LS_COLORS
fi

# Apply same colors to tab completion
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Syntax highlighting styles for command line
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

