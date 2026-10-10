# Changelog

Formato baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/).

## [1.1.0] - 2026-10-10

### Adicionado
- Os modelos viram um guia para trabalhos acadêmicos: estrutura (NBR 14724, NBR 6024),
  citações (NBR 10520), referências (NBR 6023), ilustrações, tabelas, quadros,
  equações, algoritmos, código-fonte, ferramentas, apêndices e anexos.
- Base de referências com documentos reais de 11 tipos e modelo de entrada para TCC.
- Ambiente `quadro` e lista de quadros no pacote `abntex2-UFV`.
- `make gerar-unico`: o modelo de arquivo único é gerado a partir do modular (`latexpand`).

### Alterado
- Letras de desambiguação do ano (1984a, 1984b) também na lista de referências
  nas versões 2018 e 2023 (opção `extradate` do biblatex-abnt).
- Título da lista de referências fixado em "Referências" nas versões com biblatex.
- Entidades autoras em maiúsculas no `.bib`, para a versão 2002 mantê-las na citação.
- Créditos do repositório atualizados para Matheus Breguêz (matbrgz); `.mailmap` adicionado.
- Actions do CI fixadas por SHA; permissão de escrita só no job de release.

## [1.0.0] - 2026-10-10

### Adicionado
- Opção `abnt=2002|2018|2023` no pacote `abntex2-UFV` para escolher a versão
  da ABNT de citações (NBR 10520) e referências (NBR 6023). Padrão: 2023.
- Comandos `\arquivoreferencias`, `\imprimirreferencias` e `\imprimirversaoabnt`.
- `Makefile` com `pdf`, `todas`, `dist`, `sync`, `check` e `clean`.
- CI no GitHub Actions; Releases com um `.zip` por modelo e por versão da ABNT.
- Especificações em `docs/specs/`.

### Alterado
- Pacote de estilo canônico em `estilo/abntex2-UFV.sty`.
- Pasta `Artigo-Monografia Modular` renomeada para `Artigo-Monografia-Modular`.
- README reescrito.
- "Palavras-chave" separadas por ponto e vírgula (NBR 6028:2021).

### Corrigido
- `\lipsum` usado com o pacote `kantlipsum` (o modelo não compilava).
- `minted` não carregado no modelo de arquivo único.
- `\end{agradecimentos}` sobrando na epígrafe e `\begin{anexosenv}` comentado.
- Modelo modular referenciava imagens e citação inexistentes e trazia texto de outro TCC.

### Removido
- Build com gulp/yarn/mocha herdado do html5-boilerplate.
