// Formatação conforme o modelo de trabalho acadêmico da UFRGS (ABNT NBR 14724):
// Arial (por meio da Liberation Sans, de métricas compatíveis), 12pt,
// espaçamento 1,5 entre linhas e texto justificado. As convenções estão
// descritas em ../ABNT.md; as decisões deste documento, em README.md.

#let authors = (
  "Alan Dhoni Garcia do Nascimento",
  "Alexandre da Cruz",
  "Juliane Nunes Hallal Cabral",
  "Tasso Evangelista Pinto",
)

#set document(
  title: "Inventário da Realidade no território compartilhado de Guaíba, Mariana Pimentel e Barra do Ribeiro",
  author: authors,
)

// Caixa de linha com espaçamento `n`: `n` vezes a altura de linha da fonte
// (ascendente + descendente + entrelinha), com o texto apoiado na base.
#let edges(n) = (top-edge: n * 1.1499em - 0.212em, bottom-edge: -0.212em)
// Margens da ABNT NBR 14724.
#let margins = (left: 30mm, right: 20mm, top: 30mm, bottom: 20mm)
// Distância entre a margem superior e o início do corpo do texto.
#let header-height = 4.2mm
#let margin-left = margins.left
#let margin-top = margins.top + header-height
#let pitch = 1.5 * 1.1499 * 12pt

#set page(
  paper: "a4",
  margin: (..margins, top: margin-top),
  // Conforme a ABNT NBR 14724, a capa não é contada nem numerada; o número
  // fica no canto superior direito, a 2cm da borda superior.
  foreground: context {
    let n = here().page() - 1
    if n > 0 {
      set text(size: 10pt, ..edges(1))
      place(top + right, dx: -margins.right, dy: 20mm, str(n))
    }
  },
)
#set text(lang: "pt", region: "br", font: "Liberation Sans", size: 12pt, hyphenate: false, kerning: false, overhang: false, ..edges(1.5))
#set par(
  justify: true,
  leading: 0pt,
  spacing: 0pt,
  first-line-indent: (amount: 36pt, all: true),
)
#set block(spacing: 0pt)
#set smartquote(enabled: false)

#let blank(n) = v(n * pitch, weak: true)
// Coordenadas absolutas, dadas como números sem unidade, em pontos.
#let pt(value) = if type(value) == length { value } else { value * 1pt }
#let noindent(body) = par(first-line-indent: 0pt, body)
#let indent(amount) = (amount: amount, all: true)

// Posicionamento absoluto, em coordenadas da página: `x` é a borda esquerda e
// `bottom`, a base da caixa da primeira linha.
#let at(x, bottom, body, size: 12pt, spacing: 1.5, width: auto, justify: true) = {
  let y = pt(bottom) - spacing * 1.1499 * size
  let width = if type(width) in (int, float) { pt(width) } else { width }
  place(top + left, dx: pt(x) - margin-left, dy: y - margin-top, block(width: width, {
    set text(size: size, ..edges(spacing))
    set par(first-line-indent: 0pt, justify: justify)
    body
  }))
}

// Ancora no fluxo do texto um trecho posicionado em coordenadas da página: o
// trecho entre `top` e `bottom` passa a ocupar esse espaço onde o fluxo estiver.
#let anchored(top, bottom, body) = block(
  width: 100%,
  height: pt(bottom - top),
  move(dy: margin-top - pt(top), body),
)
#let centered(bottom, body, size: 12pt) = at(
  margin-left, bottom, size: size, width: 100%,
  align(center, body),
)
#let hline(x0, x1, y, thickness) = place(
  top + left, dx: pt(x0) - margin-left, dy: pt(y) - margin-top,
  rect(width: pt(x1 - x0), height: thickness, fill: black, stroke: none),
)
#let vline(x, y0, y1, thickness) = place(
  top + left, dx: pt(x) - margin-left, dy: pt(y0) - margin-top,
  rect(width: thickness, height: pt(y1 - y0), fill: black, stroke: none),
)

#set heading(numbering: "1.1")
#show heading: set text(size: 12pt)
// Título de seção primária, conforme o modelo da UFRGS: começa em nova página,
// em negrito e maiúsculas, com o indicativo numérico alinhado à margem esquerda,
// e é separado do texto que o sucede por uma linha em branco de espaçamento 1,5.
#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  block(below: pitch, par(
    first-line-indent: 0pt,
    hanging-indent: 6.3mm,
    justify: false,
    strong[#box(width: 6.3mm, counter(heading).display(it.numbering))#upper(it.body)],
  ))
}
// Título de seção secundária: em maiúsculas, sem negrito, com o indicativo
// numérico alinhado à margem esquerda, e separado do texto que o precede e do
// que o sucede por uma linha em branco de espaçamento 1,5.
#show heading.where(level: 2): set text(weight: "regular")
#show heading.where(level: 2): it => block(above: pitch, below: pitch, par(
  first-line-indent: 0pt,
  hanging-indent: 10mm,
  justify: false,
  [#box(width: 10mm, counter(heading).display(it.numbering))#upper(it.body)],
))
// Título de seção terciária: em negrito, com o indicativo numérico alinhado à
// margem esquerda, e separado do texto que o precede e do que o sucede por uma
// linha em branco de espaçamento 1,5.
#show heading.where(level: 3): it => block(above: pitch, below: pitch, par(
  first-line-indent: 0pt,
  hanging-indent: 12.5mm,
  justify: false,
  [#box(width: 12.5mm, counter(heading).display(it.numbering))#it.body],
))
// Ilustrações, conforme o modelo: a legenda vem acima ("Figura 1 – Título"), em
// espaçamento 1,5 e com as linhas seguintes alinhadas depois do travessão; a
// fonte vem logo abaixo, em 10pt e espaçamento simples. Uma linha em branco
// separa a ilustração do texto.
#set figure(gap: 6pt)
#set figure.caption(position: top)
#show figure: set align(left)
#show figure: it => block(above: pitch, below: pitch, it)
#show figure.caption: it => context {
  let prefix = [#it.supplement #it.counter.display(it.numbering) – ]
  par(first-line-indent: 0pt, hanging-indent: measure(prefix).width, prefix + it.body)
}
#let illustration(caption, body, source: none, kind: image, supplement: auto) = figure(
  kind: kind,
  supplement: supplement,
  caption: caption,
  {
    body
    if source != none {
      set text(size: 10pt, ..edges(1))
      noindent[Fonte: #source.]
    }
  },
)
#let photo(name, width, height: auto) = block(
  image("figuras/" + name + ".jpg", width: width, height: height, fit: "stretch"),
)
#let item(marker, body, left: 54pt) = pad(left: left, par(first-line-indent: 0pt, hanging-indent: 18pt)[#box(width: 18pt, marker)#body])
// Em português, o hífen se repete no início da linha seguinte quando a quebra
// cai nele; num endereço, isso o alteraria.
#show link: set text(lang: "en")
#let url(target) = link(target, text(fill: rgb("#1155cc"), underline(offset: 1.8pt, stroke: 0.86pt, target)))

// Capa

#centered(117.7)[Universidade Federal do Rio Grande do Sul]
#centered(138.5)[Faculdade de Educação]
#centered(159.1)[Licenciatura em Educação do Campo – Ciências da Natureza]
#centered(179.9)[Núcleo Eldorado do Sul]
#for (i, author) in authors.enumerate() {
  centered(324.8 + i * 20.7, author)
}

#centered(534.0, size: 14pt, strong[Inventário da Realidade no território compartilhado de Guaíba,#h(1.3pt)])
#centered(558.1, size: 14pt, strong[Mariana Pimentel e Barra do Ribeiro])
#centered(745.8)[Eldorado do Sul]
#centered(766.4)[2026]

= Introdução

Um inventário da realidade é uma ferramenta metodológica utilizada para o
levantamento e registro organizado de aspectos materiais ou imateriais de uma
determinada localidade ou comunidade. No contexto da Educação do Campo, ele é
definido como um diagnóstico etnográfico preciso e detalhado da realidade onde as
escolas estão inseridas. Sua construção busca proporcionar aos profissionais da
educação um conhecimento profundo sobre o ambiente, a história e a vida social dos
estudantes e de suas famílias; serve como base para a criação de “complexos de
estudo”, que são unidades curriculares interdisciplinares desenvolvidas a partir de
porções da realidade local, garantindo que o ensino esteja conectado com a vida
prática e as lutas da comunidade.

Como atividade, o processo de construção envolve pesquisas, entrevistas e
visitas de campo; como produto, ele se torna uma ferramenta de trabalho essencial
para que a escola materialize sua ligação com as relações sociais das quais faz parte.
A elaboração exige um trabalho coletivo e permanente, envolvendo professores,
estudantes, pais, lideranças e demais moradores, o que fortalece os vínculos entre a
escola e a comunidade.

De acordo com o guia metodológico utilizado por escolas do campo, o
inventário é geralmente organizado em sete blocos temáticos:

#item[a)][Recursos Naturais: Identificação da biodiversidade, vegetação, relevo e
fontes de água.]
#item[b)][Pessoas e Famílias: Características sociais, econômicas, culturais e
composições familiares.]
#item[c)][Produção: Sistemas produtivos (cultivos e criação de animais) e uso de
tecnologias.]
#item[d)][Mundo do Trabalho: Formas de organização do trabalho (familiar,
cooperativo ou assalariado).]
#item[e)][Organização Sociopolítica: Lutas sociais, movimentos, igrejas e
sindicatos presentes na região.]
#item[f)][Escolas: Análise da estrutura física, organização docente e aspectos
curriculares.]
#item[g)][Tempo livre: Atividades de crianças e jovens no período em que não
estão na escola.]

A partir da exploração iniciada no semestre anterior, ampliamos nosso olhar
para além da aldeia Mbyá Guarani Tape Porã e da EEIEF Arasaty para
contemplar o território compartilhado entre os municípios de Guaíba, Barra do Ribeiro
e Mariana Pimentel. A inclusão dessa área se deu pela presença de outras
comunidades Mbyá e pela familiaridade de alguns integrantes desse grupo de estudos
com a região da Serrinha, parte deste território, e suas escolas. Foi nesse movimento
que encontramos a colega Juliane, que já cruzava o mesmo território a partir das terras
altas de Guaíba e de Mariana Pimentel. Vinda do inventário da EMEF São Paulo, e
movida pelo desejo de compreender esse entorno comum às nossas escolas, ela se
juntou a nós nessa caminhada.

Mas porque estamos chamando essas localidades de “território
compartilhado”? A vasta região onde se formou a “Freguesia das Pedras Brancas de
Nossa Senhora do Livramento’ — Guaíba — até meados do século XVIII fazia parte
do amplo território conhecido como Brasil Meridional, cujos limites ainda não estavam
bem definidos pelas Coroas Ibéricas (Laroque, 2002). Registros oficiais começam a
surgir em 1780, quando a Coroa portuguesa concedeu extensas sesmarias. A área
que nos interessa passou às mãos de diversos sesmeiros, conforme os mapas (Figuras #ref(<fig-sesmeiros>, supplement: none) e #ref(<fig-limites>, supplement: none)). A região hoje dividida entre os municípios de Guaíba, Eldorado do Sul, Barra do
Ribeiro, Mariana Pimentel e Sertão Santana integrava esse grande bloco de terras
chamado Pedras Brancas. Ondas de migração, incentivadas pelo imperador D. Pedro
II, trouxeram tempos depois imigrantes poloneses e alemães, os primeiros a chegar.
Nessa época já se observa a sobreposição da ocupação imigrante sobre as terras dos
guaranis originários, que foram gradualmente perdendo suas terras ancestrais. Ao
observar esses mapas, percebe-se que a região permaneceu como uma mesma
unidade política até o fim da década de 1950, sendo que a maior parte das
emancipações ocorreram a partir da década de 1980, o que explica, em parte, a
profunda relação entre os territórios que hoje constituem seis municípios. Além disso,
é comum os moradores dessa região utilizarem serviços e recursos de mais de um
município — muitas vezes diariamente — para reproduzir seus modos de vida, devido
à característica fronteiriça do território.

Geograficamente, podemos considerar que o território analisado faz parte da
Costa Doce Gaúcha, uma região do estado do Rio Grande do Sul que abrange os
municípios situados ao longo da margem oeste da Lagoa dos Patos e do Lago Guaíba,
caracterizada pelo encontro de ecossistemas campestres e florestais (Mata Atlântica
e Pampa), possuindo importância histórica e cultural singular, sendo habitada
milenarmente pelos Mbyás.

#illustration(
  [Mapa feito pela turma do 6º. Ano da EMEF São Paulo, referenciando a aldeia Guarani com a qual compartilha o território rural de Guaíba, junho/2026],
  photo("01-mapa-da-aldeia", 453.65pt),
  source: [Cabral (2026)],
)

#illustration(
  [Localização dos primeiros sesmeiros do Território],
  photo("02-mapa-dos-sesmeiros", 90% * 258.44pt, height: 90% * 307.3pt),
  source: [Silva (2008)],
) <fig-sesmeiros>

#illustration(
  [Limites do município de Guaíba],
  photo("03-limites-de-guaiba", 90% * 256.6pt),
  source: [Prefeitura Municipal de Guaíba (2002)],
) <fig-limites>

Na última década, a região da Costa Doce ganhou destaque em estudos
socioambientais devido às obras de duplicação da rodovia BR-116, no trecho entre
Guaíba e Pelotas. Como medida de compensação socioambiental, o processo
permitiu a aquisição de mais de 800 hectares de terras para o estabelecimento de
novas aldeias Guarani e a recomposição de matas nativas na região, buscando mitigar
o histórico de expropriação territorial sofrido por esses povos.

A CMPC, fabricante chilena de celulose, está à frente do “Projeto Natureza”,
considerado o maior investimento privado já previsto para o Rio Grande do Sul, com
um aporte de R\$ 27 bilhões. Apesar da importância econômica, o projeto enfrenta um
conflito jurídico significativo relacionado aos direitos dos povos originários da região,
onde se alega a falta de consulta prévia às comunidades Mbyá enquanto a Funai
relata que líderes das aldeias supostamente afetadas se manifestaram de forma
favorável à continuidade do licenciamento.

= Panorama Mbyá Guarani

No estado do Rio Grande do Sul havia a presença de três grandes grupos
indígenas: Guaranis, Pampeanos e Ges. Antes mesmo da chegada dos europeus,
esses grupos indígenas empreenderam movimentos migratórios característicos de
seu modo de vida seminômade. Os guaranis ocupavam as margens da Lagoa dos
Patos e o litoral norte do estado, as bacias do rio Jacuí e Ibicuí, incluindo a região dos
Sete povos das Missões. Os Pampeanos constituíam um conjunto de tribos que
ocupavam o Sul do estado e o Sudoeste. Os Gês eram os mais antigos habitantes da
banda oriental do Uruguai.

Estes grupos humanos foram dizimados pelos colonizadores portugueses,
espanhóis e, posteriormente, bandeirantes e imigrantes ítalo-germânicos. No século
XVIII o Rio Grande do Sul passou a ser mais disputado entre espanhóis e
portugueses, o que contribuiu para que estas populações sofressem ainda mais
resultando em violenta redução demográfica. Antes do começo da conquista através
da força das terras pertencentes aos Guaranis estima-se que viviam no Sul do Brasil
em regiões que hoje conhecemos como Bacia Hidrográfica do Lago Guaíba, cerca de
250 mil índios (Brandão, 1990, p.54). Alguns antropólogos discordam e chegam a
calcular seis vezes este número.

A dinâmica populacional e os processos migratórios foram estratégias
fundamentais para a sobrevivência e preservação da cultura Guarani frente às
perseguições coloniais e dos bandeirantes. Atualmente, estima-se que essa
população some cerca de 283 mil pessoas distribuídas entre Brasil, Bolívia, Paraguai
e Argentina, demonstrando uma extraordinária capacidade de resistência e
crescimento. No entanto, esse aumento populacional ocorre em um contexto de falta
de investimentos públicos básicos em saúde, educação e habitação, inserindo o povo
Guarani em um cenário de vulnerabilidade social e pobreza.

Os Mbyás são uma das subdivisões (parcialidades) da etnia Guarani. Em
população, são o menor grupo (cerca de 8 mil indivíduos) quando comparados aos
Kaiowá (43,4 mil) e Ñandeva (8,5 mil). Distribuem-se nas regiões litorâneas do estado
do Espírito Santo até o Rio Grande do Sul. Acredita-se que os Mbyás contemporâneos
não sejam descendentes dos povos das Missões, mas formados pelas aldeias das
vizinhanças das ruínas missioneiras. As principais correntes migratórias originaram-se quase exclusivamente da Argentina a partir da década de 1960 (Laroque, 2002).
Dentro da cosmovisão Mbyá, os deslocamentos constantes entre aldeias não se
justificam apenas pelo modelo econômico das comunidades, mas também pela busca
da _Yvy Marã E'ỹ_, a “Terra sem Males”.

Segundo Vietta (1992), a estrutura habitacional das aldeias (_tekoá_) Mbyá é
ditada pela quantidade de casais, diferindo-se a residência maior que abriga o chefe
da família, sua mulher, seus filhos solteiros e eventuais filhas viúvas ou separadas
com seus filhos. Os casamentos idealmente ocorrem entre homens de 15 a 16 anos
e mulheres de 12 a 13 anos que não tenham o mesmo parentesco, o que é outro fator
que contribui para a prática de visitas e migrações a outras aldeias; entretanto, era
comum nas primeiras ocupações deste território aqui relatado que os núcleos
monogâmicos tivessem uma diferença significativa de idade entre marido e mulher.
As três atividades que formam a base da economia de uma aldeia Mbyá são a
horticultura, a criação de animais e o comércio de artesanato, complementando-se
com as atividades de subsistência como a caça, a pesca e a coleta e o emprego de
mão-de-obra como diarista ou por empreitada (Laroque, 2002).

Segundo dados do Instituto Brasileiro de Geografia e Estatística (IBGE), no ano
de 2022, Guaíba tinha 94 indígenas da etnia Guarani, Eldorado do Sul 58, Mariana
Pimentel 79 e, Barra do Ribeiro 263 é o maior município da região em número de
indígenas, de acordo com o censo. A região é a que possui mais escolas indígenas
no Rio Grande do Sul, segundo o mesmo levantamento. (Repórter Guaibense,
2023; Instituto Brasileiro de Geografia e Estatística, 2022).

Convidamos o prof. Valdivino Rodrigues da Silva, renomado pesquisador,
escritor e historiador da região, com inúmeras publicações e artigos, a contribuir com
as suas percepções e conhecimentos acerca da historicidade e realidade dos sujeitos
envolvidos nos processos de ocupação e colonização da região. Estas percepções
nos ajudaram a entender como estes sujeitos afetaram e interferiram diretamente no
desenvolvimento e na historicidade destes povos originários (autóctones),
principalmente em aspectos relativos à sua cultura, demografia e preservação como
grupo humano e social (Apêndice A).

= Recursos naturais

O relevo da região é predominantemente plano e suavemente ondulado,
caracterizado pela transição entre o Escudo Sul-rio-grandense (com áreas de morros
e colinas) e a Depressão Central. Junto às margens do Lago Guaíba, destacam-se
extensas planícies costeiras e áreas de baixada altamente suscetíveis a variações de
nível hídrico. O município apresenta um mosaico de unidades geomorfológicas que
inclui:

#item[a)][_Planícies e Depressões._ Encontradas próximas ao nível do mar e ao
longo das margens do corpo d'água, onde o escoamento é mais lento e
a altitude no centro da cidade não ultrapassa os 50 metros.]
#item[b)][_Relevo ondulado a colinoso._ Áreas de transição que se elevam
suavemente em direção aos municípios vizinhos (como Mariana
Pimentel), formando terrenos de embasamento cristalino e rochas
sedimentares.]

O perfil de solo é predominantemente formado por solos argilosos profundos e
bem drenados sobre formações cristalinas. A região também é marcada por
sedimentos fluviais, sendo muito suscetível à variação do lençol freático e à
vulnerabilidade hídrica. O solo local é originado principalmente do embasamento
cristalino e rochas graníticas e gnáissicas, cobertas por camadas de argila e
formações sedimentares recentes próximas às margens do Lago Guaíba. Apresenta
solos argilosos espessos, com texturas que facilitam a infiltração, mas que demandam
cuidados estruturais em áreas de encosta e várzea devido à movimentação de massa
e risco de alagamentos. Está intimamente ligado ao Sistema Aquífero Embasamento
Cristalino, com capacidade de armazenamento e extração de água subterrânea
variável, apresentando áreas de aquíferos fraturados e sistemas granulares. Também
apresenta instabilidades frente à erosão hídrica em áreas de declive e planícies
aluviais.

O território está situado predominantemente no bioma Pampa, mas, por estar
localizado na Região Metropolitana de Porto Alegre, o município também apresenta
forte influência de áreas de transição e fragmentos do bioma Mata Atlântica. O Pampa
é caracterizado pelas extensas formações campestres (campos nativos) essenciais
para a biodiversidade regional. Os ecótonos ocorrem em áreas de morros, como na
região do Parque Natural Municipal Morro José Lutzenberger, abrigando
remanescentes florestais que servem de refúgio para espécies ameaçadas, a exemplo
do bugio-ruivo.

Sendo banhado pelo sistema do Lago Guaíba, conta com várzeas e banhados
que funcionam como reguladores ambientais e abrigam uma rica fauna e flora
aquáticas. Conta com os sistemas de arroios perenes e intermitentes, que formam
microbacias:

#item(left: 18pt)[a)][Microbacia do Arroio Petim: arroio Petim, arroio Matias, arroio Figueiró.]
#item(left: 18pt)[b)][Microbacia do Arroio Capivara: arroio Capivara, arroio Itira, arroio Galego,
arroio Lagoão, arroio Santa Luzia, sanga do Souza. O Arroio Capivara ou _das
Capivaras_ faz divisa entre os municípios de Guaíba e Barra do Ribeiro e passa
na Terra Indígena da Tekoá Tape Porã, onde fica a escola Arasaty.]
#item(left: 18pt)[c)][Microbacia do Arroio Grande: arroio Grande, arroio Terra Dura, arroio das
Pedras, arroio do Salso;]
#item(left: 18pt)[d)][Microbacia do Arroio Ribeiro Pequeno: Ribeiro Pequeno Arroio do Moinho e
Barracão.]
#item(left: 18pt)[e)][Microbacia do arroio Ribeiro: arroio Cadeia, arroio da Estiva; Açude dos Garcia.]
== Cascata do Português

A Cascata do Português (@fig-cascata) é um dos principais destinos de ecoturismo
da Costa Doce, localizada a cerca de 7 km do centro de Mariana Pimentel e a apenas
80 km de Porto Alegre. É uma propriedade particular muito procurada por famílias e
entusiastas do campismo.

== Pedra Equilibrada

#set par(first-line-indent: indent(35.4pt))
Situada a cerca de 7 km do centro, a Pedra Equilibrada (@fig-pedra) é uma
intrigante e gigante formação rochosa que se equilibra misteriosamente sobre outra
estrutura de pedra. O acesso é feito por uma propriedade particular gratuita, exigindo
apenas uma curta caminhada em campo aberto. Do topo, tem-se uma linda vista
panorâmica da região de morros.

#set par(first-line-indent: indent(36pt))

#illustration(
  [Cascata do Português],
  photo("04-cascata-do-portugues", 362.2pt),
  source: [Griszewski (2018)],
) <fig-cascata>

#illustration(
  [Pedra Equilibrada],
  photo("05-pedra-equilibrada", 246.1pt),
  source: [Prefeitura de Mariana Pimentel (2022)],
) <fig-pedra>

== Morro do Papaléo

O Morro do Papaléo é um dos mais importantes sítios paleontológicos e
geológicos do sul do Brasil. Localiza-se no município de Mariana Pimentel, muito
próximo da divisa com Barra do Ribeiro. Reconhecido nacionalmente por preservar
um registro excepcional da história geológica da Bacia do Paraná, nele foram
encontrados numerosos fósseis vegetais preservados em rochas sedimentares,
datados de aproximadamente 290 milhões de anos, período Permiano. Esses fósseis
registram a vegetação que se desenvolveu após a grande glaciação do Paleozóico.
Curiosamente, o sítio foi revelado durante atividades de mineração de argila para
abastecimento da indústria cerâmica regional. A extração expôs as camadas
rochosas, despertando o interesse de geólogos na década de 1960 e, posteriormente,
de paleontólogos a partir dos anos 1970. Considerado um geossítio de relevância
nacional, reconhecido pelo Serviço Geológico do Brasil devido ao seu elevado valor
científico e educativo, desde então dezenas de pesquisas vêm sendo realizadas no
local. Também apresenta alto risco de degradação, razão pela qual sua preservação
é considerada prioritária.

== Reserva Particular do Patrimônio Natural Federal Mariana Pimentel

A Reserva Particular do Patrimônio Natural Federal Mariana Pimentel (RPPN
Federal Mariana Pimentel) é uma unidade de conservação de domínio privado
reconhecida pelo governo federal, criada com o objetivo de proteger, em caráter
permanente, áreas de relevante interesse ecológico. As Reservas Particulares do
Patrimônio Natural (RPPNs) são instituídas voluntariamente pelos proprietários rurais
e garantem a conservação dos ecossistemas naturais, permitindo apenas atividades
compatíveis com a preservação ambiental, como pesquisa científica, educação
ambiental e visitação controlada.

Representa um importante patrimônio natural por conservar remanescentes de
vegetação nativa do Bioma Pampa em transição com a Mata Atlântica, protegendo a
fauna, a flora, os recursos hídricos e a paisagem regional. A área desempenha papel
fundamental na manutenção da biodiversidade, funcionando como refúgio para
diversas espécies de animais e plantas características da região.

Além de sua importância ecológica, a reserva possui valor científico e
educativo, servindo de espaço para estudos sobre conservação ambiental,
recuperação de ecossistemas e educação ambiental. Também contribui para a
formação de corredores ecológicos e para a preservação dos serviços ambientais,
como a proteção do solo, das nascentes e da qualidade da água.

== Cerro Negro

#set par(first-line-indent: indent(35.4pt))
Cerro Negro é um morro e atrativo natural localizado no município de Mariana
Pimentel. Destaca-se por sua relevância paisagística, ambiental e geológica,
constituindo um dos principais marcos naturais do município. Situado em área de
elevada importância para a conservação da biodiversidade, o Cerro Negro integra o
conjunto de patrimônios naturais reconhecidos pelo poder público municipal.

O local apresenta vegetação nativa associada ao Bioma Pampa, afloramentos
rochosos e paisagens que favorecem a contemplação da natureza, além de
desempenhar relevante papel na proteção dos recursos hídricos e dos ecossistemas
locais. Em razão de seu valor ambiental e científico, o Cerro Negro foi incluído nas
propostas de Zoneamento de Proteção do Patrimônio Natural do Plano Diretor
Municipal de Mariana Pimentel, visando assegurar sua preservação e disciplinar os
usos compatíveis com a conservação da paisagem e da biodiversidade.

== Serrinha

A Serrinha é uma pequena região situada entre o sudoeste de Guaíba e o
noroeste de Barra do Ribeiro, recortada pelo Arroio Capivara em duas encostas, em
cuja superior encontra-se o ponto mais alto do município de Guaíba, com altitude de
326 metros. Colonizada em 1890 por suíços-valesanos (Silva, 2022), a região possui
vestígios pré-históricos como artefatos cerâmicos da cultura Tupi-Guarani (embora
não exista sítio arqueológico conhecido no momento) como fragmentos de panelas e
potes. Na zona oriental da Serrinha, localiza-se a aldeia Mbyá-Guarani _Tape Porã_,
uma área de 143 hectares próxima ao arroio Capivara.

A formação denominada “Serrinha”, que dá nome à localidade pertencente à
Barra do Ribeiro, é caracterizada pela incidência de vários cerros em conjunto. São
ondulações um tanto altas de formação granítica antigas, que fazem parte da Serra
do Herval, que por sua vez integra a unidade de relevo do Rio Grande do Sul
denominada Escudo Sul-rio-grandense. É uma localidade muito acidentada, formada
por uma encosta superior, pertencente à localidade denominada de Matias, em
Guaíba, e uma encosta inferior, pertencente à Barra do Ribeiro, dividida por um vale
de longo curso do arroio Capivara. Nessa serrinha encontram-se diversas nascentes
de arroios intermitentes e perenes, que vão formar o arroio Capivara, principal curso
d’água da microbacia, que vai desaguar no Guaíba. O arroio Capivara faz a divisa
entre os municípios de Guaíba e Barra do Ribeiro.

#set par(first-line-indent: indent(36pt))

#illustration(
  [Vista panorâmica da região da Serrinha; o Lago Guaíba aparece ao fundo à esquerda],
  stack(dir: ltr, photo("06a-panorama-da-serrinha", 215.99pt), photo("06b-panorama-da-serrinha", 215.06pt)),
  source: [Cabral (2026)],
)

#illustration(
  [O Cerro Negro, em segundo plano],
  photo("07-cerro-negro", 431.03pt),
  source: [Cabral (2026)],
)

= Organização sociopolítica
== Capelas e igrejas

Na área rural e em bairros próximos encontram-se capelas que exercem
importante papel comunitário:

#item[●][Capela Santa Ana (@fig-capela).]
#item[●][Capela São Francisco de Assis.]
#item[●][Capela Senhor do Bom Fim.]
#item[●][Igreja Assembleia de Deus, no entroncamento das Estradas do Petim e
do Bom Retiro (Igreja do Nabor).]

Essas comunidades religiosas costumam organizar festas de padroeiro,
almoços comunitários, novenas e outras celebrações.

Embora a região não possua grandes eventos turísticos consolidados, são
comuns celebrações promovidas por capelas, escolas, associações comunitárias e
entidades rurais, reunindo moradores e famílias em momentos de integração. Entre
as manifestações mais frequentes destacam-se as festas de padroeiros, almoços
comunitários, festas juninas, confraternizações organizadas pelas escolas do campo,
encontros de agricultores, bailes e eventos tradicionalistas.

#illustration(
  [Capela Santa Ana],
  photo("08-capela-santa-ana", 385.85pt, height: 243.48pt),
  source: [Molnar (2026)],
) <fig-capela>

#illustration(
  [Igreja Assembleia de Deus do Nabor],
  photo("09-igreja-do-nabor", 453.65pt),
  source: [Cabral (2026)],
)
== Cemitério Passo Grande

O Cemitério Passo Grande é um pequeno cemitério rural localizado na
comunidade de Passo Grande, no município de Barra do Ribeiro, muito próximo da
divisa com Guaíba. Sua presença está associada às antigas comunidades rurais
formadas por fazendas, sesmarias e pequenas propriedades da região.

Constitui um importante elemento da memória local, preservando a história das
famílias que ocuparam a região desde o século XIX. Em muitas comunidades rurais
do Rio Grande do Sul, cemitérios como este foram implantados próximos às antigas
capelas ou às sedes das fazendas, tornando-se espaços de referência para a
identidade comunitária e para a preservação da memória das gerações locais.

== Aldeias Mbyá

O território possui as seguintes aldeias Mbyá Guarani:

#item[a)][_Tekoá Pekuruty (“lugar de muitos pica-paus”)._ Localizada em uma
estreita e vulnerável faixa de terra às margens da rodovia BR-290, entre
os km 132 e km 133, na região do Arroio da Divisa, no município de
Eldorado do Sul.]
#item[b)][_Tekoá Tape Porã (“caminho belo” ou “bom caminho”)._ Localizada em
Guaíba, no Passo Grande, zona rural limítrofe com a Barra do Ribeiro.
Possui a EEIEF Arasaty.]
#item[c)][_Tekoá Porã (“bonita” ou “boa”)._ Localizada na área rural de Barra do
Ribeiro, mais especificamente assentado na região da localidade
conhecida como Coxilha da Cruz (com acessos rurais frequentemente
referenciados por vias locais, como a estrada Passo Menequini). Possui
a EEIEF Teko'a Porã.]
#item[d)][_Tekoá Yvy Poty (“flor da terra”)._ Localizada na área rural do município
de Barra do Ribeiro na localidade conhecida como Douradilho, com seu
acesso principal referenciado na Estrada da Cabanha. Possui a EEIEF
Yvy Poty.]
#item[e)][_Tekoá Nhu’u Poty (“flor do campo”)._ Localizada na área rural do
município de Barra do Ribeiro na localidade do Passo Grande, próximo
ao Arroio das Capivaras. Possui a EEIEF Nhu’u Poty.]
#item[f)][_Tekoá Guapo'y (“figueira”)._ Localizada na área rural do município de
Barra do Ribeiro na localidade do Douradilho.]
#item[g)][_Tekoá Ka'aguy Porã (“mata boa” ou “floresta sagrada”)._ Localizada na
área rural do município de Barra do Ribeiro na região do Douradilho.]
#item[h)][_Tekoá Mirim (“pequena”)._ Localizada em Mariana Pimentel, na
localidade de Passo d’Areia. Possui a EEIEF Cacique Sepé Tiaraju.]
#item[i)][_Tekoá Jate’i Mirim (“abelha jataí pequena”)._ Localizada em Eldorado do
Sul, no bairro Parque Eldorado. Faz parte do grupo da Tekoá Pekuruty,
que após a enchente de 2024, obteve uma pequena área nessa
localidade, para onde se transferiram parte dos moradores da aldeia. A
escola, que antes funcionava na comunidade do arroio da Divisa,
transferiu-se para a Jate’i Mirim, por falta de crianças na Tekoá Pekuruty.]
#item[j)][_Acampamento Arroio do Conde (também conhecido como
Acampamento do Ype)._ Localizado dentro do território urbano de
Guaíba, na Estrada do Conde, próximo à divisa dos municípios de
Eldorado do Sul e Guaíba. Estão em situação bastante vulnerável, às
margens da rodovia, com casas feitas de lona. Segundo Rafael Netto,
técnico da Emater/RS de Guaíba, (com. pessoal) no momento vivem ali
seis famílias, que têm alguma relação com a Tekoá Tape Porã.]
=== Duplicação de rodovias

