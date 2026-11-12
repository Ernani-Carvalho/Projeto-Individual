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

- IA: OpenCode
- Pedi: deixar a navbar igual em todas as páginas e tirar a rolagem do login e do cadastro.
- Ela fez: descobriu que a navbar do login estava 15px deslocada porque só ele não tinha barra de rolagem, e colocou `scrollbar-gutter: stable` no `home.css`. No `login.css`, deu a altura da tela ao `body` com `overflow: hidden`, centralizou a caixa e diminuiu espaços e fontes para caber. Recortou de novo as duas imagens para o novo tamanho do painel.

## 04/11/2026 - efeitos simples na home

- IA: OpenCode
- Pedi: colocar alguns efeitos simples na home para deixar a página mais dinâmica.
- Ela fez: colocou no fim do `home.css` a borda azul nos cartões ao passar o mouse, a troca de cor dos botões e o topo da página aparecendo aos poucos com `@keyframes`, sem nada se mexer de lugar.

## 04/11/2026 - DER atualizado

- IA: Claude Code
- Pedi: atualizar o DER, depois das mudanças no script do banco.
- Ela fez: atualizou as tabelas do DER.


## 06/11/2026 - documento de passagem e AGENTS.md

- IA: Claude Code
- Pedi: um documento com tudo o que foi feito no projeto neste chat, principalmente na API, para continuar em outro chat, e tirar do AGENTS.md o que não faz sentido na faculdade, como a regra da senha no `.env.dev`.
- Ela fez: criou o documento "FirstRun: resumo de tudo o que foi feito (para continuar em outro chat)" com estado atual, API, banco, páginas, imagens, histórico, regras e próximos passos. No AGENTS.md, tirou as regras sobre não escrever senha, avisou que o `.env.dev` vai para o GitHub, trocou a porta para 3334 e explicou que a API precisa ser reiniciada depois de mudanças em `src/`.

## 11/11/2026 - resumo salvo no projeto

- IA: Claude Code
- Pedi: deixar o documento com o que foi feito disponível para baixar, porque não achei ele no meu PC.
- Ela fez: explicou que o documento estava salvo só no claude.ai e criou uma cópia em Markdown, o `RESUMO-PARA-OUTRO-CHAT.md`, na raiz do projeto.

## 11/11/2026 - rotas da API, uma por vez

- IA: Claude Code
- Pedi: Com base nos documentos da API web-data-viz, crie as rotas necessárias para o projeto funcionar de ponta a ponta.
  Como quero que você trabalhe:
  Crie uma rota por vez e espere eu confirmar que entendi antes de passar para a próxima.
  Em cada rota, explique o caminho completo que ela percorre no projeto e o papel de cada arquivo envolvido.
  Siga o mesmo padrão e a mesma estrutura que a web-data-viz já usa.
- Ela fez: [PREENCHER]

## 11/11/2026 - lacunas e inconsistências do projeto

- IA: Claude Code
- Pedi: Analise meu projeto individual e identifique as lacunas e inconsistências, tanto na ideia do projeto quanto no código.
  Não altere nenhum arquivo. Só liste o que encontrar, para eu analisar e decidir o que é pertinente.
  Para cada item da lista, informe:
  Onde está: o arquivo e o trecho, ou a parte da ideia.
  Qual é o problema: a lacuna ou a inconsistência.
  Separe a lista em duas partes: Ideia e Código.
- Ela fez: [PREENCHER]
