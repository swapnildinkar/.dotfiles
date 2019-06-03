#!/bin/bash

set -e
if [[ "$DEBUG" == "true" ]]; then
	set -x
fi

UNAME=$(uname)

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
		logger -s "Done setting up our Mac!"
	elif [[ "$UNAME" == "Linux" ]]; then
		if [ -x "$(command -v lsb_release)" ]; then
			OS=$(lsb_release -si)
			if [[ "$OS" == "Ubuntu" ]]; then
				if ! [ -x "$(command -v exa)" ]; then
					"$(HOME)"/.cargo/bin/cargo install exa \
						--force
				fi

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

