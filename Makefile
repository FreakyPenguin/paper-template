PAPER_NAME := paper

TEX := $(shell find ./ -type f -name "*.tex")
CLS := $(shell find ./ -type f -name "*.cls")
BIB := $(shell find ./ -type f -name "*.bib")
FIG := $(shell find ./figures -type f -name "*.pdf")
GNUPLOTS := $(addsuffix .pdf,$(basename $(shell find ./figures -type f -name "*.gnuplot" | grep -v common)))
PAPER_DEPS := $(TEX) $(CLS) $(BIB) $(FIG) $(GNUPLOTS)
LATEX := python3 ./bin/latexrun --color auto --bibtex-args="-min-crossrefs=9000"

all: $(PAPER_NAME).pdf

%.eps: %.dia
	dia -e $@ -t eps $<

%.pdf: %.eps
	epspdf $< $@.tmp.pdf
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.5 \
	  -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH \
	  -sOutputFile=$@ $@.tmp.pdf
	rm -f $@.tmp.pdf

%.pdf: %.gnuplot %.dat figures/common.gnuplot
	(cd $(dir $@) ; gnuplot $(notdir $<)) | pdfcrop - $@

%.gnuplot.tex: %.gnuplot %.dat figures/common.gnuplot
	(cd $(dir $@) ; gnuplot -e "tikzout='tikz'" $(notdir $<)) >$@



$(PAPER_NAME).pdf: $(PAPER_DEPS)
	$(LATEX) $(PAPER_NAME).tex -O .latex.out -o $@

clean:
	$(LATEX) --clean-all -O .latex.out
	@rm -frv .latex.out $(PDFS) $(GNUPLOTS) arxiv arxiv.tar.gz

arxiv: arxiv.tar.gz

arxiv.tar.gz: $(PAPER_NAME).pdf
	rm -rf arxiv
	mkdir -p arxiv
	latexpand --empty-comments $(PAPER_NAME).tex >arxiv/ms.tex
	cp .latex.out/$(PAPER_NAME).bbl arxiv/ms.bbl
	mkdir -p arxiv/figures
	cp figures/*.pdf figures/*.png arxiv/figures/
	cp acmart.cls arxiv/
	cp /usr/share/texmf/tex/gnuplot-lua-tikz.sty arxiv/
	cp /usr/share/texmf/tex/gnuplot-lua-tikz-common.tex arxiv/
	(cd arxiv && tar czf ../arxiv.tar.gz *)



check: bin/textidote.jar
	java -jar bin/textidote.jar --check en --dict .dict.txt --replace .spell-replace.txt $(PAPER_NAME).tex

bin/textidote.jar:
	[ -f /opt/texidote.jar ] && ln -s /opt/texidote.jar
	[ -f $@ ] || wget -O $@ https://github.com/sylvainhalle/textidote/releases/download/v0.8.2/textidote.jar


updatebib:
	rm -rf bibdb
	git clone git@github.com:FreakyPenguin/bibliography.git bibdb
	rm -rf bibdb/.git

.PHONY: all clean arxiv check updatebib
