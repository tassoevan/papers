# Inventário da Realidade

*Inventário da Realidade no território compartilhado de Guaíba, Mariana Pimentel e
Barra do Ribeiro*, de Alan Dhoni Garcia do Nascimento, Alexandre da Cruz, Juliane
Nunes Hallal Cabral e Tasso Evangelista Pinto (2026).

O documento foi escrito no Word. O código Typst foi reconstruído a partir do PDF
original e depois ajustado às convenções de [../ABNT.md](../ABNT.md). Este
arquivo registra as decisões próprias deste documento e o que ainda está em
aberto.

## Arquivos

- `inventario-da-realidade.typ`: código-fonte.
- `inventario-da-realidade.pdf`: PDF gerado, versionado junto com o código.
- `figuras/`: imagens extraídas do PDF original, sem recompressão, nomeadas pelo
  número da figura e por um resumo da legenda (`04-cascata-do-portugues.jpg`). A
  Figura 6 é formada por duas fotos, `06a-` e `06b-`.

Para gerar o PDF, a partir da raiz do repositório:

```sh
f=educampo/inventario-da-realidade/inventario-da-realidade.typ
mise exec -- typst compile --creation-timestamp "$(date -r "$f" +%s)" "$f"
```

## Decisões

### Herdadas do original

- O texto mantém a fonte, o corpo, o espaçamento e o recuo do Word. Kerning e
  hifenização estão desligados, como no Word.
- O corpo do texto começa 4,2 mm abaixo da margem superior de 30 mm, como no
  original, em que a linha vazia do cabeçalho o empurrava para baixo
  (`header-height`). Para começar exatamente na margem, basta zerar esse valor.
- A capa, as tabelas e o quadro são desenhados com as coordenadas medidas no PDF
  original.

### Estrutura

- As seções foram renumeradas: o original repetia o número 3 (RECURSOS NATURAIS
  e ORGANIZAÇÃO SOCIOPOLÍTICA) e o 3.8 (CEMITÉRIO PASSO GRANDE e ALDEIAS MBYÁ).
- "6.1 Culinária típica rural" fica em "6 Tempo livre": trata de aspectos
  culturais, embora ligada à produção.
- O apêndice e as referências começam em nova página; o restante é paginado
  livremente, e as quebras de linha dos parágrafos são as do Typst, não as do
  Word.

### Ilustrações

- As figuras foram renumeradas em sequência (1 a 19). O original tinha três
  "Fig. 7", duas figuras sem número e legendas que descreviam duas figuras ao
  mesmo tempo, agora separadas.
- As fontes que estavam dentro das legendas foram passadas para a linha "Fonte:".
  As ilustrações sem fonte receberam as indicadas pelos autores: Cabral (2026)
  para as fotos e mapas do trabalho de campo, "Elaboração própria" para a
  Tabela 1 e o Quadro 1.
- Legendas laterais e pares de fotos lado a lado foram empilhados, cada figura
  com a própria legenda acima.
- As Figuras 10 e 11, que ultrapassavam a margem direita, foram reduzidas à
  largura do texto; as Figuras 2 e 3 foram reduzidas a 90% para caberem na mesma
  página.

### Texto

- Erros de digitação foram corrigidos pelos autores. "Matarias" está correto
  (mataria: grande extensão de mato).
- Grafias padronizadas: "Tekoá", "Tape Porã", "Assembleia", "Bremm".
- As referências foram todas alinhadas à esquerda; no original, a de Dal Sasso
  era justificada.

## Em aberto

- As referências mantêm o espaçamento de 1,35 linha e o recuo de primeira linha
  do original. A NBR 6023 pede espaçamento simples, sem recuo e com uma linha em
  branco entre elas.
- A escola da Tekoá Porã aparece como "EEIEF Teko'a Porã" na lista de aldeias
  (seção 4.3, item c) e como "EEIEF Tekoá Porã" no capítulo 5.
- As medidas *(estimadas)* em [../ABNT.md](../ABNT.md) podem ser conferidas no
  arquivo original do modelo da UFRGS, se estiver disponível.
- O documento não tem os elementos pré-textuais da NBR 14724 (folha de rosto,
  resumo, sumário, lista de ilustrações). Se forem necessários, o sumário e a
  lista de ilustrações podem ser gerados com `outline()`.
