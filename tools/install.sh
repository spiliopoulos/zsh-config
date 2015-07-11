set -e

# Use colors, but only if connected to a terminal, and that terminal
# supports them.
ncolors=$(tput colors)
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
  RED=="$(tput setaf 1)"
  GREEN="$(tput setaf 2)"
  YELLOW="$(tput setaf 3)"
  BLUE="$(tput setaf 4)"
  BOLD="$(tput bold)"
  NORMAL="$(tput sgr0)"
else
  RED=""
  GREEN=""
  YELLOW=""
  BLUE=""
  BOLD=""
  NORMAL=""
fi

if [ ! -n "$ZSH" ]; then
  ZSH=~/.oh-my-zsh
fi

if [ -d "$ZSH" ]; then
  printf "${YELLOW}You already have Oh My Zsh installed.${NORMAL}\n"
  printf "You'll need to remove $ZSH if you want to re-install.\n"
  exit
fi

# Prevent the cloned repository from having insecure permissions. Failing to do
# so causes compinit() calls to fail with "command not found: compdef" errors
# for users with insecure umasks (e.g., "002", allowing group writability). Note
# that this will be ignored under Cygwin by default, as Windows ACLs take
# precedence over umasks except for filesystems mounted with option "noacl".
umask g-w,o-w

echo "\033[0;34mCloning Oh My Zsh...\033[0m"
hash git >/dev/null 2>&1 && env git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git $ZSH || {
  printf "git not installed\n"
  exit
}

printf "${BLUE}Looking for an existing zsh config...${NORMAL}\n"
if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
  printf "${YELLOW}Found ~/.zshrc.${NORMAL} ${GREEN}Backing up to ~/.zshrc.pre-oh-my-zsh${NORMAL}\n";
  mv ~/.zshrc ~/.zshrc.pre-oh-my-zsh;
fi

printf "${BLUE}Using the Oh My Zsh template file and adding it to ~/.zshrc${NORMAL}\n"
cp $ZSH/templates/zshrc.zsh-template ~/.zshrc
sed "/^export ZSH=/ c\\
export ZSH=$ZSH
" ~/.zshrc > ~/.zshrc-omztemp
mv -f ~/.zshrc-omztemp ~/.zshrc

printf "${BLUE}Copying your current PATH and adding it to the end of ~/.zshrc for you.${NORMAL}\n"
sed -i -e "/export PATH=/ c\\
export PATH=\"$PATH\"
" ~/.zshrc > ~/.zshrc-omztemp
mv -f ~/.zshrc-omztemp ~/.zshrc

# If this user's login shell is not already "zsh", attempt to switch.
if [ "$(expr "$SHELL" : '.*/\(.*\)')" != "zsh" ]; then
  # If this platform provides a "chsh" command (not Cygwin), do it, man!
  if hash chsh >/dev/null 2>&1; then
    echo "\033[0;34mTime to change your default shell to zsh!\033[0m"
    chsh -s $(grep /zsh$ /etc/shells | tail -1)
  # Else, suggest the user do so manually.
  else
    echo "\033[0;34mPlease manually change your default shell to zsh!\033[0m"
  fi
fi

printf "${GREEN}"
echo '         __                                     __   '
echo '  ____  / /_     ____ ___  __  __   ____  _____/ /_  '
echo ' / __ \/ __ \   / __ `__ \/ / / /  /_  / / ___/ __ \ '
echo '/ /_/ / / / /  / / / / / / /_/ /    / /_(__  ) / / / '
echo '\____/_/ /_/  /_/ /_/ /_/\__, /    /___/____/_/ /_/  '
echo '                        /____/                       ....is now installed!'
echo ''
echo ''
echo 'Please look over the ~/.zshrc file to select plugins, themes, and options.'
echo ''
echo 'p.s. Follow us at http://twitter.com/ohmyzsh.'
echo ''
echo 'p.p.s. Get stickers and t-shirts at http://shop.planetargon.com.'
echo ''
printf "${NORMAL}"
env zsh
