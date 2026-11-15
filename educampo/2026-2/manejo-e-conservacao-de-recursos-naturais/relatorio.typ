// Reproduz o "Modelo relatório.docx" da disciplina: A4, margens de 1 polegada,
// Inter 11pt, espaçamento 1,25 entre linhas e os logotipos do curso e da UFRGS
// no cabeçalho da primeira página. As medidas vêm dos estilos do documento
// Word. Nas demais páginas, o número fica no alto, à direita, como na ABNT.

#set document(title: "Relatório final de atividades – Manejo e Conservação de Recursos Naturais")

// Caixa de linha com espaçamento `n`: `n` vezes a altura de linha da Inter
// (ascendente 0,96875em + descendente 0,2412em), com o acréscimo abaixo do
// texto, como o LibreOffice o distribui.
#let edges(n) = (top-edge: 0.96875em, bottom-edge: -0.2412em - (n - 1) * 1.2099em)

// Cores do modelo.
#let texto = rgb("#2d3748")
#let verde = rgb("#1a4d2e")
#let fundo-cabecalho = rgb("#f0f7f4")
#let linha-tabela = rgb("#e2e8f0")

// Cabeçalho da primeira página: os logotipos ficam a 0,5in da borda superior,
// com 1,5pt de afastamento, e empurram o corpo do texto para 118pt da borda.
#let logos-top = 37.5pt
#let logos-height = 2.818cm
#let body-top = logos-top + logos-height + 1.5pt

#set page(
  paper: "a4",
  margin: 1in,
  background: context if here().page() == 1 {
    place(top + left, dx: 1in, dy: logos-top, block(
      width: 100% - 2in,
      height: logos-height,
      align(center + bottom, {
        set text(bottom-edge: "baseline")
        box(image("figuras/logo-educampo.png", height: logos-height))
        box(image("figuras/logo-ufrgs.png", height: 2.616cm))
      }),
    ))
  },
  // Conforme a ABNT NBR 14724, o número fica no canto superior direito, a 2cm
  // da borda superior, alinhado à margem direita, em 10pt. A primeira página
  // é contada, mas não numerada.
  foreground: context {
    let n = here().page()
    if n > 1 {
      set text(size: 10pt, fill: black, ..edges(1))
      place(top + right, dx: -1in, dy: 2cm, str(n))
    }
  },
)
#set text(
  lang: "pt",
  region: "br",
  font: "Inter",
  size: 11pt,
  fill: texto,
  hyphenate: false,
  kerning: false,
  ..edges(1.25),
)
// Quebra de linhas como no Word: linha a linha, sem comprimir os espaços.
// O modelo não tem parágrafos de texto corrido; eles ficam separados por 6pt,
// o mesmo espaço que segue os títulos primários.
#set par(
  justify: true,
  linebreaks: "simple",
  justification-limits: (spacing: (min: 100%, max: 1000%), tracking: (min: 0pt, max: 0pt)),
  leading: 0pt,
  spacing: 6pt,
)
// Com `lang: "pt"`, o Typst repetiria o hífen no início da linha seguinte.
#show "-": set text(lang: "en")
// Links ficam em inglês, para que o hífen não se repita na quebra de linha, e
// numa só linha quando cabem nela; os mais longos quebram nas barras.
#show link: set text(lang: "en")
#show link: it => context if measure(it).width <= page.width - 2in { box(it) } else { it }
// Como no modelo, a linha não se quebra depois de uma barra ("área/cercamento").
#show regex("[^\\s/]+/[^\\s/]+"): box
#set block(spacing: 0pt)
// Aspas e apóstrofos são convertidos automaticamente em curvos. Em "Mbaʼe", o
// puso do Guarani é a letra ʼ (U+02BC), que não é apóstrofo e não é convertida.

