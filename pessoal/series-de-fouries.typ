#set page(paper: "a4", numbering: "1")
#set text(lang: "pt", font: "Carlito")
#set par(justify: true)
#show heading: set text(fill: rgb("#375f91"), font: "Caladea", weight: "bold")
#show heading.where(level: 1): set text(fill: rgb("#375f91"))
#show heading.where(level: 1): set align(center)
#show heading.where(level: 1): set block(spacing: 1.25em)
#show heading.where(level: 2): set text(fill: rgb("#5081bd"))

#let defblock = (body) => block(
  width: 100%,
  breakable: true,
  fill: rgb(198, 218, 241),
  outset: 8pt,
  above: 24pt,
  below: 24pt,
  body,
)

#let innerproduct = (u, v) => $lr(angle.l #u, #v angle.r)$
#let norm = (u) => $lr(|| #u ||)$

= Séries de Fourier: Uma Abordagem 90% Completa

== Axiomas

Em Matemática, lidamos com coisas que não possuem forma definida, não podemos tocar, não podemos ao menos dizer se foram inventadas ou existem de fato. Costumamos chamá-las de *objetos*: variáveis, funções, conjuntos, anéis, corpos, matrizes, vetores.

Para definir-se objetos, precisamos de uma base, nem sempre concreta, formada por *teoremas* -- proposições provadas como verdadeiras, como o Teorema de Pitágoras e o Teorema Fundamental do Cálculo -- e *axiomas* -- o ponto mais profundo do raciocínio lógico, a base de todos os teoremas. Podemos definir os axiomas como estruturas formadas por:

- _Termos indefinidos_, palavras sem significado concreto. Ex.: reta, ponto, número;
- _Relações indefinidas_, conexões para os termos indefinidos, cuja veracidade não pode ser comprovada ou repudiada. Ex.: Dois pontos definem uma reta.

Você poderia supor que podemos comprovar o axioma euclidiano acima, bastando desenhar dois "pontos" em um pedaço de papel e ligá-los através de uma "reta". Você apenas estaria demonstrando o axioma. É fácil verificar isso, perguntando-se "o que é um ponto" ou "o que é uma reta" e observando que é impossível definir sem recair numa lógica cíclica...

== Vetores

O termo _vetor_ também é indefinido. Embora tenhamos aprendido com a Física que *vetores são ênuplas ordenadas de números reais, a quem chamamos escalares e que configuram as coordenadas de um vetor do espaço $RR^n$*. Essa é uma definição boa. *Agora jogue esta merda toda fora.*

Antes de pensarmos em vetores, vamos pensar numa questão rápida: se eu disser "$n$ é um número inteiro", o que isso quer dizer? Você pode começar a enumerar uma série de propriedades dos números inteiros e aplicá-las a $n$ para validá-lo como tal. Mas é importante que você saiba que a forma mais simples de dizer que $n$ é inteiro é afirmar que ele pertence ao conjunto dos números inteiros, isto é, $n in ZZ$. Todas as propriedades dos inteiros nada mais
são que axiomas e definições para construção do conjunto $ZZ$.

Com vetores é semelhante. Para dizer se algum objeto é um vetor, afirma-se que ele faz parte de um *espaço vetorial*, que é definido abaixo.

#defblock[
  Seja $V$ um espaço vetorial, $K$ um _corpo algébrico_ de escalares, ou seja, um conjunto de elementos que podem ser somados e multiplicados -- como o conjunto $RR$ --, $u, v, w in V$ e $alpha,beta in K$; temos os seguintes axiomas:

  - $u + v in V$ -- existe adição de vetores de $V$ e sua imagem está em $V$;
  - $(u + v) + w = u + (v + w)$ -- a adição é associativa;
  - $u + v = v + u$ -- a adição é comutativa;
  - $exists 0 | u + 0 = u$ -- existe um vetor, chamado _vetor nulo_ ou _vetor zero_, tal que, para todo vetor, quando adicionado resulta no próprio vetor;
  - $exists (-u) | u + (-u) = 0$ -- para voto vetor, existe um outro vetor cuja adição resulta no vetor zero;
  - $alpha u in V$ -- existe multiplicação de vetores de V por escalares em $K$ e sua imagem está em $V$;
  - $alpha (u + v) = alpha u + alpha v$ -- a multiplicação é distributiva em relação à adição de vetores;
  - $(alpha + beta) u = alpha u + beta u$ -- a multiplicação é distributiva em relação à adição de escalares;
  - $(alpha beta) u = alpha (beta u)$ -- a multiplicação é associativa;
  - $exists 1 | 1 u = u$ -- existe um escalar unitário tal que multiplicado por um vetor resulta no próprio vetor.
]

Observe que não há menção a coordenadas, espaços geométricos, produto vetorial ou qualquer outra coisa que já tenhamos ouvido falar sobre o $RR^n$. *Todas as propriedades que aprendemos até hoje referiam-se apenas a espaços vetoriais n-euclidianos*, isto é, espaços com dimensões finitas, semelhantes a espaços geométricos e com elementos formados por ênuplas de reais. Expandindo a nossa percepção, vemos que *matrizes de ordem $m times n$, polinômios, ênuplas ordenadas infinitas e funções reais também formam espaços vetoriais e são, portanto, vetores.* As funções reais como vetores são o foco de nosso estudo.

== Bases de um espaço vetorial

Se existem vetores $u_1$, $u_2$, ..., $u_n$ pertencentes ao espaço vetorial $V$ tais que todo vetor $v in V$ pode ser definido como a *combinação linear* destes vetores, isto é,

$ v = sum_(i=1)^n alpha_i u_i = alpha_1 u_1 + alpha_2 u_2 + ... + alpha_n u_n $

onde $alpha_1$, $alpha_2$, ..., $alpha_n$ são escalares, então estes vetores geram o espaço vetorial $V$. Se, além disso, estes vetores forem *linearmente independentes* -- $u_i$ não pode ser escrito como uma combinação dos demais vetores $u_j$ --, então este conjunto de vetores é uma *base* para o espaço vetorial *V*.

Quando lidávamos com $RR^n$, nós tinhamos contato com a *base canônica de $RR^n$*, o conjunto de vetores ${(1,0,0,...,0),(0,1,0,...,0),...,(0,0,0,...,1)}$. Note que o conhecemos por coordenadas dos vetores de $RR^n$ *são os coeficientes escalares da combinação linear dos vetores da base canônica*.

Uma propriedade interessante sobre as bases é que elas não são únicas. O espaço $RR^2$, por exemplo, pode ter como base tanto a canônica $B = {(1,0),(0,1)}$ quanto $B = {(sqrt(2),sqrt(2)),(-sqrt(2),sqrt(2))}$. Além disso, os coeficientes $alpha_1$, $alpha_2$, ..., $alpha_n$ da combinação linear dos vetores da base do espaço vetorial também são *coordenadas do espaço vetorial $K^n$*, onde $K$ é o conjunto dos escalares. Desta forma, se $v = sum_(i=1)^n alpha_i u_i = alpha_1 u_1 + alpha_2 u_2 + ... + alpha_n u_n$, onde $u_1, u_2, ..., u_n in B$, o *vetor das coordenadas de $v$*, pertencente ao espaço vetorial $K^n$, é denotado por

$ [v]_B = (alpha_1, alpha_2, ..., alpha_n) $

É importante notar que o espaço $V$ e o espaço $K^n$ são *isomorfos* ($V tilde.equiv K^n$), pois qualquer operação sobre um vetor em $V$ está relacionada com uma operação sobre um vetor de $K^n$, e vice-versa. Observe:

$ [u + v]_B = [u]_B + [v]_B $

$ [alpha u]_B = alpha [u]_B $

Este resultado é particularmente importante para nós, pois explica porque uma *equação subsidiária da Transformada de Fourier está relacionada à equação diferencial original: as funções dependentes de $omega$ são vetores de coordenadas das funções dependentes de $t$*. Em outras palavras, *extrair os coeficientes de Fourier equivale a descobrir o vetor de coordenadas de uma função numa base de dimensão infinita formada por senos e cossenos (ou exponenciais complexas)*.

== Produto interno

Talvez você esteja sentindo falta do *produto escalar*: $u dot v = sum_(i=1)^n u_i v_i$. Saiba de antemão que ele é uma operação definida apenas para $RR^n$. A sua definição para o espaço euclidiano complexo, $CC^n$, é diferente: $u dot v = sum_(i=1)^n u_i overline(v_i)$, onde $overline(v_i)$ é o conjugado do número complexo $v_i$. Eles são apenas alguns exemplos de *produtos internos*, denotados por $innerproduct(u, v)$, que são operações definidas para apenas alguns espaços vetoriais e *não são únicos*: para ilustrar isso, *o espaço vetorial das funções reais $f: (a,b) -> RR$ contínuas em (a, b) tem dois produtos internos comuns*:

$ innerproduct(u, v) = integral_a^b u(x) v(x) dif x $

e

$ innerproduct(u, v) = integral_a^b w(x) u(x) v(x) dif x $

Antes de explicar estes em específico, vamos ver o que define um produto interno.

#defblock[
  Seja $V$ um espaço vetorial, $K$ um _corpo algébrico_ de escalares, ou seja, um conjunto de elementos que podem ser somados e multiplicados -- como o conjunto $RR$ --, $u, v, w in V$ e $alpha in K$; temos os seguintes axiomas:

  - $innerproduct(u, v) in K$ -- o produto interno tem imagem em $K$;
  - $innerproduct(alpha u + beta v, w) = alpha innerproduct(u, w) + beta innerproduct(v, w)$ -- o produto interno é um operador linear;
  - $innerproduct(u, v) = innerproduct(v, u)$ -- o produto interno é comutativo;
  - $innerproduct(u, u) >= 0, innerproduct(u, u) = 0 <=> u = 0$ -- se o corpo $K$ for bem-ordenado (cada elemento precede e/ou sucede outro(s)), o produto interno entre um vetor e ele mesmo é maior que o vetor nulo, exceto quando o próprio vetor for nulo.
]

Todos os produtos internos que já vimos, sejam eles produtps escalares ou as integrais acima, têm essas propriedades.

== Uma outra abordagem para ênuplas ordenadas

Qual é o fundamento das integrais acima? Bom, digamos que *todo vetor de $K^n$  pode ser escrito como uma função discreta $f(i)$*, onde $i$ é um número natural. Assim, $f(1)$ é a primeira coordenada de uma ênupla de elementos de $K$, $f(2)$ é a segunda, e assim por diante. Assim, o produto escalar (produto interno), toma essa forma para vetores de $RR^n$:

$ u dot v = innerproduct(f(i), g(i)) = sum_(i=1)^n f(i) g(i) = sum_(i=0)^(n-1) f(1 + i Delta i) g(1 + i Delta i) Delta i $

Você deve estar se perguntando: o que é $Delta i$? Ele é um truque para entender *a diferença entre somas discretas e somas contínuas*. Em uma soma discreta, ele vale 1, porque a variável $i$ assume valores inteiros sucessivos. Quando tomamos o limite quando $Delta i$ tende a zero, temos a definição da *soma de Riemman, ou seja, uma integra definida* $integral_a^b f(i) g(i) dif i$, onde $a = 1$ e $b = a + (n - 1) Delta i$, onde, consequentemente, $n-1$ tende ao infinito.

Isso abre um leque de ideias. *Enquanto um vetor do $RR^n$ não possui "meiésima coordenada", uma função real tem.* Isso afirma ainda mais a ideia de que a Transformada de Fourier de uma função é um vetor de coordenadas, pois *agora sabemos ser possível a existência de coordenadas contínuas*.

== Norma, desigualdade de Cauchy-Schwarz, vetor unitário, ortogonalidade e projeções

Similarmente aos espaços euclidianos, podemos definir a *norma de um vetor* de um espaço vetorial *associado a um corpo de escalares númerico*: $norm(u) = sqrt(innerproduct(a, b)) $. Repare que *a voltagem RMS de um circuito elétrico é a norma da função que descreve a voltagem do circuito em relação ao tempo*. Sempre é bom ver lógica nos conceitos malucos do Eletromagnetismo!

Uma relação importante, cuja prova não darei aqui, é a *desigualdade de Cauchy-Schwarz*:

$ |innerproduct(u, v)| <= norm(u) norm(v) $

Se reescrevermos a relação como uma equação, teremos

$ |innerproduct(u, v)| = alpha norm(u) norm(v) $

$ alpha = (|innerproduct(u, v)|)/(norm(u) norm(v)) $

onde $alpha$ é igual ao cosseno do ângulo entre dois vetores euclidianos. Observação: embora esta relação tenha validade em espaços não-euclidianos, não existe "ângulo" entre vetores de espaços não-geométricos.

