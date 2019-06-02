all: install

install:
	sh "$$PWD"/maker.sh install

clean:
	sh "$$PWD"/maker.sh clean

.PHONY: clean install
