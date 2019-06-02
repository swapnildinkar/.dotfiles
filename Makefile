all: install

install:
	bash "$$PWD"/maker.sh install

clean:
	bash "$$PWD"/maker.sh clean

.PHONY: clean install
