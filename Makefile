SHELL := /bin/bash

PREFIX ?= /usr/local
MAN ?= $(PREFIX)/share/man
LIB ?= $(PREFIX)/lib
BIN ?= $(PREFIX)/bin

all: man

man:
	$(MAKE) -C doc man

install: install-man install-lib install-bin

uninstall: uninstall-man uninstall-lib uninstall-bin

install-man:
	mkdir -p "$(MAN)/man1" "$(MAN)/man5"
	cp doc/*.1 "$(MAN)/man1/"
	cp doc/*.5 "$(MAN)/man5/"
	chmod 444 "$(MAN)"/man?/mutterer{.1,rc.5}
uninstall-man:
	rm -f "$(MAN)"/man?/mutterer{.1,rc.5}

install-lib:
	[[ ! -e "$(LIB)/mutterer" ]] || rm -R "$(LIB)/mutterer"
	mkdir -p "$(LIB)/mutterer"
	cp -R mutterer lib presets "$(LIB)/mutterer/"
	chmod a+rX-w -R "$(LIB)/mutterer"
uninstall-lib:
	rm -Rf "$(LIB)/mutterer"

install-bin:
	./mutterer-sys-wrapper-maker "$(LIB)/mutterer/lib" \
	                             "$(LIB)/mutterer/presets" \
	                             "$(LIB)/mutterer/mutterer" \
	    > $(BIN)/mutterer
	chmod 555 $(BIN)/mutterer
uninstall-bin:
	rm -f "$(BIN)/mutterer"
