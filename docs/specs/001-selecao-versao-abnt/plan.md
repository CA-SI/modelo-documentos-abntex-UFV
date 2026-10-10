# 001 — Plano

## Arquitetura

- Fonte canônica do pacote em `estilo/abntex2-UFV.sty`; cada modelo carrega uma
  cópia em `misc/` (necessária para o modelo funcionar sozinho no Overleaf ou em
  um `.zip`). `make sync` copia e `make check` falha se as cópias divergirem.
- Opções com `kvoptions`: `\DeclareStringOption[2023]{abnt}`.
- Depois de `\ProcessKeyvalOptions*`, se `\ABNTversao` existir, ela substitui a opção.
- Ramificação por `\ifcase`/`\ifnum` sobre o valor numérico validado.

## Mapeamento

| Opção | Pacote | Opções | Backend |
|-------|--------|--------|---------|
| 2023 | `biblatex` | `style=abnt, backend=biber` | Biber |
| 2018 | `biblatex` | `style=abnt, backend=biber, accite` | Biber |
| 2002 | `abntex2cite` | `alf, abnt-emphasize=bf` | BibTeX |

`\arquivoreferencias{x}`: `\addbibresource{x.bib}` (biblatex) ou guarda `x`
para `\bibliography{x}` (abntex2cite).

`\imprimirreferencias`: `\printbibliography[heading=bibintoc]` ou `\bibliography{x}`.

## Decisões

- Padrão `2023`: o modelo deve sair conforme a norma vigente sem configuração.
- `abntex2cite` passa a ser carregado pelo pacote, não pelo `main.tex`, para
  não haver dois sistemas de citação ao mesmo tempo.
- O `latexmk` detecta sozinho se deve rodar BibTeX ou Biber, então o build não
  precisa saber o backend.
