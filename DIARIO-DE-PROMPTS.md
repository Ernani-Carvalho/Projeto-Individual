# Diário de Prompts

Onde eu anoto cada vez que usei IA no projeto.

## dd/mm/aaaa - assunto

- IA:
- Pedi:
- Ela fez:
- Usei:
- Mudei:
- Link:

## 28/10/2026 - site só para PC

- IA: Claude Code
- Pedi: tirar tudo que era pensado para celular, porque o site vai ser aberto só no PC.
- Ela fez: tirou a linha `<meta name="viewport">` do HTML e os blocos `@media` do CSS (as regras que só valiam para tela pequena), no `home.html`/`home.css` e em todas as páginas do protótipo. Também tirou o `flex-wrap` dos botões do topo e os comentários que falavam de celular. As outras regras do CSS continuaram iguais.
- Usei:
- Mudei:
- Link:

## 28/10/2026 - comentários de anotação no home.html e home.css

- IA: Claude Code
- Pedi: deixar o código da página inicial bem comentado, com comentários do jeito de anotação, nada profissional, para eu entender depois quando for olhar o codigo novamente o que cada parte faz sem esquecer detalhes. Depois pedi para tirar as linhas de `=====`.
- Ela fez: escreveu comentários no `home.html` e no `home.css` sem mudar nenhuma linha de código. No HTML, cada parte da página tem um comentário curto dizendo o que aparece ali (por que os links estão sem `href`, de onde vão vir os números), e o JavaScript ficou comentado passo a passo (o vetor, o `for`, o `innerHTML +=` e o `${}`). No CSS, cada parte começa com um comentário simples, cada cor do `:root` diz onde é usada e cada recurso mais diferente (`sticky`, `skewX`, `::before`, `:nth-child`, `background-clip`, `aspect-ratio`, `@media`...) tem uma explicação do que faz.
- Usei:
- Mudei:
- Link:
