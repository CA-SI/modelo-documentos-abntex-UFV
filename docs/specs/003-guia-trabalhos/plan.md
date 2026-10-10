# 003 — Plano

## Arquitetura

- `documentos/Artigo-Monografia-Modular/` é a fonte. Capítulos:
  `1-introducao`, `2-estrutura`, `3-citacoes`, `4-referencias`, `5-elementos`,
  `6-ferramentas`, `7-conclusao`, e `apendices.tex`/`anexos.tex`.
- `documentos/Artigo-Monografia/main.tex` = `latexpand --keep-comments` do modular, com
  cabeçalho dizendo que o arquivo é gerado. `make gerar-unico` regenera; `make check` compara.
- `referencias.bib` canônico em `estilo/referencias.bib`, copiado por `make sync` (mesmo
  mecanismo do `.sty`). Cada entrada usa campos aceitos pelo BibTeX/abntex2cite e pelo
  biblatex (`urlaccessdate` e `urldate` juntos; `@phdthesis`/`@mastersthesis`).
- Pacotes novos: `subcaption`, `amsmath`, `algorithm` + `algpseudocode`, `siunitx`.

## Decisões

- Gerar o arquivo único em vez de manter dois textos: o guia é longo e duplicar
  garantiria divergência.
- Tabelas de comparação entre versões da ABNT são escritas no texto, não geradas, porque o
  documento é compilado numa versão só por vez.
