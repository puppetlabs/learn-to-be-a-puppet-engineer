# Make document

PANDOC = pandoc -s --css=../style.css -f markdown --highlight-style=tango --syntax-definition=../puppet.xml
TITLE = "Declarative Coding Concepts"
SOURCE ?= README.md

html: index.html
index.html: $(SOURCE)
	$(PANDOC) -t html -o index.html $(SOURCE)

epub: declarative.epub
declarative.epub: $(SOURCE)
	$(PANDOC) -t epub --metadata title=$(TITLE) -o declarative.epub $(SOURCE)

pdf: declarative.pdf
declarative.pdf: $(SOURCE)
	$(PANDOC) --pdf-engine=tectonic -t pdf --metadata title=$(TITLE) -o declarative.pdf $(SOURCE)

all: html epub pdf

.PHONY:
clean:
	rm -f -- index.html declarative.epub declarative.pdf
