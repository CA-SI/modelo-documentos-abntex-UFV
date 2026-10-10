# 001 — Seleção da versão da ABNT

## Problema

Os modelos usam `abntex2cite`, que implementa NBR 6023:2002 (referências) e
NBR 10520:2002 (citações). As duas normas foram substituídas: NBR 6023:2018 e
NBR 10520:2023. Alguns cursos e orientadores ainda exigem a versão antiga, então
trocar a norma de vez não resolve: o autor precisa escolher.

## Requisitos

1. O pacote `abntex2-UFV` aceita a opção `abnt=<versão>` com os valores:
   - `2023` (padrão): NBR 10520:2023 + NBR 6023:2018 (`biblatex-abnt`, Biber).
   - `2018`: NBR 10520:2002 (autores em caixa alta nas citações) + NBR 6023:2018
     (`biblatex-abnt` com `accite`, Biber).
   - `2002`: NBR 10520:2002 + NBR 6023:2002 (`abntex2cite`, BibTeX).
2. A versão também pode ser escolhida sem editar o documento, por uma macro
   `\ABNTversao` definida antes do preâmbulo (usada pelo build, spec 002). Ela
   tem precedência sobre a opção do pacote.
3. Um valor inválido interrompe a compilação com mensagem que lista os valores aceitos.
4. O mesmo `.tex` compila nas três versões sem alteração. Para isso o pacote expõe:
   - `\arquivoreferencias{<arquivo sem .bib>}` no preâmbulo;
   - `\imprimirreferencias` nos elementos pós-textuais;
   - nos modos `biblatex`, os apelidos `\citeonline` → `\textcite` e
     `\apudonline` → `\textapud`, para que os comandos do `abntex2cite` continuem
     funcionando. `\cite` e `\apud` têm a mesma sintaxe nos dois pacotes.
5. A versão ativa fica disponível em `\imprimirversaoabnt` e é registrada no log.

## Critérios de aceite

- `main.tex` dos dois modelos compila sem erro com `abnt=2002`, `2018` e `2023`.
- Em `2023` a citação entre parênteses sai em caixa alta e baixa: "(Dongen, 2012)".
- Em `2018` e `2002` sai em caixa alta: "(DONGEN, 2012)".
- `abnt=1999` gera erro com a lista de valores válidos.

## Fora de escopo

- NBR 14724 (trabalhos acadêmicos), NBR 6024, NBR 6027 e NBR 6028: o layout
  (margens, capa, folha de rosto) não muda entre as opções.
- Estilo numérico de citação (`abnt-numeric`).
