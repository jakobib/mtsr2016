PANDOC_OPTIONS=-N -s -S --template=llncs.latex -H header.tex

# requires pandoc, biber, biblatex, xelatex
paper.pdf: paper.tex
	latexmk -xelatex -pdf $<
	latexmk -c

paper.tex: paper.md
	pandoc $(PANDOC_OPTIONS) --biblio=bibliography.bib --biblatex -o $@ $<

clean:
	latexmk -c
