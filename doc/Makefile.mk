ASCII2MAN := a2x --doctype manpage --format manpage
MANPAGES := doc/mutterer.1 doc/muttererrc.5

all-doc: man doc/call-graph.png

doc/call-graph.png: doc/call-graph.dot
	dot -Tpng -o$@ $<

man: $(MANPAGES)

doc/mutterer.1: doc/mutterer.1.txt
	$(ASCII2MAN) $<

doc/muttererrc.5: doc/muttererrc.5.txt
	$(ASCII2MAN) $<

clean-doc:
	cd doc && rm -f *.1 *.5 *.png

.PHONY: all-doc clean-doc man
