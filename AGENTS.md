# AGENTS.md

Regras para qualquer IA que for mexer neste projeto. Leia tudo antes de alterar alguma coisa.

## O projeto

Este é o meu projeto individual de Pesquisa e Inovação (PI), do 1º semestre de Análise e Desenvolvimento de Sistemas na SPTech. O site se chama FirstRun e o tema é jogos indie.

Quem joga indie passa por muitos jogos e não tem um lugar para guardar o que já jogou, até onde chegou e o que achou de cada luta. O site junta isso. Nele dá para:

- conhecer o tema na página inicial;
- ler a página "Sobre mim", com uma dedicatória;
- ver o catálogo e a página de cada jogo, com a filosofia, quem criou, o país de origem e os bosses (textos fixos no código);
- criar conta e entrar;
- registrar o progresso: horas em cada jogo, status (jogando, zerado ou pausado), bosses derrotados, tentativas e dificuldade de 1 a 5;
- ver o perfil com o resumo;
- acompanhar tudo numa dashboard com gráficos (Chart.js) e indicadores.

Só existe um tipo de usuário: o jogador. O perfil e a dashboard mostram só os dados de quem está logado. A página inicial mostra números de todos os jogadores, e a página de cada jogo mostra a média de tentativas de todos em cada boss.

O projeto é da faculdade e não vai para produção.

### O que o professor pede

- Desafio: site com cadastro, tema que me representa, HTML, CSS, validações em JavaScript e a API em Node.js (web-data-viz) para cadastrar e consultar no banco.
- Tecnologia da Informação: documento do projeto (eu faço), Trello e Git com commits pequenos e frequentes.
- Banco de Dados: modelo lógico, relacionamentos e comandos SQL.
- Algoritmos: variáveis, funções, contas, condicionais, repetições e vetores.
- Arquitetura de Computadores e Matemática: totais, médias e porcentagens.
- Introdução aos Sistemas Operacionais: uma VM Linux só com o banco.
- Pesquisa e Inovação: contexto, planejamento, dashboard e indicadores.
- Socioemocional: página "Sobre mim" e a apresentação final (quando o interesse por indies começou, meus valores no projeto, a maior dificuldade, a maior superação e a quem sou grato).

O README é só a vitrine no GitHub, curta. Nada de requisitos do professor, cronograma ou Socioemocional nele. Isso fica no documento do projeto, que eu faço.

## O que não vai ser feito

Não crie nada disto, mesmo que apareça no protótipo antigo:

- comentários ou conversa entre usuários;
- conta de desenvolvedor ou outro tipo de usuário;
- jogos cadastrados pelo usuário (o catálogo é fixo e vem do script do banco).

## Tecnologias

- HTML, CSS e JavaScript no site. A API também é em JavaScript.
- MySQL numa VM Linux que só tem o banco.
- web-data-viz: a API da faculdade, com Node.js, express, mysql2 e dotenv.
- Chart.js para os gráficos, carregado direto no HTML.

Não tem sensor nem Arduino. Não use nada fora dessa lista.

## Comandos

Git:

- `git pull` antes de começar.
- `git add .`, `git commit -m "tipo: descrição curta"` e `git push` para enviar.

Site, dentro de `web-data-viz`:

- `npm install` na primeira vez ou quando o `package.json` mudar.
- `npm start` para ligar. O site abre em `http://localhost:3334` (o `APP_PORT` do `.env.dev` é 3334 porque o VirtualBox ocupa a 3333).
- `Ctrl + C` para desligar.
- Depois de mudar qualquer arquivo em `src/` ou o `app.js`, a API precisa ser desligada e ligada de novo. Mudanças em `public/` só pedem recarregar a página.

Nunca rode `npm audit fix`. As versões foram travadas pela faculdade.

Banco, na VM:

- O MySQL fica numa VM Lubuntu, no VirtualBox. O site e a API não rodam nela.
- A rede da VM fica em NAT, com redirecionamento de porta TCP: 3307 na minha máquina vai para 3306 na VM. Uso 3307 para não bater com o MySQL da minha máquina.
- Eu me conecto em `127.0.0.1`, porta `3307`. O IP da VM não é usado.
- No terminal: `mysql -u usuario -p -h 127.0.0.1 -P 3307`.
- No `.env.dev`: `DB_HOST` = `127.0.0.1`, `DB_PORT` = `3307`, `DB_DATABASE` = `firstrun` e o usuário e a senha do banco. O `.env.dev` vai para o GitHub, porque os professores precisam ver.
- O script fica em `web-data-viz/src/database/script-tabelas.sql`. Se o banco já existir, ele precisa ser apagado antes de rodar o script de novo.
- A mesma VM tem o banco do projeto em grupo. Os usuários deste projeto só recebem `GRANT` no banco `firstrun`.
- A API só precisa de `SELECT`, `INSERT` e `UPDATE`. O usuário dela não usa `DELETE`.
- Ordem no dia a dia: ligar a VM, ver se o Workbench conecta e só depois rodar `npm start`.

## Pastas

- `AGENTS.md`, `README.md` e `DIARIO-DE-PROMPTS.md`.
- `docs/`: `modelo-logico.mwb` (o DER no Workbench) e `modelo-logico.png`.
- `testes/`: coisas só minhas, no `.gitignore` (PDFs das aulas, prompts e o protótipo). Os textos antigos dos jogos estão em `testes/dados-dos-jogos.md`.
- `web-data-viz/`: o projeto de verdade.
  - `app.js`: liga o servidor e registra as rotas.
  - `.env.dev`: acesso ao banco da VM. `.env` é o banco remoto e não é usado.
  - `DOCUMENTOS_DE_APOIO/`: tutoriais da faculdade.
  - `public/`: as páginas, `css/`, `js/` e `assets/`.
  - `src/routes/`: os caminhos da API.
  - `src/controllers/`: recebem os dados, validam e chamam o model.
  - `src/models/`: montam o SQL e mandam executar.
  - `src/database/`: `config.js` e `script-tabelas.sql`.

Imagens em `public/assets/`:

| Pasta | O que tem |
| --- | --- |
| `jogos/` | Capas em pé (600x900) |
| `cenarios/` | Artes largas de cada jogo, com o mesmo nome de arquivo da capa |
| `bosses/` | Imagem de cada boss, em PNG |
| `fundo/` | `fundo-de-capas.jpg`, a imagem com as capas de todos os jogos inclinadas |
| `login/` | Fundo do painel do login e do cadastro |
| `icones/` | Ícones de perfil, dashboard e controle |
| `logo/` | Logo e favicon |

O site sempre usa arquivos locais, nunca link de imagem da internet.

Os arquivos de aquário, empresa, medida e aviso são do AquaTech, o exemplo da faculdade, e servem de modelo. Eu já apaguei as imagens do AquaTech de propósito, porque o simulador, o `estilo.css` e a dashboard antiga não vão ser usados. Não restaure esses arquivos, e também não apague outros sem me perguntar.

### Caminho de uma requisição

Usando o login como exemplo:

1. O jogador preenche `public/login.html`.
2. O JavaScript faz `fetch` com `POST` para `/usuarios/autenticar`, mandando `emailServer` e `senhaServer`.
3. O `app.js` passa para `src/routes/usuarios.js`.
4. A rota chama `autenticar` no `usuarioController.js`.
5. O controller pega os dados do `req.body`, confere e chama o `usuarioModel.js`.
6. O model monta o `SELECT` em `instrucaoSql` e roda com `database.executar()`.
7. A resposta volta pelo mesmo caminho. Se deu certo, a página guarda `NOME_USUARIO`, `EMAIL_USUARIO` e `ID_USUARIO` no `sessionStorage`.

As páginas logadas (`perfil.html` e `registrar.html`) carregam o `js/sessao.js` e chamam `validarSessao()` ao abrir, que coloca o nome do jogador no elemento `b_usuario` (no perfil, dentro da caixa do topo). O "Sair" chama `limparSessao()`.