// Os espaços antes e depois dos títulos não se somam: entre dois parágrafos,
// prevalece o maior, como no LibreOffice.
#set heading(numbering: "1.1.")
#let heading-style(level) = if level == 1 { (size: 14pt, above: 24pt, below: 6pt) } else {
  (size: 12pt, above: 18pt, below: 4pt)
}
#show heading: it => {
  let style = heading-style(it.level)
  // Os títulos primários começam em nova página, exceto o primeiro
  // (Introdução), que segue o cabeçalho da primeira página.
  if it.level == 1 {
    context {
      if it.location() != query(heading.where(level: 1)).first().location() {
        pagebreak(weak: true)
      }
    }
  }
  block(above: style.above, below: style.below, sticky: true, width: 100%, {
    set text(size: style.size, weight: "bold", fill: black, ..edges(1.15))
    if it.numbering != none { counter(heading).display(it.numbering) + " " }
    // Os títulos primários saem em maiúsculas; no código-fonte, ficam com
    // inicial maiúscula, para que os marcadores do PDF sejam legíveis.
    if it.level == 1 { upper(it.body) } else { it.body }
  })
}

// Marcadores: círculo em Arial (Liberation Sans) a 0,25in da margem e texto a
// 0,5in, em preto, como no modelo.
#set list(
  indent: 0.25in,
  body-indent: 0pt,
  marker: box(width: 0.25in, align(start, text(font: "Liberation Sans", fill: black, "●"))),
  spacing: 0pt,
)
#show list: set text(fill: black)

// Tabela: só linhas horizontais, cabeçalho com fundo verde-claro, em negrito e
// 10pt.
#set table(
  stroke: (x: none, y: 1pt + linha-tabela),
  inset: (x: 5.75pt, y: 0pt),
  align: left + horizon,
  fill: (_, y) => if y == 0 { fundo-cabecalho },
)
#show table: set text(fill: black)
#show table: set par(justify: false, first-line-indent: 0pt)
#show table.cell.where(y: 0): set text(size: 10pt, weight: "bold", ..edges(1.25))

// Ilustrações conforme a ABNT (NBR 14724), centralizadas e nas fontes e
// espaçamentos do texto: a legenda vem acima ("Figura 1 – Título", sem ponto
// final, em 11pt), separada da imagem por 6pt; a fonte vem logo abaixo, em
// 10pt e espaçamento simples. Uma linha em branco separa a figura do texto. No
// texto, as figuras são citadas por referência (`@fig-arroio-1`).
#set figure(gap: 6pt)
#set figure.caption(position: top, separator: [ – ])
#show figure: set par(first-line-indent: 0pt, justify: false)
#show figure: it => {
  let linha = 1.25 * 1.2099 * 11pt
  block(above: linha, below: linha, breakable: false, width: 100%, it)
}
#let figura(path, width, titulo, fonte) = figure(kind: image, caption: titulo, {
  image(path, width: width)
  block(above: 6pt, text(size: 10pt, ..edges(1))[Fonte: #fonte.])
})

// Citação longa, conforme a ABNT (NBR 10520 e NBR 14724): recuo de 4 cm, em
// 10pt e espaçamento simples, separada do texto por uma linha em branco do
// espaçamento do texto (1,25).
#let citacao(body) = {
  let linha = 1.25 * 1.2099 * 11pt
  block(above: linha, below: linha, inset: (left: 4cm), {
    set text(size: 10pt, ..edges(1))
    set par(first-line-indent: 0pt)
    body
  })
}

// Na primeira página, o texto começa abaixo dos logotipos.
#v(body-top - 1in)

#block(inset: (top: 24pt), below: 6pt, width: 100%, {
  set align(center)
  set text(size: 18pt, weight: "bold", fill: verde, ..edges(1))
  [RELATÓRIO FINAL DE ATIVIDADES]
})

#align(center)[
  *DISCIPLINA: Manejo e Conservação de Recursos Naturais* \
  *CURSO: Licenciatura em Educação do Campo – Ciências da Natureza* \
  *ESTUDANTE(S):* Alexandre da Cruz, Juliane Nunes Hallal Cabral, \
  Tasso Evangelista Pinto \
  *COMUNIDADE / PROPRIEDADE:* Tekoa Tape Porã (aldeia Guarani Mbya) \
  *MUNICÍPIO/UF:* Guaíba/RS e Barra do Ribeiro/RS \
  *PERÍODO DE REALIZAÇÃO:* novembro de 2026
]

// Daqui em diante, o texto é preto, como o conteúdo do modelo.
#set text(fill: black)
// Recuo de 1,27 cm na primeira linha dos parágrafos, como na ABNT, inclusive
// no primeiro parágrafo depois de um título.
#set par(first-line-indent: (amount: 1.27cm, all: true))

= Introdução

O manejo e a conservação dos recursos naturais são fundamentais para garantir o equilíbrio ambiental e a manutenção da vida no planeta. A utilização desses recursos, como a água, o solo, a vegetação e a biodiversidade, está diretamente relacionada às atividades humanas e ao desenvolvimento econômico e social. Entretanto, a exploração inadequada desses elementos pode provocar impactos ambientais significativos, como desmatamento, erosão do solo, contaminação dos recursos hídricos, perda da biodiversidade e degradação dos ecossistemas.

Segundo Prado, Turetta e Andrade (2010, p. 27):

#citacao[
  Para evitar esta degradação é necessário planejar as atividades de produção agropecuária de acordo com a aptidão agrícola das terras, manejando o solo de acordo com suas fragilidades e potencialidades. Através de dados provenientes das mais diversas fontes do meio físico e biótico e de sistemas de informação capazes de integrar estes dados, é possível separar a paisagem em zonas, possibilitando planejar adequadamente o uso, a conservação e a recuperação das terras.
]

Este relatório tem como objetivo abordar a importância do manejo e da conservação dos recursos naturais e compreender a relação entre as atividades humanas e o meio ambiente, reconhecendo a necessidade de promover o uso consciente dos recursos naturais, de modo a assegurar sua disponibilidade e qualidade para as atuais e futuras gerações. Para tanto, realizou-se a análise de uma propriedade localizada na região inventariada por estudantes do curso de Licenciatura em Educação do Campo; os resultados dessa análise são apresentados a seguir.

= Caracterização da propriedade

== Apresentação da Propriedade

Ocupadas por uma comunidade indígena Guarani Mbya, as terras onde se situa a Tekoa Tape Porã foram adquiridas a partir do ano de 2021 por meio de medidas de compensação dos impactos socioambientais decorrentes da duplicação da BR-116. Conforme documentação da Funai de abril de 2025, a área encontra-se na fase administrativa de constituição de Reserva Indígena.

A área possui 157 hectares e está situada na bacia do Lago Guaíba (RIO GRANDE DO SUL, 2020), na transição entre os municípios de Guaíba e Barra do Ribeiro. A região apresenta características rurais, possuindo fragmentos de vegetação nativa (Mata Atlântica e Pampa), assim como áreas abertas e vias de acesso local.

Sob o ponto de vista geomorfológico, o setor insere-se na faixa de transição entre as terras baixas sedimentares da Depressão Central e os terrenos cristalinos do Escudo Sul-Rio-Grandense (RIO GRANDE DO SUL, 2021). O território caracteriza-se por um relevo levemente ondulado e constituído por coxilhas, drenado pelo Arroio Capivara e com altitude de aproximadamente 170 a 190 metros acima do nível do mar. A paisagem apresenta uso predominantemente voltado à atividade de horticultura tradicional e diversificada, com milho, batata-doce, feijão, mandioca e melancia, sempre respeitando o ciclo da natureza, seguindo a cultura Guarani. A área faz limites com outros lotes que cultivam batata-doce, milho, arroz e silvicultura de produção (eucaliptos para a indústria de celulose).

#figura(
  "figuras/01-mapa-guarani-digital.png",
  15.13cm,
  [Localização da Tekoa Tape Porã (coordenadas -30.2518, -51.4255)],
  [Mapa Guarani Digital (2026)],
) <fig-mapa>

