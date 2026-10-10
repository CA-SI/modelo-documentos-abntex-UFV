# Modelos abnTeX2 UFV
#
#   make                  compila todos os modelos na versão padrão da ABNT (2023)
#   make pdf ABNT=2002    compila todos os modelos na versão escolhida
#   make todas            compila todos os modelos em todas as versões
#   make dist             gera dist/<Modelo>-ABNT-<versão>.zip e .pdf
#   make check            confere o pacote de estilo e compila tudo
#   make clean            apaga build/ e dist/

ABNT     ?= 2023
VERSOES  := 2002 2018 2023
MODELOS  := Artigo-Monografia Artigo-Monografia-Modular
ESTILO   := estilo/abntex2-UFV.sty
BUILD    := build
DIST     := dist
LATEXMK  := latexmk -pdf -interaction=nonstopmode -halt-on-error -file-line-error

COPIAS_ESTILO := $(foreach m,$(MODELOS),documentos/$(m)/misc/abntex2-UFV.sty)
pdfs = $(foreach v,$(1),$(foreach m,$(MODELOS),$(BUILD)/$(m)/abnt-$(v)/main.pdf))

.PHONY: all pdf todas dist sync check verificar-estilo verificar-versao-invalida clean FORCE

all: pdf

pdf: $(call pdfs,$(ABNT))

todas: $(call pdfs,$(VERSOES))

# Copia o pacote canônico para cada modelo (cada modelo precisa funcionar sozinho).
sync: $(COPIAS_ESTILO)

documentos/%/misc/abntex2-UFV.sty: $(ESTILO)
	mkdir -p $(dir $@)
	cp $< $@

# $* = <Modelo>/abnt-<versão>. O latexmk decide sozinho entre BibTeX e Biber.
$(BUILD)/%/main.pdf: FORCE $(COPIAS_ESTILO)
	cd documentos/$(patsubst %/,%,$(dir $*)) && \
	  $(LATEXMK) -outdir=$(CURDIR)/$(BUILD)/$* \
	    -usepretex='\def\ABNTversao{$(subst abnt-,,$(notdir $*))}' main.tex

dist: todas
	mkdir -p $(DIST) $(BUILD)/stage
	@set -e; for m in $(MODELOS); do for v in $(VERSOES); do \
	  nome="$$m-ABNT-$$v"; destino="$(BUILD)/stage/$$nome"; \
	  echo "==> $(DIST)/$$nome.zip"; \
	  mkdir -p "$$destino"; \
	  cp -R "documentos/$$m/." "$$destino/"; \
	  sed "s/\[abnt=[0-9]*\]/[abnt=$$v]/" "documentos/$$m/main.tex" > "$$destino/main.tex"; \
	  cp "$(BUILD)/$$m/abnt-$$v/main.pdf" "$$destino/$$nome.pdf"; \
	  cp "$(BUILD)/$$m/abnt-$$v/main.pdf" "$(DIST)/$$nome.pdf"; \
	  (cd "$(BUILD)/stage" && zip -qr "$(CURDIR)/$(DIST)/$$nome.zip" "$$nome"); \
	done; done

check: sync verificar-estilo verificar-versao-invalida todas

verificar-estilo: sync
	@set -e; for f in $(COPIAS_ESTILO); do \
	  cmp -s $(ESTILO) "$$f" || { echo "ERRO: $$f difere de $(ESTILO). Rode 'make sync'."; exit 1; }; \
	done; echo "Cópias do pacote de estilo sincronizadas."

# Uma versão inexistente tem de interromper a compilação.
verificar-versao-invalida: $(COPIAS_ESTILO)
	@mkdir -p $(BUILD)/invalida && cd documentos/Artigo-Monografia && \
	if pdflatex -interaction=nonstopmode -halt-on-error -output-directory=$(CURDIR)/$(BUILD)/invalida \
	    '\def\ABNTversao{1999}\input{main.tex}' > /dev/null 2>&1; then \
	  echo "ERRO: abnt=1999 deveria falhar."; exit 1; \
	elif grep -q "Package abntex2-UFV Error" $(CURDIR)/$(BUILD)/invalida/main.log; then \
	  echo "abnt=1999 rejeitada, como esperado."; \
	else echo "ERRO: abnt=1999 falhou por outro motivo; veja $(BUILD)/invalida/main.log."; exit 1; fi

clean:
	rm -rf $(BUILD) $(DIST)

FORCE:
