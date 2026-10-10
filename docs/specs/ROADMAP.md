# Roadmap

| Ordem | Spec | Depende de |
|-------|------|------------|
| 1 | [001-selecao-versao-abnt](001-selecao-versao-abnt/spec.md) | — |
| 2 | [002-build-e-distribuicao](002-build-e-distribuicao/spec.md) | 001 (o build recebe a versão da ABNT como parâmetro) |
| 3 | [003-guia-trabalhos](003-guia-trabalhos/spec.md) | 001 (os exemplos compilam nas três versões), 002 (geração e verificação via `make`) |

O artigo que apresenta o projeto fica no repositório próprio `CA-SI/artigo-modelo-abntex-ufv`, que consome o pacote `abntex2-UFV` deste repositório.