#figura(
  "figuras/02-google-earth.png",
  15.58cm,
  [Vista aérea da Tekoa Tape Porã],
  [Google Earth (2026)],
) <fig-vista-aerea>

== Histórico da Paisagem

Previamente à desocupação da Fazenda Cabanha Figueira, executada no âmbito do Subprograma Fundiário do Plano Básico Ambiental (PBA) — instrumento pelo qual o Departamento Nacional de Infraestrutura de Transportes (DNIT) destinou a área às comunidades Guarani Mbya —, a propriedade era utilizada para a pecuária de corte e leite. Tal atividade possivelmente impulsionou alterações no uso e na ocupação do solo, uma vez que a expansão das áreas de pastagem e o cultivo de grãos destinados à produção de ração fomentam o desmatamento e comprometem ciclos biogeoquímicos essenciais à manutenção dos ecossistemas. Adicionalmente, o pisoteio contínuo do rebanho promove a compactação da camada superficial do solo, o que reduz a taxa de infiltração hídrica pluvial e intensifica a suscetibilidade à erosão e à lixiviação de nutrientes.

A expressiva presença da silvicultura comercial no entorno imediato legitima e potencializa o papel estratégico do Viveiro Mbya Mbaʼe. Nesse contexto, o zoneamento interno da aldeia atua como uma verdadeira "ilha de biodiversidade" (MACARTHUR; WILSON, 1967), dedicada exclusivamente à propagação e reintrodução de espécies nativas dos biomas Mata Atlântica e Pampa. Essa iniciativa funciona como um mecanismo de mitigação e equilíbrio ecológico, fundamental para contrabalançar os impactos.

= Diagnóstico dos recursos hídricos , vegetação e fauna

== Avaliação de Nascente(s), vegetação e fauna associada

Não foram encontradas nascentes, porém a área é cortada no sentido leste-oeste pelo Arroio Capivara, de perfil sinuoso, rural e perene. O arroio passa por áreas rurais e segue em direção a sistemas locais, atuando como afluente do Arroio Ribeiro, que deságua no Lago Guaíba. Todo seu curso, dentro do perímetro da aldeia, é contornado por uma densa vegetação nativa preservada (mata ciliar) que desempenha a função de barreira de proteção física e ecológica ao arroio. Apesar de densa, a vegetação ciliar é de estágio sucessional secundário, sendo as espécies arbóreas predominantes consideradas pioneiras, de estágio sucessional avançado, com dossel praticamente fechado e estruturado em camadas com múltiplos estratos, apresentando DAP (diâmetro à altura do peito) entre 14 e 20 cm (BRASIL, 1994). As espécies predominantes identificadas foram o cocão (_Erythroxylum deciduum_), o pinheiro-bravo (_Podocarpus lambertii_), o açoita-cavalo (_Luehea divaricata_), o chá-de-bugre (_Casearia sylvestris_), espécies de aroeira (_Schinus_ spp.), chal-chal (_Allophylus edulis_), jerivá (_Syagrus romanzoffiana_), o caquizinho-do-mato (_Diospyros inconstans_) e a erva-mate-brava (_Ilex_ sp.).

A comunidade é lindeira de um grande cultivo intensivo de espécies vegetais exóticas (eucalipto) destinado à produção de celulose para a indústria CMPC, localizada na sede do município de Guaíba. No momento de nossa visita, o corte de eucaliptos estava em curso, e pudemos inclusive verificar a presença de agentes da CMPC na área da comunidade e o trabalho de uma patrola dentro da aldeia alargando uma das vias internas que seria utilizada para o escoamento das toras de eucalipto cortadas na coxilha acima da comunidade.