Nas outras páginas, o `<div class="menu-usuario" id="div_menu_usuario">` começa com "Entrar" e "Criar conta". A função `montarMenu()`, escrita no script de cada página, troca esses links por Registrar, Perfil, Dashboard e Sair quando existe `sessionStorage.ID_USUARIO`. O Dashboard ainda é só texto, sem link.

Tudo que for novo segue o mesmo caminho: página, `fetch`, rota, controller, model e banco.

### Rotas

| Arquivo | Rotas | Situação |
| --- | --- | --- |
| `usuarios.js` | `POST /usuarios/cadastrar`, `POST /usuarios/autenticar` | Pronto |
| `jogos.js` | `GET /jogos/medias/:idJogo` (média de tentativas) e `GET /jogos/bosses/:idJogo` (bosses do jogo, para o registrar) | Pronto |
| `progressos.js` | `POST /progressos/jogo`, `POST /progressos/boss`, `GET /progressos/jogos/:idUsuario`, `GET /progressos/bosses/:idUsuario` | Pronto |
| `indicadores.js` | `GET /indicadores/gerais` (números gerais da home: jogadores, horas, bosses derrotados e jogos) | Pronto. Os da dashboard faltam (confirmar comigo) |

Arquivos seguem o padrão: rota no plural (`jogos.js`), controller e model no singular (`jogoController.js`, `jogoModel.js`). Rota nova entra no `app.js` em dois lugares: o `require` e o `app.use`. Busca usa `router.get` e gravação usa `router.post`. Antes de criar, olhe os arquivos de usuário e de jogo.

### Dados da dashboard

A página faz `fetch` para uma rota com o `ID_USUARIO`. O model faz as contas no `SELECT` (`SUM`, `COUNT`, `AVG` e `GROUP BY`). A página percorre o JSON com `for`, faz o que faltar (como porcentagens) e monta os gráficos com Chart.js. Os selects de cada parte já estão no fim do `script-tabelas.sql`.

## Banco de dados

| Tabela | Colunas |
| --- | --- |
| `usuario` | `id`, `nome`, `email` (unique), `senha` |
| `jogo` | `id`, `nome`, `imagem` |
| `boss` | `id`, `nome`, `fk_jogo` |
| `progresso` | `id`, `fk_usuario`, `fk_jogo`, `horas`, `status` |
| `boss_derrotado` | `id`, `fk_usuario`, `fk_boss`, `tentativas`, `dificuldade` |

- `jogo.imagem` é só o nome do arquivo: a capa fica em `assets/jogos/` e o cenário em `assets/cenarios/`.
- Filosofia, criador, país, ficha e imagens dos bosses não ficam no banco. Eles ficam escritos direto na página de cada jogo, em `public/jogos/`.
- As tabelas `jogo` e `boss` existem porque `progresso` e `boss_derrotado` dependem delas.
- O id de cada jogo e a ordem dos bosses precisam ser iguais no script e nas páginas: o parágrafo da média de cada boss tem o id dele no banco (`p_media_1`, `p_media_2`...).
- Cada boss aparece uma vez só. Outra forma ou versão mais forte do mesmo boss não entra (por exemplo, Absolute Radiance).
- `progresso` e `boss_derrotado` têm `UNIQUE` para o jogador ter uma linha só por jogo e por boss. Registrar de novo vira `UPDATE`.
- `CHECK`: horas maior ou igual a 0, status `jogando`, `zerado` ou `pausado`, tentativas maior ou igual a 1 e dificuldade de 1 a 5.

Relacionamentos:

- `jogo` 1:N `boss`.
- `usuario` N:N `jogo`, pela tabela `progresso`.
- `usuario` N:N `boss`, pela tabela `boss_derrotado`.

Contas do site:

- total de horas: `SUM(horas)`;
- jogo mais jogado: `ORDER BY horas DESC LIMIT 1`;
- média de tentativas de cada boss: `ROUND(AVG(tentativas))`;
- conclusão de cada jogo: bosses derrotados ÷ total de bosses × 100, com `.toFixed()`;
- comparação com a média: (valor do jogador − média de todos) ÷ média × 100.

Indicadores da dashboard: total de horas, jogos cadastrados, bosses derrotados, jogo mais jogado, boss mais difícil, conclusão de cada jogo, jogos por status e comparação com a média.

Se mudar uma tabela, o DER em `docs/` também precisa ser refeito.

## Páginas

Todas em `web-data-viz/public/`.

| Página | Arquivo | CSS | Situação |
| --- | --- | --- | --- |
| Início | `index.html` | `home.css` | Pronta |
| Catálogo | `jogos.html` | `jogos.css` | Pronta |
| Jogos | `jogos/hollow-knight.html`, `jogos/hades.html` e as outras (uma por jogo) | `jogos.css` | Prontas |
| Login | `login.html` | `login.css` | Pronta |
| Cadastro | `cadastro.html` | `login.css` | Pronta |
| Sobre mim | `sobre.html` | `sobre.css` | Falta (textos meus, `[PREENCHER]`) |
| Perfil | `perfil.html` | `perfil.css` | Pronta (o login vem para cá) |
| Registrar | `registrar.html` (no lugar do antigo `simulador.html`) | `perfil.css` | Pronta |
| Dashboard | `dashboard/dashboard.html` | `dashboard.css` | Falta (hoje é o arquivo do AquaTech) |

O `home.css` também tem a parte geral (cores, cabeçalho, botões), então todas as páginas carregam ele. O `estilo.css` é do AquaTech e não é usado nas minhas páginas.

Como as coisas funcionam:

- O texto fixo fica no HTML ou num vetor no `<script>` da página. O que vem do banco é montado com `for` e `innerHTML +=` depois do `fetch`.
- Só usa `fetch` o que muda conforme os jogadores usam o site. Na página de cada jogo, isso é só a média de tentativas.
- O catálogo e as páginas dos jogos são HTML fixo, com links normais (`<a href>`). Nada de `sessionStorage` ou `window.location` para abrir um jogo.
- Jogo novo = uma página nova em `public/jogos/`, um cartão no `jogos.html`, as imagens em `assets/` e as linhas no script do banco.
- Fundo padrão: a imagem `fundo-de-capas.jpg` presa na tela. Quando entrar um jogo novo, essa imagem precisa ser refeita.
- Fundo do catálogo: cada cartão tem o cenário escondido com `opacity: 0`, e o `:hover` do cartão mostra ele.
- Fundo da página do jogo: o cenário do jogo fica fixo no lugar da imagem padrão.
- Login e cadastro não têm rolagem (`overflow: hidden` no `body`).

Ainda sobre o que falta fazer, o protótipo em `testes/prototipo/` mostra a ideia de cada página. Ele é só para estudo: não copie o código dele. Imagens podem vir de lá. Alguns jeitos de fazer:

- trocar conteúdo: botões com `onclick` que trocam o `innerHTML` a partir de um vetor;
- busca: `oninput`, `for`, `.toLowerCase()` e `.includes()`;
- escolhas no Registrar (jogo, status, boss e dificuldade): botões com `onclick` que guardam a escolha numa variável e montam os botões de novo marcando o escolhido com a classe `opcao-escolhida` (sem `onchange` e sem `radio`). Já está feito assim no `registrar.html`;
- mostrar e esconder: `style.display`;
- ordenar: `ORDER BY` no banco (`.sort()` é proibido);
- maior valor: `for` com `if`;
- tabelas: `div`s com Grid ou Flexbox (`<table>` é proibido);
- gráficos: Chart.js no formato da web-data-viz, `bar` para horas e `doughnut` para conclusão e status.

Se algo não der para fazer com o que eu sei, fale claramente e sugira o mais parecido.

### Ordem de construção

1. Home, login e cadastro, catálogo e páginas dos jogos (feito).
2. Sobre mim.
3. Registrar progresso e perfil (feito).
4. Dashboard com Chart.js e os indicadores.
5. Apresentação.

### Visual

Tema escuro em azul e amarelo, com fundo azul bem escuro, azul nos títulos e links e amarelo nos botões e rótulos. As capas são as da biblioteca da Steam e os cenários são as artes largas.

Variáveis no `:root` do `home.css`:

| Variável | Cor | Uso |
| --- | --- | --- |
| `--preto` | `#0a0f1d` | Cabeçalho e letra dos botões |
| `--fundo` | `#0d1526` | Fundo da página |
| `--fundo-cartao` | `#131d33` | Cartões |
| `--fundo-cartao-claro` | `#1b2846` | Campos |
| `--borda` | `#27375a` | Bordas |
| `--texto` | `#eef2f8` | Texto principal |
| `--texto-suave` | `#9aa8c4` | Texto secundário |
| `--azul` | `#4db6ff` | Títulos, links e detalhes |
| `--amarelo` | `#ffcc40` | Botões e rótulos |

As cores de dificuldade de 1 a 5, quando forem usadas: `#7fc493`, `#d8c35e`, `#e48a52`, `#dd5f6a` e `#b77ce0`.

Fonte do Google Fonts: `Alegreya Sans` no texto.

## Comandos que eu já sei

O código só pode usar o que eu aprendi nas aulas.

JavaScript:

- `let`, `var`, `Number()`, `parseInt()`, `parseFloat()`, `isNaN()`, `.toFixed()`;
- `+ - * / %`, comparação, `&&`, `||`, `!`, `++`, `+=`;
- `if`, `else if`, `else`, `while` e `for`;
- `function` com parâmetros e `return`, chamada no `onclick` ou no `oninput`;
- vetores: `[]`, índice, `.length`, `.push()`, `.pop()`, `.at()`, `.includes()`, `.indexOf()`, `.toString()`, `.replaceAll()`;
- objetos e vetor de objetos (`lista[0].nome`);
- textos: `` `${}` ``, `.toUpperCase()`, `.toLowerCase()`, `.substring()`, `.replace()`, `.trim()`;
- pegar e mostrar dados: `ipt_nome.value`, `div_msg.innerHTML`, `innerHTML +=`, `alert()`;
- estilo pelo JS: `elemento.style.display` e `elemento.style.width`;
- `setTimeout`, `setInterval`, `clearInterval`;
- `sessionStorage`;
- `fetch(...).then(...).catch(...)` e Chart.js (`bar`, `line` e `doughnut`) no formato da web-data-viz. Dá para usar `resposta.json().then(json => { ... })`, mas listas são percorridas com `for` ou `while`.

HTML: `nav`, `main`, `div`, `span`, `h1` a `h6`, `p`, `br`, `ul`, `a`, `img`, `input`, `label`, `select`, `option`, `button`, `onclick` e `oninput`. O cabeçalho é uma `div` com a classe `cabecalho`, e as partes da página também são `div`.

SQL: `CREATE DATABASE`, `CREATE TABLE`, `INSERT`, `SELECT`, `UPDATE`, `DELETE`, `ALTER TABLE`, `PRIMARY KEY`, `FOREIGN KEY`, `CONSTRAINT`, `CHECK`, `UNIQUE`, `DEFAULT`, `AUTO_INCREMENT`, `JOIN`, `LEFT JOIN`, `WHERE`, `LIKE`, `ORDER BY`, `LIMIT`, `AS`, `CASE`, `IFNULL`, `CONCAT`, `COUNT`, `SUM`, `AVG`, `ROUND`, `GROUP BY`, `CREATE USER` e `GRANT`.

## O que não pode usar

- montar a página inteira pelo JavaScript ou trocar conteúdo pelo `location.hash`;
- `addEventListener`, `querySelector`, `querySelectorAll`, `classList`, `dataset` e `data-*`;
- `header`, `section`, `footer` e `li`;
- `const` (usar `let`);
- `onload`, `onchange`, `onmouseover` ou qualquer evento além de `onclick` e `oninput`;
- arquivos `.js` meus no front;
- `.map()`, `.filter()`, `.reduce()`, `.find()`, `.forEach()`, `.sort()`, `.join()`, `Object.keys()`, `Object.entries()`, `Object.values()`, `Array.from()`;
- `=>` fora do formato do `fetch`, `? :`, desestruturação e `...`;
- `localStorage`, `try/catch`, expressões regulares, `requestAnimationFrame`, `matchMedia`, `performance.now()`, `toLocaleString()`, `Math.max(...)` com vetor;
- `<table>`, `<details>`, `<summary>`, `<form>` com `submit`, `<svg>` no código e `input type="radio"`;
- qualquer framework ou biblioteca nova.

