DOC?=Thesis
BASE=$(wildcard BASE/*.bst BASE/*.cls)
PICs=$(wildcard PICs/*.pdf PICs/*.png)

$(DOC).pdf : $(DOC).tex $(BIB) $(BASE) $(PICS)
	pdflatex -shell-escape $(DOC)
	biber $(DOC)
	pdflatex -shell-escape  $(DOC)
	pdflatex -shell-escape  $(DOC)
	
clean : 
	rm -f *.aux *.log *.bbl *.lol *.blg *.run.xml *.lof *.bcf *.toc *.lot
	rm -rf _minted*
