ASCII2MAN=a2x --doctype manpage --format manpage

all: man call-graph.png

call-graph.png: call-graph.dot
	dot -Tpng -o$@ $<

man: mutterer.1 muttererrc.5

mutterer.1: mutterer.1.txt
	$(ASCII2MAN) $<

muttererrc.5: muttererrc.5.txt
	$(ASCII2MAN) $<

clean:
	rm -f *.1 *.5 *.png

.PHONY: all clean man
