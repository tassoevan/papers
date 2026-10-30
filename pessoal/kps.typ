#set document(title: [O que diabos é o $K_(P S)$?], author: "Tasso Evangelista")
// Geometria da classe article do LaTeX em A4, 10pt
#set page(paper: "a4", margin: (left: 124.8pt, right: 126.9pt, top: 130pt, bottom: 120pt))
#set text(lang: "pt", font: "New Computer Modern", size: 9.96pt)
#set par(justify: true, leading: 5.15pt, spacing: 5.15pt, first-line-indent: (amount: 14.94pt, all: true))
#set math.equation(numbering: "(1)")
#show math.equation.where(block: true): set block(above: 11.9pt, below: 11.9pt)
#show math.equation: set text(font: "New Computer Modern Math")

// Equação destacada sem número, como \[ … \]
#let semnum(body) = math.equation(block: true, numbering: none, body)

#align(center, text(size: 24.8pt)[O que diabos é o $K_(P S)$?])
#v(5.8pt)

Dada a dificuldade de entendimento desde nosso último colóquio, venho por meio deste documento, estimado amigo André, lhe dizer que achei uma definição matemática simplificada para o $K_(P S)$, que demonstrarei agora.

Primeiramente algumas convenções: dado um sólido iônico denominado $A B$, cujos íons dissolvidos em meio aquoso são $A$ e $B$, tem-se que a reação $R$ de dissociação iônica:

$ R: n A B_((s)) --> p A_((a q)) + q B_((a q)) $

onde $n$, $p$ e $q$ são os coeficientes estequiométricos de $A B$, $A$ e $B$, respectivamente. Do mesmo modo, tem-se a reação inversa $R'$:

$ R': p A_((a q)) + q B_((a q)) --> n A B_((s)) $

Definidas as reações, pelas teorias de Cinética Química, sabe-se que $R$ e $R'$ têm diferentes velocidades de reação, que chamaremos de $v_R$ e $v_(R')$. É importante definir que o conceito de velocidade nos foi ensinado baseado na concentração dos reagentes, não só pelo objetivo prático, mas também pela didática, uma vez que não tínhamos conhecimento do conceito de *atividade*. Se utilizarmos a atividade no lugar da concentração nas equações que vimos em Química Geral Teórica, temos:

$ V_R = k_R dot a_(A B)^n $

onde $k_R$ é a constante cinética da reação $R$ e $a_(A B)$ a atividade do sólido iônico $A B$. Fazemos o mesmo na definição da velocidade de $R'$:

$ V_(R') = k_(R') dot a_A^p dot a_B^q $

lembrando que $k_R != k_(R')$.
Agora, acrescentaremos a definição de *equilíbrio químico*: uma reação encontra-se em equilíbrio quando a sua velocidade é igual à velocidade de sua reação inversa.

$ V_R = V_(R') divides t = t_(e q) $

Feito isso, podemos começar a nossa dedução. Ou como diria o Halliday, nosso _algebrismo_.

#semnum($k_R dot a_(A B)^n = k_(R') dot a_A^p dot a_B^q$)
#semnum($k_R / k_(R') = (a_A^p dot a_B^q) / a_(A B)^n$)

A partir daqui, já podemos definir o $K_(P S)$. (dancinha feliz)

$ K_(P S) = k_R / k_(R') $

#semnum($K_(P S) = (a_A^p dot a_B^q) / a_(A B)^n$)

Simplificando, temos que sólidos têm atividade igual a um e podemos, em meio aquoso, definir as atividades dos íons como iguais às suas concentrações. Logo,

#semnum($a_(A B) = 1$)
#semnum($a_A = [A]$)
#semnum($a_B = [B]$)
$ K_(P S) = [A]^p [B]^q $

Bingo! Matei a charada. O glorioso $K_(P S)$ está relacionado às constantes cinéticas, não às concentrações, como aparenta. Interpretar $K_(P S)$ como o pro-?duto das concentrações dos íons aquosos é um artifício matemático (gambiarra) muito utilizado por químicos (vagabundos). E só pra terminar de te dar nos dedos, não usei o guia de Alquimia do Atkins, todo colorido e fru-fru, mostrando reações-sorvetão. Usei um livro de macho, o Química Geral Volume 2 do John B. Russell.