O *vetor unitário de $v$*, também conhecido como *versor de $v$*, é dado por

$ hat(v) = 1/(norm(v))v $

Dois vetores são ditos *ortogonais* se seu produto interno é nulo, $innerproduct(u, v) = 0$. O nome, obviamente, deriva dos espaços euclidianos, onde dois vetores ortogonais estão definidos sobre retas perpendiculares.

Unindo os conceitos apresentados acima, podemos definir o que é a *projeção de um vetor sobre outro*, $"proj"(v,u) = beta u$. O escalar $beta$ pode ser calculado da seguinte forma:

$ beta = norm(v) innerproduct(v, u)/(norm(v) norm(u)) = innerproduct(v, u)/(norm(u)) $

onde $norm(v)$ é a norma do vetor $v$ e $innerproduct(v,u)/(norm(v) norm(u))$ é o coeficiente da desigualdade de Cauchy-Schwarz. A equação completa para $"proj"(v, u)$ para qualquer $u$ (definimos o coeficiente acima para um vetor $u$ unitário) é

$ "proj"(v, u) = norm(v) innerproduct(v,u)/(norm(v) norm(u)) 1/(norm(u)) u = innerproduct(v,u)/(norm(u)^2) u $

Guarde bem esta equação, pois ela é indispensável no próximo tópico. Teremos a chave para entendermos o *desenvolvimento das séries de Fouries*.

== Ortogonalização de Gram-Schmidt

Também conhecido carinhosamente como "Schmidtão". Dado que $B = {b_1, b_2, ..., b_n}$ é uma *base ortogonal para $V$*, ou seja, um conjunto de vetores ortogonais entre sim com os quais podemos escrever todos os vetores de $V$ como combinações lineares deles, o *processo de ortogonalização de Gram-Schmidt* para o vetor $v$ é assim descrito:

$ v = sum_(i=1)^n "proj"(v, b_i) = sum_(i=1)^n innerproduct(v,b_i)/(norm(b_i)^2) b_i $

Isso nos dá outra visão das combinações lineares. Nelas, estamos somando todas as projeções de um vetor sobre outros vetores.

== Enfim, nos Fouriermos

Agora, *vamos pegar tudo o que aprendemos e aplicar em espaços vetoriais de funções reais periódicas*. Vamos supor que $V$ seja o espaço vetorial das funções reais periódicas com período $T$, associado ao corpo de escalares dos números reais (pois as coordenadas contínuas dos vetores em $V$ são números reais). Agora, vamos supor que desejamos ortogonalizar (pelo Schmidtão) uma função $f: RR -> RR$, cuja variável independente é $t$. Para descrever uma $f(t)$ ortogonalizada, precisamos de uma base ortogonal para o espaço vetorial $V$. *Mas qual base usar? Que tal senos e cossenos?*

Independente do tamanho do período $T$ em que $f(t)$ está definida, as funções $sin(omega t)$ e $cos(omega t)$ serão contínuas também em $T$. Além disso, elas são ortogonais *para valores discretos de $omega$*, pois vemos que facilmente as integrais

$ innerproduct(sin(omega_m t), sin(omega_n t)) = integral_(-T/2)^(T/2) sin(omega_m t) sin(omega_n t) dif t = 0 $

para $omega_m != omega_n$, e

$ innerproduct(sin(omega_m t), cos(omega_n t)) = integral_(-T/2)^(T/2) sin(omega_m t) cos(omega_n t) dif t = 0 $

quando tomamos $omega = (2pi n)/T$, onde $n$ inteiro.

Em resumo, a nossa base é o conjunto ${sin(omega t) | omega = (2pi n)/T} union {cos(omega t) | omega = (2pi n)/T}$. Diferentemente das bases que vimos anteriormente, esta é infinita. Mas não se preocupe, pois o processo de ortogonalização é válido para espaços de dimensão infinita, só precisamos fazer um pequeno ajuste:

$ v = sum_(i=0)^infinity "proj"(v, b_i) = sum_(i=0)^infinity innerproduct(v,b_i)/(norm(b_i)^2) b_i $

Também está incluída nesta fórmula uma coordenada zero, pois $sin(0 t)$ e $cos(0 t)$ também fazem parte da nossa base. Já dá para ter uma ideia de onde vamos parar, não é?

Dados os vetores $sin((2pi n)/T t)$ e $cos((2pi n)/T t)$, vamos calcular $"proj"(f(t), sin((2pi n)/T t))$ e $"proj"(f(t), cos((2pi n)/T t))$:

$ "proj"(f(t), sin((2pi n)/T t)) = innerproduct(f(t), sin((2pi n)/T t))/(norm(sin((2pi n)/T t))^2) sin((2pi n)/T t) $

$ norm(sin((2pi n)/T t))^2 = integral_(-T/2)^(T/2) sin((2pi n)/T t) sin((2pi n)/T t) dif t = T/2 $

$ innerproduct(f(t), sin((2pi n)/T t)) = integral_(-T/2)^(T/2) f(t) sin((2pi n)/T t) dif t $

$ "proj"(f(t), sin((2pi n)/T t)) = 2/T [integral_(-T/2)^(T/2) f(t) sin((2pi n)/T t) dif t] sin((2pi n)/T t) $

Veja! Chegamos até uma daquelas integrais que tanto nos massacraram na cadeira de Equações Diferenciais! Seguindo o mesmo raciocínio, é fácil ver que

$ "proj"(f(t), cos((2pi n)/T t)) = 2/T [integral_(-T/2)^(T/2) f(t) cos((2pi n)/T t) dif t] cos((2pi n)/T t) $

Para darmos o xeque-mate,

$ f(t) = sum_(n=0)^infinity [ "proj"(f(t), sin((2pi n)/T t)) + "proj"(f(t), cos((2pi n)/T t)) ] $

Se assumirmos que $A(n) = 2/T [integral_(-T/2)^(T/2) f(t) sin((2pi n)/T t) dif t]$ e $B(n) = 2/T [integral_(-T/2)^(T/2) f(t) cos((2pi n)/T t) dif t]$

$ f(t) = sum_(n=0)^infinity [A(n) sin((2pi n)/T t) + B(n) cos((2pi n)/T t)] $

Temos então as equações que tanto conhecemos e amamos...

== Uma palavra amiga para os perdidos

Veja que separamos $A(n)$ e $B(n)$. Como esta é uma revisão simplista das séries de Fourier, o sentido destas funções não aparenta ser muito claro. Para um rápido exercício, veja que $n$ é um número natural. Se o considerássemos inteiro, teríamos uma destas funções definida para $n <= 0$ e a outra para $n >= 0$, onde poderíamos vê-las como uma única função. De fato, *o desenvolvimento mais correto para séries de Fourier usa como base as exponenciais complexas, $e^(-i omega t)$*, que também são todas ortogonais. Também podem ser usadas como base *as funções de Bessel, os polinômios de Legendre etc.* Contudo, reescrevendo a ortogonalização com exponenciais teríamos

$ f(t) = sum_(n=-infinity)^(infinity) C(n) e^(i omega t) $

e ficaria evidente que $C(n)$ é o vetor de coordenadas de $f(t)$ numa base de exponenciais complexas, mais conhecido como *espectro da função $f(t)$*. Observe també que essa base é discreta, pois os valores de $omega$ são discretos. Se assumirmos um $omega$ contínuo, a própria combinação linear torna-se contínua, e então temos

$ f(t) = integral_(-infinity)^(infinity) "proj"(f(t),e^(i omega t)) dif omega = integral_(-infinity)^(infinity) F(omega) e^(i omega t) dif omega $

onde $F(omega)$ é a *transformada de Fourier da função $f(t)$*, que também é, por consequência, um *vetor de coordenadas contínuo*. Pelo isomorfismo entre o espaço vetorial que contém $f(t)$ e o espaço vetorial que contém $F(omega)$, cada operação feita sobre $F(omega)$ afeta $f(t)$. Por isso é interessante resolvermos equações envolvendo $f(t)$ no espaço vetorial de $F(omega)$, através de uma equação subsidiária.

== The End

No fim das contas, esse bicho de sete cabeças chamado Séries de Fourier não passa de um Schmidtão enrustido.

Os próximos passos que devo executar para obter um entendimento pleno sobre o assunto são:

- Trabalhar diretamente com as exponenciais;
- *Verificar porque as exponenciais geram uma base para as funções reais*;
- Trabalhar com a Transformada de Fourier como um vetor de coordenadas.
