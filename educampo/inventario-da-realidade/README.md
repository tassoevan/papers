# Inventário da Realidade

*Inventário da Realidade no território compartilhado de Guaíba, Mariana Pimentel e
Barra do Ribeiro*, de Alan Dhoni Garcia do Nascimento, Alexandre da Cruz, Juliane
Nunes Hallal Cabral e Tasso Evangelista Pinto (2026).

O documento segue as convenções de [../ABNT.md](../ABNT.md). Este arquivo
registra as decisões próprias dele e o que ainda está em aberto.

## Arquivos

- `inventario-da-realidade.typ`: código-fonte.
- `inventario-da-realidade.pdf`: PDF gerado, versionado junto com o código.
- `figuras/`: imagens das figuras, nomeadas pelo número da figura e por um resumo
  da legenda (`04-cascata-do-portugues.jpg`). A Figura 6 é formada por duas
  fotos, `06a-` e `06b-`.

Para gerar o PDF, a partir da raiz do repositório:

```sh
f=educampo/inventario-da-realidade/inventario-da-realidade.typ
mise exec -- typst compile --creation-timestamp "$(date -r "$f" +%s)" "$f"
```

## Decisões

### Página e texto

- Kerning e hifenização estão desligados.
- O corpo do texto começa 4,2 mm abaixo da margem superior de 30 mm
  (`header-height`). Para começar exatamente na margem, basta zerar esse valor.
- A capa, a Tabela 1 e o Quadro 1 são desenhados com coordenadas absolutas, em
  pontos.

### Estrutura

- Cada número de seção aparece uma só vez: RECURSOS NATURAIS é a seção 3,
  ORGANIZAÇÃO SOCIOPOLÍTICA a 4; CEMITÉRIO PASSO GRANDE é a 4.2 e ALDEIAS MBYÁ a
  4.3.
- "6.1 Culinária típica rural" fica em "6 Tempo livre": trata de aspectos
  culturais, embora ligada à produção.
- O apêndice e as referências começam em nova página; o restante é paginado
  livremente.

### Ilustrações

- As figuras são numeradas em sequência (1 a 19), cada uma com a própria
  legenda.
- Todas as ilustrações têm fonte: Cabral (2026) para as fotos e mapas do
  trabalho de campo, "Elaboração própria" para a Tabela 1 e o Quadro 1, e o autor
  citado nas demais.
- Figuras que ficariam lado a lado são empilhadas, cada uma com a legenda acima.
- As Figuras 10 e 11 ocupam a largura do texto; as Figuras 2 e 3 estão reduzidas
  a 90% para caberem na mesma página.

### Texto

- "Matarias" está correto (mataria: grande extensão de mato).
- Grafias padronizadas: "Tekoá", "Tape Porã", "Assembleia", "Bremm".
- Todas as referências são alinhadas à esquerda.

## Em aberto

- As referências usam espaçamento de 1,35 linha e recuo de primeira linha. A NBR
  6023 pede espaçamento simples, sem recuo e com uma linha em branco entre elas.
- As medidas *(estimadas)* em [../ABNT.md](../ABNT.md) podem ser conferidas no
  arquivo original do modelo da UFRGS, se estiver disponível.
- O documento não tem os elementos pré-textuais da NBR 14724 (folha de rosto,
  resumo, sumário, lista de ilustrações). Se forem necessários, o sumário e a
  lista de ilustrações podem ser gerados com `outline()`.