Há dois açudes no território (Figuras #ref(<fig-acude-menor>, supplement: none) e #ref(<fig-acude-maior>, supplement: none)), porém não foram encontradas maiores informações referentes a esses corpos d’água. Esses passam por um processo de sucessão ecológica natural, possivelmente acelerado pela eutrofização, e funcionam como um ecossistema de transição (banhado), abrigando uma biodiversidade própria de produtores, consumidores primários, secundários, terciários e decompositores. Foram vistas espécies de aves de banhado como a garça pequena (_Egretta thula_) e o maçarico do banhado (_Phimosus infuscatus_), além de uma ave que não foi possível identificar com certeza, a galinhola (_Gallinula galeata_) ou a jaçanã (_Jacana jacana_).

Através de uma oficina realizada com as crianças e jovens da escola Arasaty, que é a escola na comunidade Tape Porã, eles relataram a presença de alguns animais, que foram desenhados em um mapa que representa o território de vida da comunidade. Os animais representados foram o tatu, o bugio-ruivo, a onça (provavelmente jaguatirica), a lebre, lagarto, tartarugas e peixes.

== Análise da Qualidade da Água (Tempo Comunidade)

#table(
  columns: (auto, 1fr, auto, 1fr, 1.5cm),
  align: center + horizon,
  table.header[Amostra][Fonte][Tipo de Ambiente][Aspecto Organoléptico][pH],
  [arroio-01], [Arroio Capivara (@fig-arroio-1)], [Rural], [Cristalino / sem odor], [5,5],
  [arroio-02], [Arroio Capivara (@fig-arroio-2)], [Rural], [Cristalino / sem odor], [5,5],
  [açude-01], [Açude (@fig-acude-menor)], [Rural], [Turvo / odor acentuado], [-],
  [açude-02], [Açude (@fig-acude-maior)], [Rural], [Turvo / odor moderado], [-],
)

// Resultados do teste de pH (fita indicadora).
// Resultados do teste de turbidez (visual).

= Diagnóstico do solo e relação solo-clima

== Caracterização Físico-Química do Solo

A análise foi realizada em área preparada para o cultivo de milho.

A matriz do solo exibe predomínio de partículas grosseiras (areia grossa e pedriscos), conferindo macroporosidade, sugerindo uma drenagem rápida e baixa capacidade de retenção de água disponível.

#figura(
  "figuras/03-solo-lavoura-de-milho.jpg",
  15.69cm,
  [Solo da área preparada para o cultivo de milho],
  [Os autores (2026)],
) <fig-solo>

A tonalidade bruno-clara a pálida observada na camada superficial evidencia o baixo teor de agentes pigmentantes, como a matéria orgânica humificada e os óxidos de ferro, deixando predominar a coloração da matriz quartzosa (KÄMPF; CURI, 2012; SANTOS et al., 2015).

Sob o ponto de vista físico-químico, a escassez de coloides orgânicos e argilominerais resulta em reduzida Capacidade de Troca Catiônica (CTC), limitando a retenção de nutrientes trocáveis e tornando o sistema altamente suscetível à lixiviação (MEURER, 2017; BRADY; WEIL, 2013).

= Plano integrado de manejo e conservação (propostas práticas)

== Ações para Conservação da Água e Nascentes

Na cosmovisão do povo Guarani, a água é considerada como princípio vital, uma entidade viva que conecta o mundo físico ao espiritual; portanto, a prática de preservação das matas ciliares é uma condição indissociável para a sobrevivência de sua cultura, de sua espiritualidade e do seu modo de ser. Dada essa importância e pelo fato de a comunidade já possuir um viveiro de espécies nativas, sugere-se o planejamento de plantios ao longo das margens dos corpos d'água para que haja reforço nas matas ciliares já existentes, podendo inclusive haver a inserção de espécies frutíferas nativas, que poderão auxiliar na manutenção da avifauna nativa e servir de recurso alimentar para a comunidade. Uma espécie-chave que poderia ser reintroduzida nessa localidade é a palmeira juçara (_Euterpe edulis_), nativa da Mata Atlântica e ancestralmente encontrada na região, mas que, atualmente, encontra-se muito rarefeita em função do corte seletivo. Dos frutos da juçara extrai-se um vinho semelhante em aspecto e composição nutricional ao açaí da Amazônia, _Euterpe oleracea_, com alto potencial alimentar e comercial, podendo vir a ser uma fonte de renda para a comunidade.

Outra espécie-chave que poderia ser reforçada seria a erva-mate (_Ilex paraguariensis_) que é encontrada na forma nativa na região, assim como outras espécies de _Ilex_, e que tem grande importância cultural para os Guarani. Sugere-se a incorporação dessa espécie às matas já existentes, podendo as mudas também ser feitas no viveiro da comunidade. Existe a possibilidade de coleta de sementes dessa espécie diretamente nas matas da região. Nas aldeias Guarani Água Grande (tekoa Kaʼa Mirindy) e Bonito (tekoa Yvyʼâ Poty), em Camaquã (RS), a coleta e processamento de erva-mate tornou-se, inclusive, uma atividade de geração de renda para essas comunidades.

Por último, sugere-se realizar um plantio de árvores de crescimento rápido junto à faixa lindeira aos plantios de eucalipto, nas bordas da aldeia, para que essa sirva de barreira ecológica e proteção à aldeia.

== Ações para Conservação e Recuperação do Solo

O preparo da terra e seu manejo, praticados pelas comunidades Guarani Mbya, fundamentam-se na racionalidade ecológica do sistema de agricultura itinerante, com cultivo em pequenas clareiras abertas na mata, sem uso de agrotóxicos ou fertilizantes químicos. Após alguns ciclos de cultivo, a área entra em período de descanso (pousio) para que a vegetação secundária (_capoeira_) regenere a fertilidade natural do solo.

Nesse modelo produtivo, dispensa-se integralmente o emprego de insumos químicos sintéticos, tais como fertilizantes minerais solúveis e agrotóxicos. A disponibilização inicial de nutrientes para as culturas anuais ocorre mediante a incorporação da biomassa vegetal proveniente da limpeza seletiva da área, o que promove a ciclagem biogeoquímica natural e mantém a atividade microbiológica e a estrutura física do solo.

Na propriedade encontram-se alguns locais com preparação de solo utilizando-se mecanização agrícola. Para esses locais, além do pousio, recomenda-se a rotação de culturas, assim como a adoção do cultivo de plantas adubadoras para auxiliar na recuperação do solo no período de descanso, proporcionando sua rápida cobertura e, assim, evitando perdas por erosão e lixiviação.

O Viveiro Mbya Mbaʼe na comunidade é um espaço importante para o manejo ecológico, pois permite relacionar a produção de mudas e a conservação da biodiversidade, contribuindo para a recuperação da vegetação nativa e para a proteção do solo e da água.

== Articulação Teoria-Prática

O conhecimento tradicional da aldeia reúne experiências, práticas e saberes construídos ao longo das gerações sobre as plantas, a floresta, a alimentação e o território, o que possibilita relacioná-lo ao conhecimento científico aprendido em aula, compreendendo a importância das propriedades físicas, químicas e biológicas do solo para o desenvolvimento das plantas, assim como o ciclo da água para a irrigação e conservação dos recursos hídricos.

= Registros fotográficos e anexos

#figura("figuras/04-arroio-capivara.jpg", 13.81cm, [Arroio Capivara], [Os autores (2026)]) <fig-arroio-1>

#figura("figuras/05-arroio-capivara.jpg", 13.81cm, [Arroio Capivara], [Os autores (2026)]) <fig-arroio-2>

#figura("figuras/06-acude-menor.jpg", 13.81cm, [Açude menor], [Os autores (2026)]) <fig-acude-menor>

#figura("figuras/07-acude-maior.jpg", 13.68cm, [Açude maior], [Os autores (2026)]) <fig-acude-maior>

#figura("figuras/08-lavoura-de-milho.jpg", 13.71cm, [Lavoura preparada para o plantio de milho], [Os autores (2026)]) <fig-lavoura>

#figura("figuras/09-analise-das-amostras-de-agua.png", 14.11cm, [Análise das amostras d'água], [Os autores (2026)]) <fig-analise-agua>

= Síntese final e aprendizagens da alternância

