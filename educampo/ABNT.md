# Convenções ABNT nos trabalhos do Educampo

Regras de formatação seguidas nos documentos Typst desta pasta. Elas seguem o
*Modelo de trabalho acadêmico* da UFRGS (Google Docs) e as normas da ABNT:

- NBR 14724:2011 – trabalhos acadêmicos (página, texto, paginação, ilustrações);
- NBR 6024:2012 – numeração progressiva das seções;
- NBR 10520:2023 – citações;
- NBR 6023:2018 – referências.

Quando o modelo da UFRGS e a norma divergem, segue-se o modelo. As medidas que
o modelo não especifica e que foram estimadas a partir das imagens das páginas
dele estão marcadas com *(estimado)*.

## Página e texto

- Papel A4, com margens declaradas em milímetros: 30 mm à esquerda e em cima,
  20 mm à direita e embaixo.
- Fonte Arial 12pt, aqui por meio da Liberation Sans, que tem as mesmas métricas.
- Espaçamento 1,5 entre linhas, texto justificado e recuo de 1,27 cm na primeira
  linha dos parágrafos.
- Idioma declarado como pt-BR (`lang: "pt", region: "br"`), o que o PDF registra.

## Paginação

- A capa não é contada nem numerada.
- O número fica no canto superior direito, a 2 cm da borda superior, alinhado à
  margem direita, em 10pt.

## Títulos

Os títulos são `heading()` do Typst, numerados automaticamente (`1.1`). O
indicativo numérico fica alinhado à margem esquerda; quando o título ocupa mais
de uma linha, as seguintes se alinham ao início do título.

| Nível | Exemplo | Estilo | Distância do número ao título |
|---|---|---|---|
| 1 – primária | `1 INTRODUÇÃO` | negrito, maiúsculas, em nova página | 6,3 mm *(estimado)* |
| 2 – secundária | `2.1 SEÇÃO SECUNDÁRIA` | sem negrito, maiúsculas | 10 mm *(estimado)* |
| 3 – terciária | `2.2.1 Seção terciária` | negrito | 12,5 mm *(estimado)* |
| 4 – quaternária | `2.5.1.1 Quaternária` | sem negrito | – |
| 5 – quinária | `2.5.1.1.1 Quinária` | itálico | – |

- Uma linha em branco de espaçamento 1,5 separa cada título do texto que o
  precede e do que o sucede; entre dois títulos seguidos, fica uma só.
- No código-fonte, os títulos são escritos com inicial maiúscula; a regra de
  estilo os converte em maiúsculas onde for o caso. Assim, os marcadores do PDF
  ficam legíveis.
- Títulos sem indicativo numérico (REFERÊNCIAS, APÊNDICE A – …) são centralizados,
  em negrito e começam em nova página.

## Ilustrações

Figuras, tabelas e quadros são `figure()` do Typst, numerados em sequência por
tipo (Figura 1, 2…; Tabela 1…; Quadro 1…).

- A legenda vem acima: `Figura 1 – Título`, sem ponto final, em espaçamento 1,5,
  com as linhas seguintes alinhadas depois do travessão.
- A ilustração vem logo abaixo, alinhada à margem esquerda, separada da legenda
  por 6pt *(estimado)*, e não ultrapassa as margens.
- A fonte vem logo abaixo da ilustração: `Fonte: Autor (ano).`, em 10pt e
  espaçamento simples. Toda ilustração tem fonte; para material dos próprios
  autores, usa-se o nome de quem o produziu ou "Elaboração própria".
- Uma linha em branco separa a ilustração do texto.
- No texto, as ilustrações são citadas por referência (`@fig-cascata`), para que
  a numeração se atualize sozinha.

## Citações

- Sobrenomes com só a inicial maiúscula, dentro e fora dos parênteses:
  "Bremm (2015)", "(Bremm, 2015 _apud_ Pastorio, 2015; Janata; Anhaia, 2015)".
  A grafia em maiúsculas dentro dos parênteses é da versão de 2002 da NBR 10520.
- A grafia do nome precisa ser a mesma na citação e na referência.

## Referências

- Sobrenome do autor em maiúsculas, seguido dos prenomes: "BREMM, Cristina.".
- Alinhadas somente à margem esquerda.
- A NBR 6023 pede espaçamento simples, sem recuo, com uma linha em branco simples
  entre as referências.
