# 003 — Guia para trabalhos acadêmicos

## Problema

Os modelos trazem capítulos vazios e poucos exemplos. Quem escreve o primeiro
trabalho precisa consultar várias normas e manuais para saber o que vai em cada
parte e como fazer cada elemento no LaTeX.

## Requisitos

1. O conteúdo dos modelos passa a ser um guia: cada capítulo explica uma parte do
   trabalho acadêmico e demonstra, no próprio texto, como produzi-la.
2. Cobertura mínima:
   - estrutura do trabalho (NBR 14724): elementos pré-textuais, textuais e pós-textuais;
     regras de formatação; numeração progressiva (NBR 6024) até a seção quinária;
   - citações (NBR 10520): direta curta, direta longa, indireta, citação de citação,
     múltiplas obras, mesmo autor e ano, supressão, destaque, notas de rodapé;
     diferenças entre as versões 2002 e 2023;
   - referências (NBR 6023): 12 tipos de documento (livro, capítulo, artigo de periódico,
     tese, dissertação, TCC, trabalho em evento, norma técnica, legislação, página web,
     software, conjunto de dados). Os 11 primeiros com documentos reais no `.bib`; o TCC
     como modelo de entrada comentado, já que não há um TCC cuja referência tenha sido verificada;
   - ilustrações e elementos gráficos: figura, subfiguras, tabela no padrão IBGE,
     quadro, equações, algoritmo, código-fonte, alíneas, siglas e símbolos;
   - apêndices e anexos;
   - fluxo de trabalho: compilação, escolha da versão da ABNT, gestores de referência, Git.
3. O modelo modular é a fonte do guia. O modelo de arquivo único é gerado a partir
   dele (`latexpand`) e não é editado à mão.
4. Todas as referências do `.bib` são documentos reais, com dados verificáveis.

## Critérios de aceite

- Os dois modelos compilam nas três versões da ABNT sem citações ou referências indefinidas.
- `make check` falha se o modelo de arquivo único estiver desatualizado em relação ao modular.
- A lista de referências do PDF contém os 11 tipos com documentos reais, e o guia mostra o modelo de entrada de TCC.

## Fora de escopo

- Modelos de dissertação e tese com folhas específicas de pós-graduação.
- Glossário e índice remissivo.
