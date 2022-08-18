DIR ?= ./
PAPER ?= paper
OUT_DIR ?= ./out/

INS_DIR ?= /workspace

all: acm.pdf ieee.pdf lncs.pdf #ieee.tex lncs.tex acm.tex

ieee.pdf ieee.tex:
	cp $(INS_DIR)/styles/IEEEtran.cls .
	mkdir -p $(OUT_DIR)
	pandoc  --wrap=preserve \
		--filter pandoc-crossref \
		--filter pandoc-citeproc \
		--filter $(INS_DIR)/pandoc-tools/table-filter.py \
		--filter $(INS_DIR)/pandoc-tools/bib-filter.py \
		--number-sections \
		--csl=$(INS_DIR)/styles/ieee.csl \
		$(INS_DIR)/ieee-packages.yaml \
		--include-before-body=$(INS_DIR)/templates/ieee-longtable-fix-preamble.latex \
		--include-before-body=$(INS_DIR)/ieee-author-preamble.latex \
		--template=$(INS_DIR)/templates/ieee.latex \
		-o $(OUT_DIR)$(subst ieee,$(PAPER)-iee,$@) $(DIR)$(PAPER).md
	rm ./IEEEtran.cls

acm.pdf acm.tex:
	cp $(INS_DIR)/styles/acmart.cls .
	mkdir -p $(OUT_DIR)
	pandoc  --wrap=preserve \
		--filter pandoc-crossref \
		--filter pandoc-citeproc \
		--filter $(INS_DIR)/pandoc-tools/table-filter.py \
		--filter $(INS_DIR)/pandoc-tools/bib-filter.py \
		--csl=$(INS_DIR)/styles/acm.csl \
		--number-sections \
		$(INS_DIR)/acm-packages.yaml \
		--include-before-body=$(INS_DIR)/templates/acm-longtable-fix-preamble.latex \
		--include-before-body=$(INS_DIR)/acm-author-preamble.latex \
		--template=$(INS_DIR)/templates/acm.latex \
		-o $(OUT_DIR)$(subst acm,$(PAPER)-acm,$@) $(DIR)$(PAPER).md
	rm ./acmart.cls

lncs.pdf lncs.tex:
	cp $(INS_DIR)/styles/llncs.cls .
	mkdir -p $(OUT_DIR)
	pandoc  --wrap=preserve \
		--filter pandoc-crossref \
		--filter pandoc-citeproc \
		--filter $(INS_DIR)/pandoc-tools/table-filter.py \
		--filter $(INS_DIR)/pandoc-tools/bib-filter.py \
		--csl=$(INS_DIR)/styles/llncs.csl \
		--number-sections \
		$(INS_DIR)/llncs-packages.yaml \
		--template=$(INS_DIR)/templates/llncs.latex \
		-o $(OUT_DIR)$(subst lncs,$(PAPER)-lncs,$@) $(DIR)$(PAPER).md
	rm ./llncs.cls

clean:
	rm -r $(OUT_DIR)

