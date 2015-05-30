SHELL := /bin/bash

VERSION ?= 0.1

prefix      ?= /usr/local
exec_prefix ?= $(prefix)
mandir      ?= $(prefix)/share/man
sharedir    ?= $(prefix)/share
libdir      ?= $(exec_prefix)/lib
bindir      ?= $(exec_prefix)/bin

_mandir   := $(DESTDIR)$(mandir)
_libdir   := $(DESTDIR)$(libdir)
_bindir   := $(DESTDIR)$(bindir)
_sharedir := $(DESTDIR)$(sharedir)

all: man

include doc/Makefile.mk

MAKE_TAR := tar --transform 's,^,mutterer-$(VERSION)/,' -c
FILES := $(shell git ls-files) $(MANPAGES)

archive: mutterer-$(VERSION).tar.gz

mutterer-$(VERSION).tar.gz: $(FILES)
	$(MAKE_TAR) -zf $@ $^

install: install-man install-lib install-presets install-bin

uninstall: uninstall-man uninstall-lib uninstall-presets uninstall-bin

install-man:
	mkdir -p "$(_mandir)/man1" "$(_mandir)/man5"
	cp doc/*.1 "$(_mandir)/man1/"
	cp doc/*.5 "$(_mandir)/man5/"
	chmod 444 "$(_mandir)"/man?/mutterer{.1,rc.5}
uninstall-man:
	rm -f "$(_mandir)"/man?/mutterer{.1,rc.5}

install-lib:
	[[ ! -e "$(_libdir)/mutterer" ]] || rm -R "$(_libdir)/mutterer"
	mkdir -p "$(_libdir)/mutterer"
	cp -R mutterer lib/* "$(_libdir)/mutterer/"
	chmod a+rX-w -R "$(_libdir)/mutterer"
uninstall-lib:
	rm -Rf "$(_libdir)/mutterer"

install-presets:
	[[ ! -e "$(_sharedir)/mutterer" ]] || rm -R "$(_sharedir)/mutterer"
	mkdir -p "$(_sharedir)/mutterer"
	cp -R presets "$(_sharedir)/mutterer/"
	chmod a+rX-w -R "$(_sharedir)/mutterer"
uninstall-presets:
	rm -Rf "$(_sharedir)/mutterer"

install-bin:
	mkdir -p "$(_bindir)"
	./mutterer-sys-wrapper-maker "$(libdir)/mutterer" \
	                             "$(sharedir)/mutterer/presets" \
	                             "$(libdir)/mutterer/mutterer" \
	    > "$(_bindir)/mutterer"
	chmod 555 "$(_bindir)/mutterer"
uninstall-bin:
	rm -f "$(_bindir)/mutterer"

clean: clean-doc
	rm -f *.tar.gz *.tar.bz2 *.tar.xz

.PHONY: uninstall-bin install-bin uninstall-lib install-lib \
        install-presets uninstall-presets uninstall-man install-man \
        uninstall install man all clean archive
