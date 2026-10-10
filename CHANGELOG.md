# Changelog

Formato baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/).

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
