# Make document

PANDOC = pandoc -s --css=style.css -f markdown --highlight-style=tango --syntax-definition=puppet.xml
TOHTML = $(PANDOC) -t html --lua-filter=links-to-html.lua
TITLE = "Declarative Coding Concepts"
INDEX ?= README.md

SRCDIRS = . declarative declarative/idempotence coding-best-practices

SOURCES := $(shell find . -type f -name \*.md)
TARGETS := $(subst README,index,$(patsubst %.md,%.html,$(SOURCES)))

all: html
html: $(TARGETS)

.PHONY: clean
clean:
	rm -f -- $(TARGETS)

index.html : README.md
	$(TOHTML) -t html -o $@ $<
%/index.html : %/README.md
	$(TOHTML) -t html -o $@ $<
%.html : %.md
	$(TOHTML) -t html -o $@ $<

