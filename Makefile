# Make document

PANDOC = pandoc -s --css=style.css -f markdown --highlight-style=tango --syntax-definition=puppet.xml
TOHTML = $(PANDOC) -t html --lua-filter=links-to-html.lua

SOURCES := $(shell find . -type f -name \*.md)
TARGETS := $(subst README,index,$(patsubst %.md,site/%.html,$(SOURCES)))

all: html
site:
	mkdir -p $(dir $(TARGETS))
html: site $(TARGETS)

.PHONY: clean
clean:
	rm -rf -- site

site/index.html : README.md
	$(TOHTML) -t html -o $@ $<
site/%/index.html : %/README.md
	$(TOHTML) -t html -o $@ $<
site/%.html : %.md
	$(TOHTML) -t html -o $@ $<