A web-data-viz usa alguns desses, mas isso não libera para os meus arquivos. Se algo útil não estiver na lista, pergunte e me explique, para eu decidir se estudo ou seguimos sem.

## CSS

- O CSS tem que ser o mais simples e curto possível, sem perder o que importa.
- Tudo em arquivos `.css` em `public/css/`. Nada de `<style>` no HTML e o mínimo de `style=""`.
- Regras parecidas ficam juntas, com seletores agrupados.
- `:hover` só no que é clicável.
- Nada de animação de enfeite, como caixinha que se mexe. Só uma transição simples de cor ou opacidade quando ajudar.
- O site é só para PC: sem `@media` e sem meta viewport.
- Pode usar: Flexbox, Grid, `:root` e `var()`, `:hover`, `transition`, `@keyframes`, `animation`, `position`, `z-index`, `overflow`, `opacity`, `border-radius`, `aspect-ratio`, `object-fit` e `background-size`.
- Evite o que é avançado demais: `clip-path`, `:has()`, `hsl()` calculado e `env()`.
- Comentários curtos, e um comentário na frente de recurso que eu ainda não usei nas aulas.

## Jeito de escrever o código

- Nomes em português e camelCase (`nomeJogo`, `listarJogos`).
- Dados do `fetch` terminam com `Server` (`nomeJogoServer`).
- Tabelas e colunas em português, sem acento, no singular. Chave estrangeira começa com `fk_`.
- Ids no padrão das aulas: `ipt_` para campos, `div_` para divs, e o mesmo jeito para os outros (`span_`, `img_`, `h1_`, `p_`).
- Comentários curtos e simples, só onde não for óbvio. Nada de faixas decorativas ou explicações longas.
- O JavaScript fica num `<script>` no fim do `body`, e a última linha chama a função que monta a página.
- Função usada em várias páginas é escrita no `<script>` de cada uma. Os `.js` que já vêm na web-data-viz podem ser usados.
- O código precisa ser fácil de explicar.
- Sempre testar no navegador depois de mudar algo.

## Commits

Formato: `tipo: descrição curta em português`, com letra minúscula e verbo no presente.

- `feat`: funcionalidade nova
- `fix`: correção
- `style`: visual ou CSS
- `docs`: documentação
- `refactor`: organização sem mudar o que o código faz

Um commit para cada mudança.

## Como a IA deve me ajudar

O professor disse: "você pode usar IA, mas não pode terceirizar o entendimento". Na avaliação ele pode pedir para eu explicar qualquer parte, mudar algo ao vivo e desenhar o caminho front → back → banco.

- Explique o código em linguagem simples e não entregue nada que eu não consiga explicar.
- Não mude a arquitetura e não traga tecnologia de fora.
- Faça só o que eu pedi.
- Quando tiver mais de um jeito de fazer e a escolha for minha, pergunte.
- Não invente nada sobre mim (história, valores, dificuldades, pessoas). Onde precisar, deixe `[PREENCHER]`.
- Não faça commit nem push. Isso é comigo.

### Diário de Prompts

No fim de cada tarefa, a IA adiciona uma entrada no `DIARIO-DE-PROMPTS.md` usando o modelo do arquivo (data e assunto, IA, o que eu pedi, o que ela fez), a não ser que eu diga para não colocar.

## Cuidados

- Não mude as pastas nem a configuração da API (`package.json`, `src/database/config.js` e a escolha de ambiente no começo do `app.js`).
- Pode criar arquivos novos no mesmo padrão. No front, nada de arquivo `.js` novo.
- Em arquivos da web-data-viz que já existem, peça confirmação antes de mudar, a não ser que eu tenha pedido.
- Não apague, renomeie ou mova arquivos sem me perguntar.
- Não instale pacotes novos, não rode `npm audit fix` e não mexa na `node_modules`.
- Na dúvida, pergunte.
