DIR = /paper/
PAPER = paper
OUT_DIR = /paper/out/

all: acm.pdf ieee.pdf lncs.pdf #ieee.tex lncs.tex acm.tex

ieee.pdf ieee.tex:
	cp ./styles/IEEEtran.cls .
	mkdir -p $(OUT_DIR)
	pandoc  --wrap=preserve \
		--filter pandoc-crossref \
		--filter pandoc-citeproc \
		--filter ./pandoc-tools/table-filter.py \
		--filter ./pandoc-tools/bib-filter.py \
		--number-sections \
		--csl=./styles/ieee.csl \
		./ieee-packages.yaml \
		--include-before-body=./templates/ieee-longtable-fix-preamble.latex \
		--include-before-body=./ieee-author-preamble.latex \
		--template=./templates/ieee.latex \
		-o $(OUT_DIR)$(subst ieee,$(PAPER)-iee,$@) $(DIR)$(PAPER).md
	rm ./IEEEtran.cls

acm.pdf acm.tex:
	cp ./styles/acmart.cls .
	mkdir -p $(OUT_DIR)
	pandoc  --wrap=preserve \
		--filter pandoc-crossref \
		--filter pandoc-citeproc \
		--filter ./pandoc-tools/table-filter.py \
		--filter ./pandoc-tools/bib-filter.py \
		--csl=./styles/acm.csl \
		--number-sections \
		./acm-packages.yaml \
		--include-before-body=./templates/acm-longtable-fix-preamble.latex \
		--include-before-body=./acm-author-preamble.latex \
		--template=./templates/acm.latex \
		-o $(OUT_DIR)$(subst acm,$(PAPER)-acm,$@) $(DIR)$(PAPER).md
	rm ./acmart.cls

lncs.pdf lncs.tex:
	cp ./styles/llncs.cls .
	mkdir -p $(OUT_DIR)
	pandoc  --wrap=preserve \
		--filter pandoc-crossref \
		--filter pandoc-citeproc \
		--filter ./pandoc-tools/table-filter.py \
		--filter ./pandoc-tools/bib-filter.py \
		--csl=./styles/llncs.csl \
		--number-sections \
		./llncs-packages.yaml \
		--template=./templates/llncs.latex \
		-o $(OUT_DIR)$(subst lncs,$(PAPER)-lncs,$@) $(DIR)$(PAPER).md
	rm ./llncs.cls

clean:
	rm -r $(OUT_DIR)

