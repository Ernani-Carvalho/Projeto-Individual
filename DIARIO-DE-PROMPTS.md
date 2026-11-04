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

## 04/11/2026 - imagens no login e no cadastro

- IA: Claude Code
- Pedi: colocar uma imagem de Ori no lado do degradê do cadastro e uma de Hollow Knight no do login, melhorando a qualidade e ajustando o tamanho, com os arquivos salvos no projeto.
- Ela fez: criou `assets/login/fundo-login.jpg` a partir da versão original da imagem (2560x1440, no lugar da de 250px do link) e `assets/login/fundo-cadastro.jpg`, os dois recortados para o formato do painel. No `login.css`, trocou as manchas de luz por essas imagens com um degradê escuro por cima, para o texto continuar legível. Tirou o ícone do controle do painel do login e deixou os textos do painel em cor mais clara.
- Usei:
- Mudei:
- Link:

## 04/11/2026 - navbar igual e login e cadastro sem rolagem

- IA: Claude Code
- Pedi: deixar a navbar igual em todas as páginas e tirar a rolagem do login e do cadastro.
- Ela fez: descobriu que a navbar do login estava 15px deslocada porque só ele não tinha barra de rolagem, e colocou `scrollbar-gutter: stable` no `home.css`. No `login.css`, deu a altura da tela ao `body` com `overflow: hidden`, centralizou a caixa e diminuiu espaços e fontes para caber. Recortou de novo as duas imagens para o novo tamanho do painel.
- Usei:
- Mudei:
- Link:

## 04/11/2026 - CSS simplificado

- IA: Claude Code
- Pedi: deixar o CSS de todas as páginas o mais simples e curto possível, sem animações como a caixinha que se mexe.
- Ela fez: reescreveu o `home.css` e o `login.css` (de 720 para 454 linhas), juntando regras repetidas dos cartões e tirando animações, efeitos de hover, degradês e variáveis sem uso. A linha do tempo virou uma coluna só. O escurecido do login e do cadastro passou para dentro das imagens, e a classe `area-login` saiu dos dois HTML.
- Usei:
- Mudei:
- Link:

## 04/11/2026 - efeitos simples na home

- IA: Claude Code
- Pedi: colocar alguns efeitos simples na home para deixar a página mais dinâmica.
- Ela fez: colocou no fim do `home.css` a borda azul nos cartões ao passar o mouse, a troca de cor dos botões e o topo da página aparecendo aos poucos com `@keyframes`, sem nada se mexer de lugar.
- Usei:
- Mudei:
- Link:

## 04/11/2026 - hover só no que é clicável

- IA: Claude Code
- Pedi: deixar o hover só no que vai ser clicável.
- Ela fez: tirou do `home.css` o hover e a transição dos cartões. O hover ficou só nos links da navbar e nos botões.
- Usei:
- Mudei:
- Link:

## 04/11/2026 - hover nos cartões de recomendação

- IA: Claude Code
- Pedi: colocar hover nos cartões de "Um indie para cada tipo de jogador", porque eles vão ser clicáveis.
- Ela fez: colocou no `home.css` a borda azul e o cursor de mãozinha nesses cartões. O clique em si ainda não existe.
- Usei:
- Mudei:
- Link:
