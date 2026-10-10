# Modelos abnTeX2 UFV
#
#   make                  compila todos os modelos na versão padrão da ABNT (2023)
#   make pdf ABNT=2002    compila todos os modelos na versão escolhida
#   make todas            compila todos os modelos em todas as versões
#   make dist             gera dist/<Modelo>-ABNT-<versão>.zip e .pdf
#   make check            confere arquivos gerados e compila tudo
#   make gerar-unico      gera o modelo de arquivo único a partir do modular
#   make clean            apaga build/ e dist/

ABNT     ?= 2023
VERSOES  := 2002 2018 2023
MODELOS  := Artigo-Monografia Artigo-Monografia-Modular
ESTILO   := estilo/abntex2-UFV.sty
BIB      := estilo/referencias.bib
MODULAR  := documentos/Artigo-Monografia-Modular
UNICO    := documentos/Artigo-Monografia/main.tex
BUILD    := build
DIST     := dist
LATEXMK  := latexmk -pdf -interaction=nonstopmode -halt-on-error -file-line-error

COPIAS_ESTILO := $(foreach m,$(MODELOS),documentos/$(m)/misc/abntex2-UFV.sty)
COPIAS_BIB    := $(foreach m,$(MODELOS),documentos/$(m)/referencias.bib)
FONTES_GUIA   := $(MODULAR)/main.tex $(wildcard $(MODULAR)/capitulos/*.tex $(MODULAR)/pos-textuais/*.tex)
pdfs = $(foreach v,$(1),$(foreach m,$(MODELOS),$(BUILD)/$(m)/abnt-$(v)/main.pdf))

.PHONY: all pdf todas dist sync gerar-unico check verificar-estilo verificar-unico verificar-versao-invalida clean FORCE

all: pdf

pdf: $(call pdfs,$(ABNT))

todas: $(call pdfs,$(VERSOES))

# Copia o pacote e o .bib canônicos para cada modelo (cada modelo precisa funcionar sozinho).
sync: $(COPIAS_ESTILO) $(COPIAS_BIB)

documentos/%/misc/abntex2-UFV.sty: $(ESTILO)
	mkdir -p $(dir $@)
	cp $< $@

documentos/%/referencias.bib: $(BIB)
	cp $< $@

# O modelo de arquivo único é o guia modular expandido; não edite à mão.
define CABECALHO_UNICO
%% ARQUIVO GERADO por `make gerar-unico` a partir de $(MODULAR)/.
%% Para alterar o guia, edite o modelo modular e regenere este arquivo.
endef
export CABECALHO_UNICO

gerar-unico: $(UNICO)

$(UNICO): $(FONTES_GUIA)
	{ echo "$$CABECALHO_UNICO"; cd $(MODULAR) && latexpand --keep-comments main.tex; } > $@

# $* = <Modelo>/abnt-<versão>. O latexmk decide sozinho entre BibTeX e Biber.
$(BUILD)/%/main.pdf: FORCE $(COPIAS_ESTILO) $(COPIAS_BIB) $(UNICO)
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

check: sync verificar-estilo verificar-unico verificar-versao-invalida todas

verificar-estilo: sync
	@set -e; for f in $(COPIAS_ESTILO); do \
	  cmp -s $(ESTILO) "$$f" || { echo "ERRO: $$f difere de $(ESTILO). Rode 'make sync'."; exit 1; }; \
	done; for f in $(COPIAS_BIB); do \
	  cmp -s $(BIB) "$$f" || { echo "ERRO: $$f difere de $(BIB). Rode 'make sync'."; exit 1; }; \
	done; echo "Cópias do pacote de estilo e do .bib sincronizadas."

# O arquivo único versionado tem de ser idêntico ao gerado a partir do modular.
verificar-unico:
	@mkdir -p $(BUILD)
	@{ echo "$$CABECALHO_UNICO"; cd $(MODULAR) && latexpand --keep-comments main.tex; } > $(BUILD)/unico-esperado.tex
	@cmp -s $(BUILD)/unico-esperado.tex $(UNICO) || { echo "ERRO: $(UNICO) desatualizado. Rode 'make gerar-unico'."; exit 1; }
	@echo "Modelo de arquivo único em dia com o modular."

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
