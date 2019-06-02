all: install

install:
	maker.sh install

clean:
	maker.sh clean

.PHONY: clean install
