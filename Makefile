# Make document

PANDOC = pandoc -s --css=style.css -f markdown --highlight-style=tango --syntax-definition=puppet.xml
TITLE = "Declarative Coding Concepts"
INDEX ?= README.md

SRCDIRS = . declarative declarative/idempotence

SOURCES := $(addsuffix /$(INDEX),$(SRCDIRS))
TARGETS := $(addsuffix /index.html,$(SRCDIRS))

all: html
html: $(TARGETS)

.PHONY: clean
clean:
	rm -f -- $(TARGETS)

index.html : README.md
	$(PANDOC) -t html -o $@ $<
%/index.html : %/README.md
	$(PANDOC) -t html -o $@ $<
%.html : %.md
	$(PANDOC) -t html -o $@ $<

