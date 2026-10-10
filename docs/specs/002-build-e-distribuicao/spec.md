# 002 — Build e distribuição

## Problema

O build herdado do html5-boilerplate (gulp, yarn, mocha) não compila LaTeX e
referencia tarefas inexistentes. Não há como gerar os PDFs nem os pacotes de
download de cada versão da ABNT.

## Requisitos

1. `make` compila todos os modelos na versão padrão (2023).
2. `make pdf ABNT=<versão>` compila na versão escolhida; `make todas` compila nas três.
3. `make dist` gera, para cada modelo e cada versão, `dist/<Modelo>-ABNT-<versão>.zip`
   com o código-fonte já configurado para aquela versão (`abnt=<versão>` no
   `main.tex`) e o PDF compilado.
4. `make check` verifica que as cópias do pacote estão sincronizadas e que tudo compila.
5. `make clean` apaga apenas `build/` e `dist/`.
6. CI no GitHub Actions roda `make check` em push e PR, e em tag `v*` publica os
   `.zip` e PDFs como assets do Release.
7. README reescrito: como usar, como escolher a versão, tabela de normas, como contribuir.

## Critérios de aceite

- `make check` passa localmente com TeX Live 2026.
- Cada `.zip` descompactado compila sozinho com `latexmk` e gera o mesmo PDF.

## Fora de escopo

- Publicação no CTAN.
- Modelos novos (artigo, dissertação, tese).
