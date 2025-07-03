DOC?=Thesis
TEXDIR=tex

all: build/$(DOC).pdf

build/$(DOC).pdf: $(TEXDIR)/$(DOC).tex
	latexmk -shell-escape -pdf -outdir=build $(TEXDIR)/$(DOC)

clean:
	latexmk -C -outdir=build $(TEXDIR)/$(DOC)
	rm -rf build/_minted-$(DOC)