#set par(first-line-indent: indent(35.4pt))
A situação atual dos Mbyá Guarani no Rio Grande do Sul envolve graves
disputas territoriais, insegurança habitacional agravada por desastres climáticos
(como as enchentes) e impactos contínuos de grandes obras rodoviárias e industriais.

A duplicação da BR-116 afetou pelo menos 12 comunidades indígenas,
forçando o Departamento Nacional de Infraestrutura de Transportes (DNIT) a executar
um plano básico ambiental indígena (PBAI) chamado Programa de Apoio às
Comunidades Mbyá-Guarani, que previu ações de compensação, proteção territorial
e o fomento à comercialização de artesanato para garantir a subsistência.

A aldeia Pekuruty, localizada no km 132 da BR-290, foi destruída durante uma
intervenção emergencial do DNIT para garantir a trafegabilidade pós-enchentes. Após
ação do MPF e da Defensoria Pública da União, a Justiça Federal determinou que o
órgão federal adquira um terreno de 300 hectares para realocação definitiva e
reconstrução da aldeia.

=== Organização das aldeias e comunidades

Nas comunidades Mbyá da região as moradias são feitas de madeira ou pau-a-pique feito com taquara. Em relação às casas tradicionais dos guaranis Mbya, eles
próprios comentam - “Nossas casas são feitas de taquara e palmeira. Usamos barro
mexido para fazer as paredes. O uso dessas casas é comum entre os guaranis,
porque ajuda a eliminar a fumaça da fogueira que fazemos para nos aquecer, porque
a fumaça sai pelo teto e pelas paredes. Aprendemos a construir as casas com nossos
pais e também ensinamos para os nossos filhos. As casas de taquara e de barro
fazem parte da cultura guarani”. Existem algumas edificações em alvenaria nas
comunidades, a maioria resquício da ocupação dos antigos proprietários das áreas
adquiridas pelo DNIT. As escolas Sepé Tiaraju e Arasaty são construções de
alvenaria, sendo a primeira construída para a finalidade escolar, enquanto a segunda
reaproveita o prédio de uma casa já existente no local.

#illustration(
  [Alunos da EEEM Gonçalves Lêdo e alunos da Tekoá Mirim em frente à escola EEIEF Cacique Sepé Tiaraju, em Mariana Pimentel, território compartilhado, maio/2026],
  photo("10-alunos-na-sepe-tiaraju", 100%),
  source: [Cabral (2026)],
)

= Educação e organização escolar

A educação nesse território compartilhado — que compreende áreas rurais dos
municípios de Guaíba, Eldorado do Sul, Mariana Pimentel e Barra do Ribeiro — deve
ser compreendida a partir de sua ruralidade concreta.

Sob essa perspectiva, as escolas que integram este território educativo são:

#item(left: 18pt)[a)][EMEF Santa Catarina (Logradouro, Guaíba);]
#item(left: 18pt)[b)][EMEF São Paulo (Morro Santana, Guaíba);]
#item(left: 18pt)[c)][EMEF Dom Pedro II (Boqueirão, Mariana Pimentel);]
#item(left: 18pt)[d)][EMEF João Ziulkoski Filho (Centro, Mariana Pimentel);]
#item(left: 18pt)[e)][EEEM Gonçalves Lêdo (Centro, Mariana Pimentel);]
#item(left: 18pt)[f)][EMEF Ana Barok (Potreiro Grande, Mariana Pimentel);]
#item(left: 18pt)[g)][EMEI Municipal (Centro, Mariana Pimentel);]
#item(left: 18pt)[h)][EEIEF Cacique Sepé Tiaraju (Tekoá Mirim, Passo d'Areia, Mariana Pimentel);]
#item(left: 18pt)[i)][EEEM João Evangelista Pinós (Passo Grande, Barra do Ribeiro);]
#item(left: 18pt)[j)][EEIEF Arasaty (Passo Grande, Guaíba);]
#item(left: 18pt)[k)][#h(0.2778em)EEEF Sergipe (Bom Retiro de Guaíba, Eldorado do Sul).]
#v(7.9pt)

#set par(first-line-indent: indent(36pt))
Embora pertençam a diferentes redes municipais e estadual, essas escolas
compartilham a mesma dinâmica territorial, marcada pela circulação cotidiana de
estudantes, famílias e trabalhadores entre os três municípios, formando uma rede
educacional regional que ultrapassa os limites político-administrativos. Consideramos,
para fins deste inventário, as escolas que estão limitadas pelo território compreendido
entre as BR– 116, BR-290 e RS-711. A escola EMEF João Pinós foi incluída, apesar
de estar na margem oposta da BR-116, porque é a escola que atende toda a
população rural do território da Serrinha e Faxinal, na Barra do Ribeiro. A escola
Sergipe não será tratada neste inventário porque abrange a área inventariada pela
colega Francine Vargas. No entanto, é importante colocar que, frequentemente,
alunos do Bom Retiro vem estudar na EMEF São Paulo, havendo esse trânsito de
alunos entre a escola Sergipe e a São Paulo.

#set par(first-line-indent: indent(35.4pt))

#illustration(
  [Território Educativo Compartilhado entre Barra do Ribeiro, Guaíba e Mariana Pimentel representado pela área do polígono. As escolas estão assinaladas pelos ícones amarelos],
  photo("11-territorio-educativo", 100%),
  source: [Cabral (2026)],
)

A seguir, apresentaremos um histórico do desenvolvimento das iniciativas
educacionais neste território compartilhado, desde as primeiras escolas até a
atualidade, traçando um comparativo entre as regiões com base na distribuição
geográfica atual dos municípios.

Segundo Silva (2008), as primeiras escolas de Mariana Pimentel datam do
início do século XX, aproximadamente em 1905. Eram instituições de pequeno porte,
organizadas em classes multisseriadas e conduzidas, em geral, por um único
professor. Nesse período predominavam as escolas de 1ª Entrância, também
conhecidas como "Aulas Isoladas", instaladas principalmente nas localidades mais
distantes e rurais. Paralelamente, existiam as chamadas "Aulas Reunidas", formadas
pela junção de duas ou mais classes isoladas localizadas em áreas próximas. Em
Mariana Pimentel, esse modelo estava presente nas localidades de Mariana Pimentel,
Linha Vasques e Boqueirão. Essas unidades possuíam mais de um professor e
representavam uma etapa intermediária rumo à constituição dos grupos escolares. O
primeiro grupo escolar estadual do município foi o _Grupo Escolar Gonçalves Lêdo_,
criado pelo Decreto nº 7.675, de janeiro de 1939.

#illustration(
  [Antiga escola de Mariana Pimentel, não identificada, década de 1940],
  photo("12-antiga-escola", 377.15pt, height: 281.7pt),
  source: [Adriano Baum (arq. Pessoal)],
)

#illustration(
  [Prédio abandonado da antiga E.M.José de Anchieta, linha Vasques, Mariana Pimentel],
  photo("13-escola-jose-de-anchieta", 374.7pt),
  source: [Cabral (2026)],
)

#illustration(
  [EEEM Gonçalves Lêdo e João Ziulkoski Filho, em Mariana Pimentel],
  photo("14-goncalves-ledo-e-ziulkoski", 433.5pt),
  source: [Cabral (2026)],
)

Em 1952, funcionavam na região doze escolas municipais distribuídas por
diferentes localidades rurais. Quando ocorreu a emancipação de Mariana Pimentel,
em 1992, o território contava com 24 escolas municipais e uma escola estadual de 1º
Grau. Naquele momento iniciou-se um processo de nucleação da rede municipal: as
24 escolas, que ofereciam ensino apenas até a 4ª série, foram reorganizadas em três
escolas-polo de ensino fundamental completo. Da rede municipal, permaneceram em
funcionamento a Escola Municipal Dom Pedro II, no Boqueirão; a Escola Municipal
Castro Alves, na Linha Dr. Inácio; e a Escola Municipal Ana Barok, em Potreiro
Grande. A Escola Gonçalves Lêdo, estadual, seguiu suas atividades, ainda no ensino
fundamental. Em 2007, iniciou-se a transição da escola, para a extinção do ensino
fundamental, passando a atender exclusivamente o ensino médio.

#blank(1)

Em 2008 ocorreu a municipalização de todas as matrículas da Educação Infantil
e do Ensino Fundamental que ainda pertenciam à rede estadual, sendo criada, então,
a Escola Municipal de Ensino Fundamental João Ziulkoski Filho, localizada na área
urbana do município. Posterior à municipalização, ocorreu um novo processo de
nucleação escolar que resultou na extinção da EMEF Castro Alves e na concentração
dos anos finais do Ensino Fundamental na EMEF João Ziulkoski Filho. Desde então,
as escolas rurais passaram a ofertar apenas os anos iniciais do ensino fundamental,
enquanto os estudantes do 6º ao 9º ano são diariamente transportados para a sede
municipal.

O Documento Orientador do Território Municipal de Mariana Pimentel (2019),
equivalente ao Plano Municipal de Educação, reconhece apenas duas escolas na
zona rural e, por esse motivo, são classificadas como escolas do campo. Entretanto,
essa interpretação revela-se limitada diante da própria realidade territorial. Segundo o
Plano Diretor Municipal (2023), aproximadamente 81% dos domicílios do município
localizam-se na área rural, o que significa que a maior parte da população vive e
estabelece suas relações sociais, econômicas e culturais no campo. A Resolução
CNE/CEB nº 2, de 28 de abril de 2008, estabelece, em seu artigo 2º, que são
consideradas escolas do campo tanto aquelas situadas em área rural quanto aquelas
localizadas em área urbana que atendam predominantemente populações do campo.
À luz dessa definição, e posto o fato da predominante ruralidade da população,
questiona-se: não seriam, então, praticamente todas, as escolas de Mariana Pimentel
escolas do campo?

Nas localidades da Serrinha e do Faxinal, pertencentes ao município de Barra
do Ribeiro, o desenvolvimento histórico da educação apresenta diversas semelhanças
com o ocorrido em Mariana Pimentel. Nas primeiras décadas do século XX não
existiam escolas públicas na região, sendo o ensino realizado por professores
particulares, como o professor Aristides Alves, que ministrava aulas na encosta
superior da Serrinha (Silva, 2022).

Segundo os livros de contratos de professores da Prefeitura de Guaíba, as
primeiras aulas públicas da Serrinha foram implantadas em 1932. Inicialmente
funcionavam na residência do pai da professora Cândida Ribeiro, uma das primeiras
professoras da região, atendendo cerca de quarenta alunos. Posteriormente,
passaram a funcionar em um rancho de pau a pique, rebocado com barro e coberto
de capim. A primeira escola oficialmente denominada foi a Escola Municipal Machado
de Assis. Outras escolas surgiram ao longo das décadas: Almirante Barroso, Dom
Pedro I, Almirante Tamandaré e Escola Municipal Anita Garibaldi. Esta última
instituição recebeu diferentes denominações, como E.M. Antônio de Souza Neto, e,
finalmente, E. M. Adão Adolfo Liebig, em 1969 — refletindo sucessivas
reorganizações administrativas. Em 1971 foi implantado um Curso Supletivo Noturno,
seguido, também no noturno, pelos Cursos de Madureza, oferecendo oportunidades
educacionais para jovens e adultos da região.

Na encosta superior funcionou ainda a Escola Municipal Provisória da Serrinha,
criada em 1967. Em 1977 passou a denominar-se Escola Municipal de 1º Grau
Incompleto Venâncio Varella, então já instalada na localidade de Matias.

Na década de 1990 ocorreu processo semelhante ao de Mariana Pimentel, com
o fechamento das pequenas escolas rurais e sua concentração em escolas-polo. As
escolas da Serrinha foram desativadas. Os estudantes da encosta superior,
pertencente ao município de Guaíba, passaram a frequentar a EMEF São Paulo,
localizada no Morro Santana, enquanto os alunos da encosta inferior da Serrinha e do
Faxinal passaram a ser transportados até a sede de Barra do Ribeiro para cursar o
Ensino Fundamental, percorrendo, em alguns casos, mais de 40 quilômetros
diariamente.

O território rural de Barra do Ribeiro pertenceu, em grande parte, a Guaíba até
a década de 1950, período de sua emancipação. Por essa razão, segundo Silva
(2021), os dados sobre a escolarização da região se mesclam nesse intervalo de
tempo. A partir das décadas de 1950 e 1960, começam a surgir registros específicos
sobre as escolas rurais de Guaíba e Barra do Ribeiro de forma separada. Naquela
época, a estrutura escolar rural de Guaíba contava com um Grupo Escolar Rural, duas
Escolas Reunidas e duas Escolas Rurais Isoladas. A educação da área rural de
Guaíba desenvolveu-se na mesma direção que as de Mariana Pimentel e Barra do
Ribeiro. A nucleação das pequenas escolas do campo seguiu a mesma lógica e
cronologia, evidenciando uma ação atrelada a políticas educacionais que
ultrapassavam as fronteiras municipais. Segundo relato pessoal de Rejane Guasso,
diretora da EMEF São Paulo, nascida e residente na região, havia sete instituições
ativas no período da nucleação, na década de 1990: E.M. Adão Foques, E.M. Paulo
Pereira Paiva, E.M. Anacleto Prates, E.M. Venâncio Varella, E.M. São Paulo, E.M.
Minas Gerais e E.M. Santa Catarina. Pouco antes disso, a E.M. Fernão Dias havia
sido fechada. Das estruturas existentes no território, restaram apenas a EMEF Santa
Catarina e a EMEF São Paulo. Esta última manteve-se ativa porque foi contemplada
com um prédio novo financiado, construído em uma área cedida em regime de
comodato pelo proprietário de uma das fazendas locais (Sr. Walter Herz). Esse fato
fortaleceu sua oferta de ensino, tornando-a uma escola-polo em 1995.

As situações descritas para o contexto rural dos três municípios convergem
com o que foi evidenciado por Bremm (2015), que relata uma reconfiguração política
e econômica no Brasil a partir da década de 1990, que afetou as escolas do campo.
Nesse período, foram adotadas políticas neoliberais com o intuito de reduzir o
tamanho do Estado e aumentar sua eficiência, estabelecendo um Estado mínimo para
as políticas sociais (trabalho e educação) e máximo para o capital (Janata; Anhaia,
2015). Isso levou o governo federal a aprofundar a contenção de gastos sociais e
educacionais, condicionando o repasse de recursos à apresentação de projetos
municipais de efetivação da nucleação escolar e ao consequente fechamento de
escolas rurais com baixo número de estudantes. Na maioria dos casos, o argumento
principal em defesa da nucleação girava em torno da melhoria da qualidade do ensino
oferecido às crianças do meio rural e da insuficiência de alunos para manter as turmas
abertas. No entanto, a autora levantou dados bibliográficos que apontam também para
objetivos como a racionalização de custos do poder público, a descentralização dos
deveres educacionais do Estado e uma formação escolar voltada majoritariamente ao
trabalho urbano, o que acabou por ocasionar o desenraizamento dos sujeitos do
campo (Bremm, 2015 _apud_ Pastorio, 2015; Janata; Anhaia, 2015).

No contexto do Rio Grande do Sul, esse processo assume contornos
particulares, articulando-se à histórica presença da agricultura familiar e,
simultaneamente, ao avanço de modelos produtivos vinculados ao agronegócio. A
redução do número de escolas no campo gaúcho acompanha
transformações socioeconômicas mais amplas, como o êxodo rural, a mecanização
agrícola e a concentração fundiária, fatores que impactaram diretamente a
organização das comunidades rurais e suas instituições educativas (Wanderley,
2014; Veiga, 2002).

#blank(1)

Seguindo o panorama do território, é importante falar do Ensino Médio. Em
relação à essa etapa da educação básica, a oferta na região é bastante concentrada,
tendo como principal instituição a EEEM Gonçalves Lêdo. Os estudantes das
localidades de Matias e Morro Santana, em Guaíba, costumam se deslocar para
estudar nela. Já aqueles que residem no Passo da Taquara e no Petim, em geral,
optam por escolas do centro de Guaíba, em razão da linha de ônibus que atende a
essa área. Da mesma forma, os alunos do Logradouro precisam viajar até a sede do
município utilizando o transporte coletivo local. Os jovens da Serrinha e do Faxinal
também precisam se deslocar para sede do munícipio de Barra do Ribeiro, por meio
de transporte escolar, se quiserem cursar o Ensino Médio – agora percorrendo não
somente 20 quilômetros, mas pelo menos 30 quilômetros para chegar à escola, 60
Km por dia, a maior parte em estradas de chão batido. Por fim, os residentes do
Boqueirão dividem-se entre a Escola Gonçalves Lêdo e a sede de Barra do Ribeiro,
conforme a localização de suas residências, uma vez que a comunidade está dividida
geograficamente entre os dois municípios.

Em todos os cenários, a continuidade dos estudos no Ensino Médio exige
grandes deslocamentos. O município de Mariana Pimentel apresenta a estrutura mais
organizada para esse fim, fornecendo várias linhas de ônibus escolares. Por outro
lado, Guaíba é o município que menos oferece assistência ao estudante do campo
nessa etapa: não há linhas de transporte coletivo que atendam a todas as localidades
rurais e inexistem rotas de transporte escolar organizadas com essa finalidade. Em
diversos casos, o acesso ao transporte exige que o estudante se desloque
previamente por meios alternativos até o ponto de embarque, muitas vezes localizado
em um município vizinho. Essa dinâmica evidencia que a organização da vida
cotidiana e da escolarização rompe os limites administrativos, reforçando a existência
de um território educativo regional cuja fluidez é determinada pelas relações sociais e
fluxos populacionais, e não pelas divisões político-territoriais e, por conseguinte,
deveria ser planejada conjuntamente entre esses municípios. Como consequência
das dificuldades encontradas, muitas famílias migram para bairros urbanos periféricos
para garantir o acesso dos filhos ao estudo.

No que se refere às escolas indígenas desse território, a existência delas está
diretamente vinculada ao processo de assentamento das comunidades Guarani
situadas às margens da BR-116, no trecho entre Guaíba e Mariana Pimentel. Segundo
Dal Sasso (2017), essas comunidades foram assentadas em terras adquiridas por
conveniências imobiliárias e não por reconhecimento de áreas ancestrais, o que gerou
impactos na cultura local. Por outro lado, essa aquisição garantiu a criação de espaços
para os Mbyá Guarani na costa oeste da Lagoa dos Patos. Vale destacar que, para
essa comunidade, o território onde estão inseridas as _Tekoás_ constitui uma área
tradicional que não comporta delimitações espaciais rígidas, conceito que destoa de
sua visão de mundo. As escolas de ambas as aldeias surgiram de reivindicações dos
próprios moradores, que nelas enxergaram um benefício para o grupo. Tanto na
EEIEF Cacique Sepé Tiaraju quanto na EEIEF Arasaty, as classes são bilíngues,
compostas por professores juruá (não indígenas) e professores Mbyá Guarani (prof.
Carmem De Antoni, diretora da escola Arasaty, com. pessoal). A região ainda carece
de uma escola indígena de Ensino Médio, embora já exista aprovação para o início
dessa modalidade na EEIEF Tekoá Porã (que passará a ser EEEM Tekoá Porã), na
aldeia homônima, situada na região do Douradilho, em Barra do Ribeiro (prof. Nelson
da Silva, diretor na Escola Cacique Sepé Tiaraju). Até que isso se concretize, os
estudantes indígenas que desejam prosseguir os estudos precisam se matricular nas
escolas de ensino médio dos juruás, as quais também possuem baixa disponibilidade
na região. Para frequentar as aulas, os jovens dessas aldeias precisam se deslocar
até a Escola Gonçalves Lêdo, em Mariana Pimentel, ou até a sede urbana de Barra
do Ribeiro. No ano de 2026, quatro estudantes da Tekoá Mirim frequentam o Ensino
Médio no período noturno na escola Gonçalves Lêdo; embora enfrentem desafios de
adaptação, são, de modo geral, bem recebidos e respeitados pela comunidade
escolar. Existe uma preocupação do corpo docente em integrá-los e há um manifesto
interesse no aprendizado desses estudantes, muito embora seja perceptível a falta de
preparo técnico dos professores para atuar diretamente com a especificidade da
cultura Guarani.

As relações entre as escolas indígenas e não indígenas ainda são incipientes,
restringindo-se, na maioria das vezes, a visitas pontuais às aldeias. Apesar de
importantes, essas ações permanecem circunscritas ao âmbito municipal e não
chegam a constituir uma rede efetiva de intercâmbio intercultural entre as escolas do
território, e menos ainda em relação aos três municípios. No cotidiano da região, o
maior fluxo viário nas estradas coincide com os horários dos ônibus escolares,
evidenciando que a circulação dos estudantes se consolidou como um dos principais
elementos de integração territorial.

A condição de território fronteiriço oferece oportunidades para a construção de
práticas educativas cooperativas, incluindo a formação continuada integrada de
professores, planejamento de projetos interescolares compartilhados e intercâmbios
culturais. Até mesmo a articulação conjunta de políticas de transporte e alimentação
escolar estaria no horizonte das possibilidades de integração. Entretanto, nota-se que
tais iniciativas ainda ocorrem de forma bastante limitada. Predomina uma organização
em que cada escola atua isoladamente, sem espaços permanentes de planejamento
ou de desenvolvimento de ações integradas.