A integração entre o Tempo Escola e o Tempo Comunidade possibilitou relacionar os conhecimentos teóricos desenvolvidos em sala de aula às experiências vivenciadas nos territórios e nas comunidades. Nesse contexto, a comunidade Tekoa Tape Porã constitui uma referência para a compreensão da conservação ambiental, do manejo ecológico e da valorização dos conhecimentos tradicionais indígenas. A vivência permitiu conhecer as relações entre a vegetação, os recursos naturais e as práticas desenvolvidas pela comunidade, evidenciando a importância dos saberes tradicionais para a conservação do território.

Além dos aspectos ambientais, o Viveiro Mbya Mbaʼe apresenta relevância social, educativa e cultural, pois contribui para a transmissão de conhecimentos entre gerações e fortalece a relação da comunidade com o território. Dessa forma, constitui um espaço de aprendizagem e intercâmbio entre os conhecimentos tradicionais Guarani e os conhecimentos científicos, favorecendo a reflexão sobre práticas de manejo sustentável, a conservação da biodiversidade e a valorização da cultura indígena.

#heading(numbering: none)[Referências]

// As referências não têm recuo.
#set par(justify: false, first-line-indent: 0pt)

BRADY, N. C.; WEIL, R. R. *Elementos da natureza e propriedades dos solos*. 3.~ed. Porto Alegre: Bookman, 2013.

BRASIL. Conselho Nacional do Meio Ambiente. Resolução nº 33, de 7 de dezembro de 1994. Define estágios sucessionais das formações vegetais que ocorrem na região de Mata Atlântica do Estado do Rio Grande do Sul. *Diário Oficial da União*: seção 1, Brasília, DF, n. 248, p. 21352-21353, 30 dez. 1994.

GOOGLE EARTH. [Vista aérea da Tekoa Tape Porã]. [S. l.]: Google, 2026. Imagem de satélite. Disponível em: https://earth.google.com/. Acesso em: 9 nov. 2026.

KÄMPF, N.; CURI, N. Formação e evolução do solo (Pedogênese). In: KER, J. C. et al. (ed.). *Pedologia: Fundamentos*. Viçosa, MG: Sociedade Brasileira de Ciência do Solo, 2012. p. 207-302.

MACARTHUR, R. H.; WILSON, E. O. *The Theory of Island Biogeography*. Princeton, NJ: Princeton University Press, 1967.

MAPA GUARANI DIGITAL. [S. l.], [2026]. Disponível em: https://guarani.map.as/. Acesso em: 11 nov. 2026.

MEURER, E. J. (org.). *Fundamentos de química do solo*. 6.~ed. Porto Alegre: Evangraf, 2017. 290 p.

PRADO, R. B.; TURETTA, A. P. D.; ANDRADE, A. G. de (org.). *Manejo e conservação do solo e da água no contexto das mudanças ambientais*. Rio de Janeiro: Embrapa Solos, 2010. 486 p. ISBN 978-85-85864-32-3.

RIO GRANDE DO SUL. Secretaria de Planejamento, Governança e Gestão. *Atlas socioeconômico do Rio Grande do Sul*: hipsometria e unidades geomorfológicas. 6.~ed. Porto Alegre: SPGG, 2021. Disponível em: https://atlassocioeconomico.rs.gov.br. Acesso em: 9 nov. 2026.

RIO GRANDE DO SUL. Secretaria do Meio Ambiente e Infraestrutura. Departamento de Gestão de Recursos Hídricos e Saneamento. *Nota Técnica nº 002/2020/DIPLA/DRHS*: inserção de municípios e bacias hidrográficas no Estado do Rio Grande do Sul. Porto Alegre: SEMA, 7 ago. 2020. Disponível em: https://sema.rs.gov.br/upload/arquivos/202108/23155725-nt-dipla-2020-002-municipios-e-bacias.pdf. Acesso em: 14 nov. 2026.

SANTOS, R. D. dos et al. *Manual de descrição e coleta de solo no campo*. 7.~ed. Viçosa, MG: Sociedade Brasileira de Ciência do Solo, 2015. 101 p.
