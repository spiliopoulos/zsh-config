#!/bin/sh
#
# This script should be run via curl:
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# or wget:
#   sh -c "$(wget -qO- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#
# As an alternative, you can first download the install script and run it afterwards:
#   wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
#   sh install.sh
#
# Respects these environment variables for tweaking the installation process:
#   REPO    - name of the GitHub repo to install from (default: robbyrussell/oh-my-zsh)
#   REMOTE  - full remote URL of the git repo to install (default: GitHub via HTTPS)
#   BRANCH  - branch to check out immediately after install (default: master)
#
set -e

# Default settings
ZSH=${ZSH:-~/.oh-my-zsh}
REPO=${REPO:-robbyrussell/oh-my-zsh}
REMOTE=${REMOTE:-https://github.com/${REPO}.git}
BRANCH=${BRANCH:-master}

command_exists() {
	command -v "$@" >/dev/null 2>&1
}

error() {
	echo ${RED}"Error: $@"${RESET} >&2
}

# Set up color sequences
setup_color() {
	if command_exists tput; then
		ncolors=$(tput colors)
	else
		ncolors=0
	fi

	# Only use colors if connected to a terminal that supports them
	if [ -t 1 ] && [ $ncolors -ge 8 ]; then
		RED="$(tput setaf 1)"
		GREEN="$(tput setaf 2)"
		YELLOW="$(tput setaf 3)"
		BLUE="$(tput setaf 4)"
		BOLD="$(tput bold)"
		RESET="$(tput sgr0)"
	else
		RED=$(printf '\033[31m')
		GREEN=$(printf '\033[32m')
		YELLOW=$(printf '\033[33m')
		BLUE=$(printf '\033[34m')
		BOLD=$(printf '\033[1m')
		RESET=$(printf '\033[m')
	fi
}

setup_ohmyzsh() {
	# Prevent the cloned repository from having insecure permissions. Failing to do
	# so causes compinit() calls to fail with "command not found: compdef" errors
	# for users with insecure umasks (e.g., "002", allowing group writability). Note
	# that this will be ignored under Cygwin by default, as Windows ACLs take
	# precedence over umasks except for filesystems mounted with option "noacl".
	umask g-w,o-w

	echo "${BLUE}Cloning Oh My Zsh...${RESET}"

	command_exists git || {
		error "git is not installed"
		exit 1
	}

	if [ "$OSTYPE" = cygwin ] && git --version | grep -q msysgit; then
		error "Windows/MSYS Git is not supported on Cygwin"
		error "Make sure the Cygwin git package is installed and is first on the \$PATH"
		exit 1
	fi

	git clone --depth=1 --branch "$BRANCH" "$REMOTE" "$ZSH" || {
		error "git clone of oh-my-zsh repo failed"
		exit 1
	}
}

setup_zshrc() {
	echo "${BLUE}Looking for an existing zsh config...${RESET}"
	if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
		echo "${YELLOW}Found ~/.zshrc.${GREEN} Backing up to ~/.zshrc.pre-oh-my-zsh.${RESET}"
		mv ~/.zshrc ~/.zshrc.pre-oh-my-zsh
	fi

	echo "${BLUE}Using the Oh My Zsh template file and adding it to ~/.zshrc.${RESET}"

	cp "$ZSH/templates/zshrc.zsh-template" ~/.zshrc
	sed "/^export ZSH=/ c\\
export ZSH=\"$ZSH\"
" ~/.zshrc > ~/.zshrc-omztemp
	mv -f ~/.zshrc-omztemp ~/.zshrc
}

setup_shell() {
	# If this user's login shell is already "zsh", do not attempt to switch.
	if [ "$(basename "$SHELL")" = "zsh" ]; then
		return
	fi

	# If this platform doesn't provide a "chsh" command, bail out.
	if ! command_exists chsh; then
		cat <<-EOF
			I can't change your shell automatically because this system does not have chsh.
			${BLUE}Please manually change your default shell to zsh${RESET}
		EOF
		return
	fi

	echo "${BLUE}Time to change your default shell to zsh!${RESET}"

	# Test for the right location of the "shells" file
	if [ -f /etc/shells ]; then
		shells_file=/etc/shells
	elif [ -f /usr/share/defaults/etc/shells ]; then # Solus OS
		shells_file=/usr/share/defaults/etc/shells
	else
		error "could not find /etc/shells file. Change your default shell manually."
		return
	fi

	# Get the path to the right zsh binary
	# 1. Use the most preceding one based on $PATH, then check that it's in the shells file
	# 2. If that fails, get a zsh path from the shells file, then check it actually exists
	if ! zsh=$(which zsh) || ! grep -qx "$zsh" "$shells_file"; then
		if ! zsh=$(grep '^/.*/zsh$' "$shells_file" | tail -1) || [ ! -f "$zsh" ]; then
			error "no available zsh binary found. Change your default shell manually."
			return
		fi
	fi

	# Actually change the default shell to zsh
	if ! chsh -s "$zsh"; then
		error "chsh command unsuccessful. Change your default shell manually."
	fi
}

main() {
	setup_color

	if ! command_exists zsh; then
		echo "${YELLOW}Zsh is not installed.${RESET} Please install zsh first."
		exit 1
	fi

	if [ -d "$ZSH" ]; then
		cat <<-EOF
			${YELLOW}You already have Oh My Zsh installed.${RESET}
			You'll need to remove '$ZSH' if you want to reinstall.
		EOF
		exit 1
	fi

	setup_ohmyzsh
	setup_zshrc
	setup_shell

	printf "$GREEN"
	cat <<-'EOF'
		         __                                     __
		  ____  / /_     ____ ___  __  __   ____  _____/ /_
		 / __ \/ __ \   / __ `__ \/ / / /  /_  / / ___/ __ \
		/ /_/ / / / /  / / / / / / /_/ /    / /_(__  ) / / /
		\____/_/ /_/  /_/ /_/ /_/\__, /    /___/____/_/ /_/
		                        /____/                       ....is now installed!


		Please look over the ~/.zshrc file to select plugins, themes, and options.

		p.s. Follow us on https://twitter.com/ohmyzsh

		p.p.s. Get stickers, shirts, and coffee mugs at https://shop.planetargon.com/collections/oh-my-zsh

	EOF
	printf "$RESET"

	exec zsh -l
}

main