Sob a perspectiva da Educação do Campo, todas essas instituições
compartilham desafios e potencialidades comuns. Entre eles, destacam-se os
intensos deslocamentos intermunicipais de estudantes e famílias, o compartilhamento
de serviços públicos e a presença marcante de saberes tradicionais vinculados à
agricultura familiar, à pecuária, às comunidades Guarani (no caso das aldeias) e às
heranças culturais dos diferentes grupos de imigrantes que colonizaram a região.
Outro ponto em comum entre essas escolas é não se reconhecer como escolas do
campo e consequentemente, não refletir suas identidades nos seus projetos político
pedagógico (PPP). As escolas acompanhadas nesse semestre citam em seus PPPs
a identidade de seus estudantes, como oriundos do campo, com famílias
predominantemente mantidas pelo trabalho rural, mas não trazem nos autores que
orientam sua construção, tampouco em seus currículos, essa identificação. Exceção
é feita pelas escolas indígenas, que trazem claramente suas questões culturais
expressas nos PPP e dessa forma, influenciam a construção dos seus currículos.
Muito provavelmente, a observação e convivência nessas escolas nos trará pistas de
como os PPPs e currículos das demais escolas do campo do território podem vir a ser
modificados e reelaborados visando construir essa imagem para seus estudantes e
professores.

#illustration(
  [Estudantes Guarani integrados à rotina escolar na Gonçalves Lêdo, 1º. ano noturno],
  photo("15-estudantes-guarani-no-noturno", 139.55pt),
  source: [Cabral (2026)],
)

#illustration(
  [Estudante Guarani em sala copiando exercícios de matemática que tentam contextualizar a cultura indígena em sua proposta; notar que isso se deu em abril de 2026],
  photo("16-estudante-guarani-em-sala", 145.9pt),
  source: [Cabral (2026)],
)

#illustration(
  [Cartaz com fotos representando momento de troca cultural entre os alunos guarani e juruá, na Gonçalves Lêdo, com elaboração de tipa e degustação],
  photo("17-cartaz-de-troca-cultural", 152.4pt),
  source: [Cabral (2026)],
)

#illustration(
  [Visita das turmas de ensino médio da Gonçalves Lêdo à Tekoá Mirim, onde vivem os colegas guarani],
  photo("18-visita-a-tekoa-mirim", 278.4pt),
  source: [Cabral (2026)],
)

#illustration(
  [Cartaz elaborado pelos alunos guarani, com desenho feito por um deles],
  photo("19-cartaz-povos-originarios", 340.1pt),
  source: [Cabral (2026)],
)

== Dados estatísticos sobre educação básica nos municípios estudados
=== Guaíba

O município de Guaíba possui 66 escolas de ensino básico, sendo 30
municipais, 15 estaduais e 21 privadas. Destas, apenas 4 se encontram na zona rural,
sendo 2 municipais e 2 estaduais.

Em 2025, o número de matrículas no ensino básico do município foi de 19.289
estudantes. Deste total, apenas 312 estudantes estavam matriculados nas escolas
rurais.

Em relação aos docentes, em 2025, o município contava com 1.100
profissionais, dos quais 44 trabalhavam nas escolas rurais.

=== Mariana Pimentel

O município de Mariana Pimentel possui 6 escolas de ensino básico, sendo 4
municipais e 2 estaduais. Destas, 3 se encontram na zona rural, sendo 2 municipais
e 1 estadual.

Em 2025, o número de matrículas no ensino básico do município foi de 635
estudantes. Deste total, 172 estudantes estavam matriculados nas escolas rurais.

Em relação aos docentes, em 2025, o município contava com 47 profissionais,
dos quais 18 trabalhavam nas escolas rurais.

=== Barra do Ribeiro

O município da Barra do Ribeiro possui 15 escolas de ensino básico, sendo 5
municipais, 6 estaduais e 4 privadas. Destas, 6 se encontram na zona rural, sendo 2
municipais e 4 estaduais.

Em 2025, o número de matrículas no ensino básico do município foi de 2.221
estudantes. Deste total, 355 estudantes estavam matriculados nas escolas rurais.

Em relação aos docentes, em 2025, o município contava com 153 profissionais,
dos quais 36 trabalhavam nas escolas rurais.

#set par(first-line-indent: indent(36pt))

#illustration(
  [Relação do número de escolas, estudantes e docentes por município],
  kind: table,
  source: [Elaboração própria],
  anchored(406.7, 494.0)[
    #{
      let cell(x0, x1, bottom, body) = at(x0, bottom, size: 11pt, width: x1 - x0, align(center, body))
      let columns = ((85.0, 182.5), (183.3, 253.0), (253.7, 309.6), (310.4, 375.3), (376.0, 425.2), (426.0, 489.3), (490.1, 537.7))
      let groups = ((183.3, 309.6, "N° Escolas"), (310.4, 425.2, "N° Estudantes"), (426.0, 537.7, "N° Docentes"))
      let rows = (
        ("Guaíba", "62", "4", "18977", "312", "1056", "44"),
        ("Mariana Pimentel", "3", "3", "463", "172", "29", "18"),
        ("Barra do Ribeiro", "9", "6", "1866", "355", "117", "36"),
      )

      hline(85.0, 538.4, 406.7, 0.7pt)
      for x in (309.6, 425.2, 537.7) { vline(x, 407.4, 422.4, 0.8pt) }
      hline(182.5, 538.7, 422.4, 1pt)
      hline(182.5, 538.1, 447.2, 0.9pt)
      hline(85.0, 538.1, 493.3, 0.7pt)

      cell(85.0, 182.5, 420.1, strong[Municípios])
      for (x0, x1, title) in groups { cell(x0, x1, 420.6, strong(title)) }
      for (j, (x0, x1)) in columns.slice(1).enumerate() {
        cell(x0, x1, 441.3, strong(if calc.even(j) [Urbana] else [Rural]))
      }
      for (i, row) in rows.enumerate() {
        let bottom = 461.3 + i * 15
        at(89.1, bottom, size: 11pt, row.at(0))
        for (j, (x0, x1)) in columns.slice(1).enumerate() { cell(x0, x1, bottom, row.at(j + 1)) }
      }
    }
  ],
)

#page(flipped: true)[
  #illustration(
    [Caracterização das escolas acompanhadas no inventário],
    kind: "quadro",
    source: [Elaboração própria],
    supplement: [Quadro],
    anchored(140.3, 481.0)[
      #{
        let columns = (85.0, 260.1, 435.2, 610.3)
        let tops = (140.3, 156.1, 171.9, 187.7, 203.6, 219.3, 235.1, 251.0, 266.7, 282.5, 298.4, 314.1, 339.2, 354.9, 380.0, 395.7, 439.2, 454.9)
        let rows = (
          ([], strong[EMEF São Paulo], strong[EEIEF Arasaty], strong[EEEM Gonçalves Lêdo]),
          ([Número de salas de aula], [10], [4], [5]),
          ([Biblioteca], [sim], [Sim], [sim]),
          ([Laboratórios], [não], [Não], [sim]),
          ([Refeitório], [sim], [Sim], [sim]),
          ([Pátio], [sim], [Sim], [sim]),
          ([Horta], [não], [Não], [não]),
          ([Rede de internet], [sim], [Sim], [sim]),
          ([Atendimento Educacional Especializado], [sim], [Não], [sim]),
          ([Sala de Recursos Multifuncionais], [sim], [Não], [sim]),
          ([Outros espaços], [Padaria; consultório médico/odontológico], [Não], [sala de jogos]),
          ([Etapas], [Educação infantil e Ensino Fundamental (anos \ finais e iniciais)], [Educação infantil e Ensino Fundamental \ (anos finais e iniciais)], [Ensino Médio]),
          ([Número de estudantes], [90], [21], [95]),
          ([Turmas], [9 turmas, sendo o 1° e o 2° anos \ multisseriados], [5 turmas multisseriadas, sendo 1°, 2° e 3° anos \ juntos; 4° e 5°; 6° e 7°; 8° e 9°], [7 turmas, sem multisseriação]),
          ([Número de profissionais da educação], [20 docentes e 1 agente educadora], [2 docentes não indígenas e 1 docente indígena], [8 docentes]),
          ([Composição da equipe diretiva], [diretor, vice, orientador educacional e \ supervisora escolar; o diretor e vice são \ escolhidos por eleição.], [diretora, supervisora escolar e cacique da \ aldeia; os diretores, supervisores e professores \ não indígenas são indicados pela SEDUC e \ aprovados ou não pelo cacique], [diretor, vice e supervisora escolar; o diretor e \ vice são escolhidos por eleição]),
          ([Instrumentos de gestão democrática], [Conselho escolar e CPM], [Conselho escolar até o início do presente ano], [Conselho escolar e CPM]),
          ([Programas educacionais que a escola \ desenvolve], [PNLD, PNATE, PNAE, PETIntegral, PDDE \ Básico e PDDE Qualidade.], [PNLD, PNAE, PDDE Básico e PDDE \ Equidade.], [PNLD, PNATE, PNAE, PETIntegral, PDDE \ Básico e PDDE Qualidade.]),
        )

        for top in tops { hline(85.0, 786.3, top, 0.95pt) }
        hline(85.0, 786.3, 480.0, 0.9pt)
        for x in columns + (785.4,) { vline(x, 140.3, 480.9, 0.9pt) }
        for (top, row) in tops.zip(rows) {
          for (x, body) in columns.zip(row) {
            at(x + 3.3, top + 13.0, size: 8pt, spacing: 1, justify: false, body)
          }
        }
      }
    ],
  )
]

= Tempo livre

No território encontram-se importantes espaços de convivência comunitária e
de valorização da cultura tradicionalista gaúcha, destacando-se o parque de rodeios
situado ao lado da Igreja Santa Ana, utilizado para a realização de festas campeiras,
rodeios e encontros da comunidade rural. Outro ponto de referência é o parque de
rodeios conhecido como "do Nendo", localizado na Estrada do Bom Retiro, onde
ocorrem eventos tradicionalistas, confraternizações e atividades relacionadas às
práticas culturais do meio rural. Esses espaços desempenham relevante função social
e cultural, contribuindo para a preservação das tradições locais, o fortalecimento da
identidade regional e a integração entre os moradores das comunidades de Guaíba,
Barra do Ribeiro e Mariana Pimentel.

#par(first-line-indent: indent(35.4pt))[Outra estrutura de lazer e convivência de relevância na localidade é o campo
de futebol (Campo do Faxinal) situado ao lado da Associação de Moradores do
Faxinal, na Estrada da Serrinha. O espaço constitui um importante ponto de encontro
da comunidade, sendo utilizado para a prática esportiva, lazer e realização de eventos
recreativos e comunitários. Além de promover a integração entre moradores de
diferentes faixas etárias, o campo fortalece os vínculos sociais e contribui para a
manutenção da identidade comunitária, desempenhando papel significativo na vida
social da população rural da região.]
== Culinária típica rural

Os hábitos alimentares locais refletem a influência das tradições gaúchas,
açorianas, indígenas, africanas e das diversas correntes de imigração europeia que
contribuíram para a formação histórica da região. Entre os alimentos mais
representativos destacam-se o churrasco preparado em fogo de chão, o arroz
carreteiro, o feijão campeiro, a galinha caipira, o pão caseiro, a cuca, as geleias
artesanais, os doces de frutas da estação, os queijos coloniais, o mel, os embutidos
artesanais e produtos derivados do leite produzidos nas propriedades rurais.

A produção de hortaliças, milho, mandioca, feijão e frutas também integra o
cotidiano das famílias agricultoras, sendo utilizada tanto para o consumo próprio
quanto para a comercialização em feiras locais. O aproveitamento de alimentos
cultivados nas propriedades reforça práticas de sustentabilidade, segurança alimentar
e valorização da agricultura familiar.

A culinária regional ultrapassa a dimensão alimentar, constituindo um
patrimônio cultural transmitido entre gerações por meio dos conhecimentos sobre
cultivo, preparo, conservação dos alimentos e celebrações comunitárias. Dessa
forma, os saberes culinários preservam a identidade das comunidades rurais e
expressam a relação histórica entre a população, o território e os recursos naturais
disponíveis.

#pagebreak()

#set par(first-line-indent: 0pt)
#let q(body) = [*Alan:* #body]
#let a(body) = [*Valdivino:* #body]

#h(34.05pt)#box(width: 90.1pt, strong[APÊNDICE A])#strong[–#h(2.64pt)TRANSCRIÇÃO#h(2.64pt)DE#h(2.64pt)ENTREVISTA#h(2.64pt)COM#h(2.64pt)HISTORIADOR]
#v(15.7pt)

*Entrevistado:* prof. Valdivino Rodrigues da Silva

#blank(1)

#q[Como o senhor percebe o contexto histórico relativo à ocupação deste território?]

#a[Com relação a ocupação deste território, percebo o contexto histórico
como uma disputa territorial entre os espanhóis e portugueses dentro do que
estabelece seus diversos tratados. Como no período da ocupação, estava um tanto
indefinido, este lado da margem direita do Lago Guaíba, os portugueses precisavam
efetivar a ocupação, então por volta de 1732 começou a exploração e é crível que
fossem pertencentes ao grupo pioneiro de Jerônimo de Ornelas. Aqui havia o gado
chimarrão, xucro oriundo da zona missioneira. Então, em torno de 1780, começaram
a proliferar as estâncias de “arrear, pousar e criar”, destinadas à captura do gado
bravio solto nas planícies e canhadas para abastecer os matadouros que surgiam.
Sabe-se que oficialmente foram onze estancieiros-povoadores da gleba guaibense,
através da concessão de extensas sesmarias doadas pela coroa portuguesa, através
de seus prepostos no Brasil-Colônia.]
#blank(1)

#q[Como eram estes espaços físicos e naturais em momentos anteriores? Houve
alterações significativas em sua concepção morfoclimática?]

#a[Estes espaços físicos aos poucos foram sendo de certa forma
transformados pela ação dos povoadores no sentido de experimentar a agropecuária,
transformando os espaços de matarias em lavouras e campos para a criação de gado.
Diminuiu consideravelmente o que havia de matas originais e o próprio relevo também
sofreu certa transformação.]
#blank(1)

#q[Quem eram os primeiros habitantes desta região? Quais foram os sujeitos
históricos e as ações responsáveis pelo êxodo dos Mbyás?]

#a[Na zona próxima à Laguna dos Patos e Lago Guaíba viviam os
“Arachanes” e “Tapes” desde os tempos pré-cabralinos. Estes povos originários
descobriram na região o próprio Lago Guaíba como reza a Lenda da Flor de Aguapé,
sendo os primeiros habitantes desta região. Com a fixação dos povoadores
estancieiros, houve o êxodo dos mbyá guarani para outras regiões.]

#blank(1)

#q[O que era produzido nesta região antes da chegada dos colonizadores? Quais
foram as primeiras alterações do modo de produção e qual o impacto social e
econômico na região?]

#a[Os povos originários viviam em aldeias praticando a caça, pesca e coleta
e algumas tribos cultivavam milho, batata, mandioca e abóbora. Com o êxodo destes
povos, as charqueadas prevaleceram até a década de 1970, quando chegou o período
da industrialização nesta região.]
#blank(1)

#q[Como o senhor percebe a relação social e estrutural existente entre os
ocupantes da aldeia com o entorno? Há interação social ou econômica entre estes
sujeitos? Existem conflitos ou problemas ainda identificados?]

#a[Como ficaram de certa forma reduzidos, os ocupantes ficam restritos em
suas aldeias sob a chefia de seu cacique. No momento não se tem notícias de
conflitos, sendo que os mesmos estão em uma área concedida pelo governo federal.
A interação social é restrita e é feita como se sabe através da prática do comércio de
rua na cidade, vendendo seus produtos e artesanato.]
#blank(1)

#q[Existem espaços de interação social entre os ocupantes destes territórios?]

#a[Acredito que haja pouca interação social, sendo que os mbyás têm sua
própria cultura e modo de vida.]
#blank(1)

#q[Há projetos de socialização entre estudantes das aldeias com os outros
estudantes da rede?]

#a[Pelo que se sabe, a escola da aldeia é administrada pela coordenadoria
da educação do Estado do Rio Grande do Sul, suprindo a aldeia com professor para
o atendimento educacional.]
#blank(1)

#q[Existem práticas escolares de interação entre estes jovens e adultos?]

#a[O Estado procura de certa forma, mas acredito que a educação ocorre
somente para as crianças e dentro da cultura deles.]

#blank(1)

#q[Quais os órgãos ou estruturas governamentais inseridas neste território?]

#a[A 12ª Coordenadoria de Educação do Estado é a estrutura do processo.]
#blank(1)

#q[Como as escolas indígenas foram implementadas neste território? O que foi
levado em conta e quais os estudos prévios para a sua implementação?]

#a[Houve uma mudança da aldeia para outro espaço territorial fornecido pelo
governo por conta de que eles estavam ao lado da BR-116 e quando houve a
duplicação desta, o governo realocou os mbyás para uma região entre Serrinha e
Passo Grande. O local era uma fazenda e uma das casas ficou sendo a escola para
as crianças mbyá.]
#blank(1)

#q[Quais os níveis de escolaridade dos sujeitos que atuam como professores
destes territórios? Possuem formação específica para atuarem?]

#a[Estes professores, a maioria deles realizam até concurso público para o
atendimento em aldeias Mbyá Guarani, então devem ser preparados para este
projeto.]
#blank(1)

#q[Nascido no 1° distrito de Guaíba (Serrinha), quais as dificuldades encontradas
para frequentar a escola e o levou a escolher a docência?]

#a[As dificuldades foram intensas, dadas as atividades na agricultura, criação
de animais, cuidado com o preparo da terra, semeadura, limpeza das plantas, colheita.
Não havia tempo para escola. Vivia por exemplo atuando na colheita do arroz que era
manual e após, o trabalho na trilhadeira e quando chegava em casa tinha a nossa
própria agricultura para dar conta. O tempo de escola pra mim era curtíssimo. Copiava
o que os colegas faziam durante a semana e me virava, fazia as provas que tinha que
fazer, os exames finais e minhas professoras foram minhas grandes inspiradoras para
ser o profissional que hoje sou. E acabei virando professor porque era meu grande
objetivo na vida.]
#blank(1)

#q[Conforme descrito no seu livro, o professor organizava polígrafos montados
com auxílio de mimeógrafos, denominados Estudos Guaibenses (mesmo nome do
livro), no qual era dirigido a professores que atuavam em Guaíba. Como era visto e
aceito esse material pelos professores, escolas e mantenedora?]

#a[Sim, era o que tinha na época. Fiz pesquisas intensas e produzia os
materiais. Auxiliava desta forma meus colegas de magistério, sendo que se formavam
no Gomes Jardim, utilizando meus materiais como referência para seus trabalhos de
formação. E esses materiais transformaram-se em livros editados: “Mariana Pimentel:
patrimônio natural, histórico e cultural”; “Estudos Guaibenses: conhecendo Guaíba e
sua realidade”, “Serrinha e os Suíços-Valesanos” e “O Guaíba: rio ou lago?”. Este
último será lançado em 2026 por conta do Centenário de Guaíba na Feira do Livro
local, da qual fui escolhido como patrono.]
#blank(1)

#q[Como era e como o professor vê hoje a relação entre a população guaibense,
em destaque os moradores da Serrinha e região com as aldeias Mbyá Guarani? O
professor, como historiador, poderia nos falar sobre a aldeia _Tape Porã_?]

#a[Eles procuram ter uma boa relação, cada um no seu espaço, sendo que o
local é um mosaico de etnias: galegos, alemães, italianos, poloneses etc. Os da aldeia
Tape Porã fixam em uma área concedida pelo governo. É uma antiga fazenda onde a
aldeia está assentada. Como já mencionei, essa aldeia localizava-se ao lado da BR-116 no Petim e por conta da duplicação desta rodovia federal, o governo achou por
bem realocá-los para a região oriental da Serrinha. Atualmente estão sob a chefia do
Cacique Leandro e se organizam ali com sua cultura, costumes e assistência
educacional, cuja mantenedora é a coordenadoria de educação do Estado do Rio
Grande do Sul.]
#blank(1)

#q[O professor tem boas expectativas de desenvolvimento com a intervenção da
nova empresa de celulose e papel na região? Haverá degradação ambiental, poluição
de arroios e conflitos com as aldeias indígenas?]

#a[Economicamente vejo boas expectativas, mas ecologicamente não devido
a degradação do meio ambiente onde várias áreas com resquícios de mata nativa
acabaram desaparecendo por conta da grande área de eucaliptos, ressecando o solo
de alguma forma, sem contar que os cursos hidrográficos não são mais confiáveis
com relação a qualidade da água para os seres vivos.]

#blank(1)

#q[Quando o senhor pensa nos povos originários que ocupavam a região como o
sr percebe as questões relacionadas a sua historicidade, cultura e identidade?]

#a[Sobre os povos originários lá do início quando houve a ocupação
portuguesa, de certa forma forçaram o êxodo desses originários para outras áreas.
Após através de movimentos reivindicatórios, os povos originários, principalmente os
guarani procuraram ter esse espaço novamente, ocorrendo o processo de
assentamento de aldeias como forma de manter sua cultura, costumes e formas de
sobrevivência.]
#blank(1)

#q[Em sua visão, quando pensamos em futuro qual é sua perspectiva com relação
a preservação destas comunidades?]

#a[Sobre os nossos povos originários daqui da região guaibense, a
perspectiva é a sobrevivência através da venda de seu artesanato, ou se manterem
com o que produzem na área da aldeia.]
#blank(1)

#q[Existem planos ou projetos vinculados a atender as necessidades e
especificidades destes grupos étnicos?]

#a[Existem leis para a proteção de áreas dessas comunidades previstas na
constituição principalmente e planos governamentais, como ONGs voltados
especificamente para a realidade do povo Mbyá Guarani e essas iniciativas ficam na
autonomia, segurança alimentar, moradia, preservação ambiental e garantia do modo
de vida tradicional. Porém apesar da existência dessas políticas locais
frequentemente lideranças locais cobram maior efetividade na implementação de
infraestrutura, saneamento, água potável e proteção de seus territórios.]
#blank(1)

#q[Como o senhor enxerga a expansão da indústria madeireira (celulose) na
região?]

