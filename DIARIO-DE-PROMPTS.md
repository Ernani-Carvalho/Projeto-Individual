# Diário de Prompts

Onde eu anoto cada vez que usei IA no projeto.

## dd/mm/aaaa - assunto

- IA:
- Pedi:
- Ela fez:


## 28/10/2026 - logo e nome no README

- IA: Claude Code
- Pedi: atualizar o README com a logo e o nome do site.
- Ela fez: colocou a logo FirstRun no topo do README (a versão com fundo escuro, salva em `assets/logo/logo-firstrun.png`, porque a de fundo transparente fica difícil de ler no GitHub claro), trocou o `[PREENCHER: nome do site]` por "FirstRun" e usou o nome no texto da ideia. Também corrigiu duas partes que estavam desatualizadas: a lista da página inicial ainda falava de "indies brasileiros" e a da dashboard falava de gráficos que eu já tinha tirado.

## 01/11/2026 - Alteração na cor de fundo da tela de login
- IA: openCode
- Pedi: Deixe a cor de fundo da tela de login em tom de degradê com as cores do projeto (azul e amarelo).
- Ela fez: Alterou a tela de login para um degradê de azul para amarelo.

## 01/11/2026 - Idealização do banco de dados do projeto
- IA: Claude
- Pedi: Para toda a ideia desse projeto como seria o banco de dados? não crie nenhum arquivo, apenas me ajude a idealizar como será o funcionamento e estrutura dele no projeto. Me fazendo perguntas para que possa acompanhar a idealização.
- Ela fez: Me auxiliou no desenvolvimento da ideia do banco de dados do projeto para que ficasse de acordo com a ideia.

## 04/11/2026 - navbar igual e login e cadastro sem rolagem

- IA: Claude Code
- Pedi: deixar a navbar igual em todas as páginas e tirar a rolagem do login e do cadastro.
- Ela fez: descobriu que a navbar do login estava 15px deslocada porque só ele não tinha barra de rolagem, e colocou `scrollbar-gutter: stable` no `home.css`. No `login.css`, deu a altura da tela ao `body` com `overflow: hidden`, centralizou a caixa e diminuiu espaços e fontes para caber. Recortou de novo as duas imagens para o novo tamanho do painel.

## 04/11/2026 - efeitos simples na home

- IA: Claude Code
- Pedi: colocar alguns efeitos simples na home para deixar a página mais dinâmica.
- Ela fez: colocou no fim do `home.css` a borda azul nos cartões ao passar o mouse, a troca de cor dos botões e o topo da página aparecendo aos poucos com `@keyframes`, sem nada se mexer de lugar.
