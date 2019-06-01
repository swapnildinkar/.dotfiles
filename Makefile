all: install

install: vimrc gitconfig-global
	ln -sfn "$$PWD"/vimrc ~/.vimrc
	ln -sfn "$$PWD"/gitconfig-global ~/.gitconfig
	ln -sfn "$$PWD"/tmux.conf ~/.tmux.conf

clean:
	rm ~/.vimrc
	rm ~/.gitconfig
	rm ~/.tmux.conf

.PHONY: clean install
