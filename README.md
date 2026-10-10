# Modelo de Documentos abnTeX2 UFV

[![Build](https://github.com/CA-SI/modelo-documentos-abntex-UFV/actions/workflows/build.yml/badge.svg)](https://github.com/CA-SI/modelo-documentos-abntex-UFV/actions/workflows/build.yml)
[![GitHub release](https://img.shields.io/github/v/release/CA-SI/modelo-documentos-abntex-UFV?style=flat-square)](https://github.com/CA-SI/modelo-documentos-abntex-UFV/releases)
[![GitHub contributors](https://img.shields.io/github/contributors/CA-SI/modelo-documentos-abntex-UFV.svg?style=flat-square)](https://github.com/CA-SI/modelo-documentos-abntex-UFV/graphs/contributors)
[![GitHub license](https://img.shields.io/github/license/CA-SI/modelo-documentos-abntex-UFV.svg?style=flat-square)](LICENSE)

Guia e modelo LaTeX, baseado no [abnTeX2](https://github.com/abntex/abntex2), para
trabalhos acadêmicos da Universidade Federal de Viçosa (UFV), com capa, folha de
rosto e folha de aprovação no padrão da universidade. **Você escolhe a versão da
ABNT** usada nas citações e referências.

O modelo é também um guia: cada seção primária explica uma parte do trabalho e mostra,
no próprio código, como produzi-la:

| Seção | Conteúdo |
|----------|----------|
| 1. Introdução | como usar o modelo, escolha da versão da ABNT, objetivos |
| 2. Estrutura | elementos pré-textuais, textuais e pós-textuais (NBR 14724), formatação, numeração progressiva (NBR 6024) |
| 3. Citações | indireta, direta curta e longa, supressão, destaque, *apud*, *et al.*, notas (NBR 10520) |
| 4. Referências | arquivo `.bib` e 12 tipos de documento: livro, capítulo, artigo, evento, tese, dissertação, TCC, norma, lei, página web, software, conjunto de dados (NBR 6023) |
| 5. Elementos | figuras, subfiguras, tabelas IBGE, quadros, equações, algoritmos, código-fonte, alíneas, siglas |
| 6. Ferramentas | latexmk, Overleaf, `make`, gerenciadores de referências, Git |
| Apêndices e anexos | exemplos de cada um |

Todas as referências de exemplo são documentos reais.

## Versões da ABNT disponíveis

| Opção | Citações | Referências | Motor | Quando usar |
|-------|----------|-------------|-------|-------------|
| `abnt=2023` (padrão) | NBR 10520:2023 — `(Silva, 2020)` | NBR 6023:2018 | biblatex-abnt + Biber | Citações conforme a edição vigente |
| `abnt=2018` | NBR 10520:2002 — `(SILVA, 2020)` | NBR 6023:2018 | biblatex-abnt + Biber | Orientador exige autor em caixa alta na citação |
| `abnt=2002` | NBR 10520:2002 — `(SILVA, 2020)` | NBR 6023:2002 | abntex2cite + BibTeX | Normas antigas, compatível com modelos anteriores |

O layout (margens, capa, folha de rosto, NBR 14724:2024) é o mesmo nas três opções.

> A NBR 6023 teve nova edição em 2025, com mudanças pontuais (coleções e fascículos de
> periódicos, e-localização em artigos eletrônicos, evento no todo e jurisprudência). O
> `biblatex-abnt` 4.0 segue a edição de 2018; confira esses tipos de referência com a de 2025.

## Modelos

| Pasta | Descrição |
|-------|-----------|
| [`documentos/Artigo-Monografia-Modular`](documentos/Artigo-Monografia-Modular) | Guia/monografia com um arquivo por seção primária (fonte do guia) |
| [`documentos/Artigo-Monografia`](documentos/Artigo-Monografia) | O mesmo guia em um único `main.tex`, gerado a partir do modular |

## Como usar

### 1. Baixar pronto (mais fácil)

Em [Releases](https://github.com/CA-SI/modelo-documentos-abntex-UFV/releases),
baixe o `.zip` do modelo **já configurado na versão da ABNT que você quer**, por
exemplo `Artigo-Monografia-ABNT-2023.zip`. Cada `.zip` traz o código-fonte e o
PDF de exemplo. Funciona no [Overleaf](https://www.overleaf.com/)
(*New Project → Upload Project*) ou no seu computador.

### 2. Escolher a versão no documento

No `main.tex`, troque o valor da opção:

```latex
\usepackage[abnt=2023]{misc/abntex2-UFV}   % ou abnt=2018, abnt=2002
```

O mesmo texto funciona nas três versões. Use sempre:

```latex
% preâmbulo
\arquivoreferencias{referencias}   % referencias.bib, sem a extensão

% texto
\cite{chave}               % (Autor, ano)
\cite[p.~42]{chave}        % (Autor, ano, p. 42)
\citeonline{chave}         % Autor (ano)
\apud{original}{fonte}     % (Original apud Fonte)
\apudonline{original}{fonte}

% elementos pós-textuais
\imprimirreferencias
```

Ao trocar de versão, apague os arquivos auxiliares (`.aux`, `.bbl`, `.bcf`) ou
rode `latexmk -C`, porque as versões usam programas de bibliografia diferentes
(BibTeX ou Biber).

### 3. Compilar todas as versões com `make`

Requisitos: [TeX Live](https://tug.org/texlive/) 2024 ou mais recente (inclui
`latexmk`, `biber` e `biblatex-abnt` 4.0+), Python 3 (para o pacote `minted`) e `zip`.

```sh
make                 # todos os modelos, ABNT 2023 → build/<Modelo>/abnt-2023/main.pdf
make pdf ABNT=2002   # todos os modelos na versão escolhida
make todas           # todos os modelos nas três versões
make dist            # dist/<Modelo>-ABNT-<versão>.zip e .pdf
make gerar-unico     # regenera o modelo de arquivo único a partir do modular
make check           # confere arquivos gerados, a validação de versão e compila tudo
make clean           # apaga build/ e dist/
```

Para compilar só um modelo, dentro da pasta dele: `latexmk main.tex`.

## Estrutura do repositório

```
estilo/abntex2-UFV.sty      pacote canônico (capa, folha de rosto, quadro, seleção da ABNT)
estilo/referencias.bib      base de referências canônica dos modelos
documentos/<Modelo>/        modelos; misc/abntex2-UFV.sty e referencias.bib são cópias (`make sync`)
docs/specs/                 especificações das mudanças (SDD)
.github/workflows/          CI: compila em todo push e publica o Release em tags v*
```

Edite sempre os arquivos em `estilo/` e o guia em `documentos/Artigo-Monografia-Modular/`,
e rode `make sync gerar-unico`. O `make check` falha se alguma cópia ou o arquivo único
estiver desatualizado.

## Como contribuir

1. Faça um [fork](https://github.com/CA-SI/modelo-documentos-abntex-UFV/fork) e clone.
2. Crie uma branch: `git checkout -b minha-melhoria`.
3. Faça a alteração e rode `make check`.
4. Faça commit, `git push` e abra um Pull Request.

Para publicar uma versão, crie uma tag `vX.Y.Z`; o CI anexa os `.zip` e PDFs ao Release.

## Colaboradores

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/matbrgz"><img src="https://avatars.githubusercontent.com/u/23284276?v=4" width="100px;" alt="Matheus Breguêz"/><br /><sub><b>Matheus Breguêz</b></sub></a><br /><a href="https://github.com/CA-SI/modelo-documentos-abntex-UFV/commits?author=matbrgz" title="Code">💻</a> <a href="#design-matbrgz" title="Design">🎨</a> <a href="https://github.com/CA-SI/modelo-documentos-abntex-UFV/commits?author=matbrgz" title="Documentation">📖</a></td>
  </tr>
</table>

<!-- markdownlint-enable -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

Este projeto segue a especificação [all-contributors](https://allcontributors.org/).
Para creditar alguém em um PR ou issue, comente
`@all-contributors please add @usuario for code, doc`
(veja a [tabela de tipos](https://allcontributors.org/docs/pt-br/emoji-key)).

Modelo original de Rodrigo Smarzaro e do Centro Acadêmico de Sistemas de
Informação (CASI), UFV *Campus* Rio Paranaíba.

## Artigo

O projeto é apresentado no artigo [CA-SI/artigo-modelo-abntex-ufv](https://github.com/CA-SI/artigo-modelo-abntex-ufv),
escrito com o próprio pacote `abntex2-UFV`.

## Licença

[MIT](LICENSE)
