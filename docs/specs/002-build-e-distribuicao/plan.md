# 002 — Plano

## Arquitetura

- `Makefile` na raiz, sem dependências além de TeX Live (`latexmk`), `zip` e Python 3 (para o `minted`).
- Compilação: `latexmk -pdf -outdir=build/<Modelo>/abnt-<v> -usepretex='\def\ABNTversao{<v>}' main.tex`,
  executado dentro da pasta do modelo para que caminhos relativos (`assets/`, `misc/`) funcionem.
- `.latexmkrc` em cada modelo (`$pdf_mode = 1`), para quem compila direto na pasta.
- `dist`: copia o modelo para `build/stage/`, troca `abnt=2023` pela versão no
  `main.tex` com `sed`, junta o PDF e compacta.
- CI: `xu-cheng/texlive-action` (imagem TeX Live completa), artefatos em todo push,
  `softprops/action-gh-release` em tags.

## Decisões

- `make` em vez de gulp/npm: quem escreve TCC já tem TeX Live; Node seria dependência extra.
- Pasta `Artigo-Monografia Modular` renomeada para `Artigo-Monografia-Modular`
  (espaço no nome quebra `make`).