#a[Como já mencionei, a indústria, com destaque a CMPC, economicamente
é um setor muito forte para a região, mas ecologicamente é um agressor da natureza
na questão da poluição, sendo um aspecto negativo.]

#blank(1)

#q[Qual o futuro dos Mbyás Guaranis?]

#a[Acredito que o futuro deles está intrinsecamente ligado à luta pela
demarcação de suas terras, à preservação ambiental e à resistência cultural. E na
região em que estão assentados como aldeia é melhor do que estarem ao lado de
uma rodovia federal em locais muito restritos e dependendo da cedência de locais
para a prática de sua cultura.]

#pagebreak()

#align(center, strong[REFERÊNCIAS])
#v(36.4pt - 1.35 * 1.1499 * 12pt)

#set text(..edges(1.35))
#set par(justify: false, first-line-indent: indent(35.4pt))
#let ref36(body) = par(first-line-indent: indent(36pt), body)

ARROYO, Miguel Gonzalez. *Outros sujeitos, outras pedagogias.* 2. ed.
Petrópolis: Vozes, 2012.

ARROYO, Miguel Gonzalez; CALDART, Roseli Salete; MOLINA, Mônica
Castagna (org.). *Por uma educação do campo.* 5. ed. Petrópolis: Vozes, 2011.

BRANDÃO, Carlos Rodrigues. Os Guarani: índios do Sul - religião, resistência
e adaptação. *Estudos Avançados*, v. 4, n. 10, p. 53–90, 1 dez. 1990.

BRASIL. *Constituição 1988.* DOU de 5.10.1988.

BRASIL. Instituto do Patrimônio Histórico e Artístico Nacional. *Inventário
Nacional de Referências Culturais (INRC): Manual de Aplicação.* Brasília:
IPHAN, 2000.

BRASIL. *Lei Nº 6.001, de 19 de dezembro de 1973.* Dispõe sobre o Estatuto
do Índio. DOU de 21.12.1973.

BRASIL. *Lei Nº 9.836, de 23 de setembro de 1999.* Acrescenta dispositivos à
Lei no 8.080, de 19 de setembro de 1990, que "dispõe sobre as condições para a
promoção, proteção e recuperação da saúde, a organização e o funcionamento dos
serviços correspondentes e dá outras providências", instituindo o Subsistema de
Atenção à Saúde Indígena. Brasília, 23 de setembro de 1999. DOU de 24.9.1999.

BRASIL. Conselho Nacional de Educação. Câmara de Educação Básica.
*Resolução CNE/CEB nº 2, de 28 de abril de 2008*. Estabelece diretrizes
complementares, normas e princípios para o desenvolvimento de políticas públicas
de atendimento da Educação Básica do Campo. Brasília, DF: MEC/CNE, 2008.

BREMM, Cristina. *As políticas educacionais de nucleação das escolas
rurais/do campo no município de São Paulo das Missões/RS.* Artigo apresentado
como requisito para a aprovação na disciplina de Trabalho de Conclusão de Curso II,
Licenciatura em Ciências Sociais, UFSM, 2015.

CALDART, Roseli Salete. *Educação do Campo.* In: CALDART, Roseli Salete
et al. (org.). *Dicionário da Educação do Campo.* Rio de Janeiro: Escola Politécnica
de Saúde Joaquim Venâncio; São Paulo: Expressão Popular, 2012. p. 257-265.

CALDART, Roseli Salete. *Educação do Campo: notas para uma análise de
percurso.* _Trabalho, Educação e Saúde_, Rio de Janeiro, v. 7, n. 1, p. 35-64, 2009.

CARVALHO et al., Ana Paula Comin de. *Desigualdades de gênero, raça e
etnia* – Curitiba, PR: Intersaberes, 2013.

CAVALCANTI, Lanes de Souza. *Cotidiano, mediação pedagógica e
formação de conceitos: uma contribuição de Vygotsky ao ensino de Geografia.*
Cad. Ceder, Campinas, vol.25, n.66, p.185-207, maio/agosto 2005.

DAL SASSO, Guilherme. *Às margens do desenvolvimentismo: território
guarani e as medidas de compensação socioambiental da obra de duplicação
da rodovia BR-116*. 2017. Trabalho de Conclusão de Curso (Bacharelado em
Ciências Sociais) — Instituto de Filosofia e Ciências Humanas, Universidade Federal
do Rio Grande do Sul, Porto Alegre, 2017. Disponível em:
https://lume.ufrgs.br/handle/10183/189248. Acesso em: 2 jul. 2026.

EMATER/RS-ASCAR. *Sabores do Rio Grande do Sul.* Porto Alegre:
EMATER/RS-ASCAR, diversas edições

FEDERAÇÃO DAS ASSOCIAÇÕES DE MUNICÍPIOS DO RIO GRANDE DO
SUL (FAMURS). *Coletânea Gestão Pública Municipal: Gestão 2009–2012:
Educação de Qualidade: o desafio de todos os municípios.* Porto Alegre:
FAMURS, 2012

FUNDAÇÃO NACIONAL DO ÍNDIO – FUNAI. *História e cultura Guarani.*
Disponível em: \<#url("http://www.funai.gov.br/index.php/ascom/1947-historia-e-cultura-guarani")>. Acesso em: 15 mar. 2019.

GRISZEWSKI, Mateus. *Cascata do Português - A mais linda queda de
Mariana Pimentel/RS*. *Viva Las Trips | Especialistas em Trilhas no RS*, 5 jun.
2018\. Disponível em: \<#url("https://vivalastrips.com.br/cascata-do-portugues/")>. Acesso
em: 10 jul. 2026

INSTITUTO BRASILEIRO DE GEOGRAFIA E ESTATÍSTICA – IBGE.
Disponível em: \<#url("https://ibge.gov.br/")>. Acesso em: 18 mar. 2019.

INSTITUTO BRASILEIRO DE GEOGRAFIA E ESTATÍSTICA (IBGE). Censo
Demográfico 2022: população indígena — resultados por município. Brasília: IBGE,
2022\. Disponível em: https://www.ibge.gov.br/brasil-indigena/. Acesso em: 10 jul.
2026.

LAROQUE, Luís Fernando da Silva. *Guaíba no Contexto Histórico –
Arqueológico do Rio Grande do Sul.* Guaíba: Ed. do Autor, 2002.192p. In:
PREFEITURA MUNICIPAL DE GUAÍBA. História. Disponível em:
\<#url("http://www.guaiba.rs.gov.br:/Conheca_Guaiba/index.html")>. Acesso em:
21 mar. 2019.

JANATA, Natacha E; ANHAIA, Edson M. *Escolas/classes multisseriadas do
campo: reflexões para a formação docente.* Educação & Realidade, Porto Alegre,
v. 40, n. 3, p. 685-704, jul./set. 2015

LIBÂNEO, José Carlos. *Didática.* São Paulo: Cortez, 1992.

#ref36[MAPA GUARANI. 2017. 280 mil indígenas Guarani vivem em quatro países,
diz pesquisa que será apresentada hoje no ATL. 27 de abril de 2017. Disponível em:
\<#url("https://racismoambiental.net.br/2017/04/27/280-mil-indigenas-guarani-vivem-em-quatro-paises-da-america-do-sul-diz-pesquisa-que-sera-apresentada-hoje-no-atl/")>.
Acesso em: 20 mar. 2019.]

#ref36[MARIANA PIMENTEL. Prefeitura. *Turismo em Ação: Dica de Turismo!*
Disponível em:
\<#url("https://www.marianapimentel.rs.gov.br/noticias_ver.php?id_noticia=1112")>. Acesso
em: 10 jul. 2026.]

#ref36[MIRÓ, Carmen A. Políticas de população na América Latina em meados de
1985: um panorama confuso. *Revista Brasileira de Estudos de População*, v. 4, n.
1, p. 87–94, 3 ago. 1987.]

MOLNAR, Pedro. Após anos de abandono, capela histórica do Petim
completa 76 anos e volta a receber fiéis neste domingo. *Repórter Guaibense*, 22
jan. 2026.

MOREIRA, João Carlos; SENE, Eustáquio de. *Geografia Geral e do Brasil:
Espaço Geográfico e Globalização: Ensino Médio.* 3.ed. São Paulo: Scipione,
2016.

PASTORIO, Eduardo. *Nucleação das escolas do campo: o caso do
município de São Gabriel/RS.* UFSM - Programa de Pós-Graduação em Geografia
(Dissertação de Mestrado). Santa Maria, 2015.

POUTIGNAT, Philippe. *Teoria da Etnicidade. Seguido de Grupos étnicos
suas fronteiras de Fredrik Barth.* Philippe Poutignat e Jocelyne Streiff-Fenart.
(Trad. Élcio Fernandes). São Paulo: UNESP, 1998.

PRADELLA, Luiz Gustavo Souza. *O ‘índio’ genérico: contato em
desencontro.* In: Prefeitura Municipal Porto Alegre. Povos Indígenas na Bacia
Hidrográfica do Lago Guaíba Porto Alegre, Rio Grande do Sul, Brasil. 2008.

PREFEITURA MUNICIPAL DE GUAÍBA. *História.* Disponível em:
\<#url("http://www.guaiba.rs.gov.br/Conheca_Guaiba/index.html")>. Acesso em: 21
mar. 2019.

REPÓRTER GUAIBENSE. Guaíba e região têm quase 500 indígenas, diz
Censo 2022. Repórter Guaibense, 07 ago. 2023. Disponível em:
https://www.reporterguaibense.com.br/noticia/guaiba-e-regiao-tem-quase-500-indigenas-diz-censo-2022. Acesso em: 10 jul. 2026.

RIO GRANDE DO SUL. *Decreto nº 7.675, de 07 de janeiro de 1939.* Porto
Alegre, RS: Secretaria de Estado dos Negócios de Educação e Saúde Pública, 07 de
jan. 1939.

SASTRE, PATRICIA MARTÍNEZ. Índios urbanos: buscando as raízes longe
da natureza. El País Brasil, 25 out. 2015.

SILVA, Gilberto Ferreira da; PENNA, Rejane; CARNEIRO, Luiz Carlos da
Cunha (org.). *RS índio: cartografias sobre a produção do conhecimento* [recurso
eletrônico] – Porto Alegre: EDIPUCRS, 2009. p.111-2

SILVA, Valdivino Rodrigues da. *Mariana Pimentel patrimônio natural,
histórico e cultural*. Porto Alegre: Suliani Letra & Vida, 2008.

SILVA, Valdivino Rodrigues da. *Serrinha: núcleo de colonização suíço-valesana pioneira*. Guaíba: Editora Palavreado, 2022.

VEIGA, José Eli da. *Cidades imaginárias: o Brasil é menos urbano do que
se calcula.* Campinas: Autores Associados, 2002.

VIETTA, Katya. *Mbya: Guarani de verdade.* 1992. 198 f. Dissertação
(Mestrado em Antropologia Social) – PPGAS, UFRGS, Porto Alegre, RS, 1992.

WANDERLEY, Maria de Nazareth Baudel. *O mundo rural como espaço de
vida: reflexões sobre a propriedade da terra, agricultura familiar e
ruralidade.* Porto Alegre: Editora da UFRGS, 2014.
