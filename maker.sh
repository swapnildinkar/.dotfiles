#!/bin/bash

set -e
if [[ "$DEBUG" == "true" ]]; then
	set -x
fi

UNAME=$(uname)

cargo_install () {
	if ! [ -x "$(command -v "$1")" ]; then
		"$HOME"/.cargo/bin/cargo install "$1" \
			--force
	fi
}

if [[ $1 == "install" ]]; then
	ln -sfn "$(pwd)"/vimrc ~/.vimrc
	ln -sfn "$(pwd)"/gitconfig-global ~/.gitconfig
	ln -sfn "$(pwd)"/tmux.conf ~/.tmux.conf

	logger -s "$HOME"
	# load cargo
	curl https://sh.rustup.rs -sSf > /tmp/rustup.sh
	sh /tmp/rustup.sh -y > /dev/null

	if [[ ! -d "$HOME/.vim/bundle/Vundle.vim" ]]; then
		git clone https://github.com/VundleVim/Vundle.vim.git \
			"$HOME"/.vim/bundle/Vundle.vim
	fi

	if [[ "$UNAME" == "Darwin" ]]; then
		brew install bat \
			exa \
			fd \
			shellcheck

		cargo_install du-dust

		logger -s "Done setting up our Mac!"
	elif [[ "$UNAME" == "Linux" ]]; then
		if [ -x "$(command -v lsb_release)" ]; then
			OS=$(lsb_release -si)
			if [[ "$OS" == "Ubuntu" ]]; then
				cargo_install exa
				cargo_install du-dust

				# TODO:
				# - fd
				# - awless
				# - bat
				logger -s "Done setting up our Ubuntu!"
			fi
		fi
	fi

elif [[ $1 == "clean" ]]; then
	logger -s "Cleaning up"

	rm ~/.vimrc
	rm ~/.gitconfig
	rm ~/.tmux.conf
fi

