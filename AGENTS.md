# AGENTS.md

Instruções para qualquer IA que for mexer neste projeto. Leia tudo antes de alterar qualquer coisa.

## O projeto

É o meu projeto individual de Pesquisa e Inovação (PI), do 1º semestre de Análise e Desenvolvimento de Sistemas na SPTech. O tema é jogos indie.

Quem joga indie passa por muitos jogos diferentes e acaba sem um lugar para guardar o que já jogou, até onde chegou e o que achou de cada luta. O site junta isso num lugar só. Nele dá para:

- conhecer o tema na página inicial (jogos em destaque, a história dos indies com linha do tempo, curiosidades e recomendações de um jogo para cada tipo de jogador);
- ler a página "Sobre mim", com uma dedicatória;
- ver o catálogo de jogos e a página de cada jogo, com a filosofia do jogo e os bosses;
- criar conta e fazer login;
- registrar o progresso: horas em cada jogo, status (jogando, zerado ou pausado), bosses derrotados, quantas tentativas levou e a dificuldade de 1 a 5;
- ver o perfil com o resumo do progresso;
- acompanhar tudo numa dashboard com gráficos (Chart.js) e indicadores.

Só existe um tipo de usuário: o jogador. O perfil e a dashboard mostram só os dados de quem está logado. A página inicial mostra números somando todos os jogadores (jogadores, horas, bosses derrotados e jogos no catálogo), e a página de cada jogo mostra a média de tentativas de todos os jogadores em cada boss.

O projeto é da faculdade e não vai para produção.

### O que o professor pede

Pelos slides do professor, o projeto precisa ter:

- Desafio: site com formulário de cadastro, tema que me representa, HTML, CSS, validações em JavaScript e a API em Node.js (web-data-viz) para cadastrar e consultar no banco.
- Tecnologia da Informação: documento do projeto (eu faço), Trello e Git com commits pequenos e frequentes.
- Banco de Dados: modelo lógico, relacionamentos e comandos SQL.
- Algoritmos: variáveis, funções, contas, condicionais, repetições e vetores.
- Arquitetura de Computadores e Matemática: cálculos (totais, médias e porcentagens).
- Introdução aos Sistemas Operacionais: uma VM Linux só com o banco.
- Pesquisa e Inovação: contexto, planejamento, dashboard e indicadores.
- Socioemocional: página "Sobre mim" e a apresentação final, que responde quando o interesse por indies começou, quais valores meus aparecem no projeto, a maior dificuldade, a maior superação e a quem sou grato.

O README é só a vitrine do projeto no GitHub, curta e bonita. Não coloque nele requisitos do professor, cronograma, Socioemocional nem nada da matéria. Isso fica no documento do projeto, que eu vou fazer.

## O que não vai ser feito

Não crie páginas, tabelas, rotas ou código para isto, mesmo que apareça no protótipo antigo:

- comentários, respostas ou qualquer conversa entre usuários;
- conta de desenvolvedor ou outro tipo de usuário;
- jogos cadastrados pelo usuário (o catálogo é fixo, vem do script do banco).

## Tecnologias

- HTML para a estrutura das páginas.
- CSS para o visual.
- JavaScript para as validações, a interação e o `fetch` para a API. A API também é em JavaScript.
- MySQL para o banco (usuários, jogos, bosses e progresso).
- Uma VM Linux só com o MySQL.
- web-data-viz: a API da faculdade, que serve o site e liga as páginas ao banco. Roda com Node.js e já vem com express, mysql2 e dotenv. Os gráficos usam o Chart.js, carregado direto no HTML.

O projeto não usa sensor nem Arduino, então a dat-acqu-ino não entra. Todos os dados são digitados pelos jogadores no site.

Não use nada fora dessa lista.

## Comandos

Git:

- `git clone https://github.com/ernani-carvalho/projeto-individual.git` para baixar.
- `git pull` antes de começar.
- `git add .`, `git commit -m "tipo: descrição curta"` e `git push` para enviar.

Site (web-data-viz), na minha máquina:

- `cd web-data-viz`
- `npm install` na primeira vez ou quando o `package.json` mudar.
- `npm start` para ligar. O site abre em `http://localhost:3333`.
- `Ctrl + C` para desligar.

Banco de dados, na VM:

- O MySQL fica numa VM Lubuntu, no VirtualBox, que tem só o banco. O site e a API não rodam na VM.
- A conexão segue o jeito da atividade de SO: a placa de rede da VM fica em NAT e o VirtualBox tem um redirecionamento de porta (Configurações → Rede → Avançado → Redirecionamento de Portas), TCP, com porta do host 3307 e porta do guest 3306. O que chega na porta 3307 da minha máquina vai para o MySQL da VM.
- Uso 3307 no host para não bater com um MySQL que já esteja instalado na minha máquina.
- Por causa do redirecionamento, eu me conecto em `127.0.0.1`, porta `3307`. O IP da VM não é usado.
- O MySQL da VM precisa aceitar conexão de fora, com um usuário criado para isso (`CREATE USER` e `GRANT`, como na aula).
- Para testar pelo terminal: `mysql -u usuario -p -h 127.0.0.1 -P 3307` (`-p` pede a senha, `-P` é a porta).
- No Workbench: conexão em `127.0.0.1`, porta `3307`. Depois abrir `web-data-viz/src/database/script-tabelas.sql` e rodar o script inteiro.
- No `web-data-viz/.env.dev`: `DB_HOST` = `127.0.0.1` e `DB_PORT` = `3307`. Nome do banco, usuário e senha quem preenche sou eu. A IA nunca escreve esses dados.
- Ordem no dia a dia: ligar a VM, ver se o Workbench conecta e só depois rodar `npm start`.

Nunca rode `npm audit fix`. As versões foram travadas pela faculdade e esse comando quebra o projeto.

## Pastas

- `AGENTS.md`, `README.md` e `DIARIO-DE-PROMPTS.md`
- `docs/`: imagens da documentação, como o modelo lógico (`docs/modelo-logico.png`).
- `testes/`: coisas só minhas, que estão no `.gitignore` e não vão para o GitHub (PDFs das aulas, prompts e o protótipo).
  - `testes/prototipo/`: o site de referência feito com IA, só para eu estudar. Não usa a API nem o banco e não tem dados de exemplo nem arquivos `.js`: cada página tem só a base (HTML, CSS e um `<script>` pequeno), com avisos onde os dados do banco vão aparecer e comentários `AQUI ENTRA O FETCH`. As capas estão em `assets/jogos/`, os cenários em `assets/cenarios/` e a logo em `assets/logo/`. Os textos dos jogos ficaram em `testes/dados-dos-jogos.md`, para os `INSERT` do banco.
- `web-data-viz/`: onde fica o projeto de verdade, que eu faço na mão.
  - `app.js`: liga o servidor e registra as rotas.
  - `package.json`: bibliotecas e o comando do `npm start`.
  - `.env.dev`: acesso ao banco da VM (o que eu uso no dia a dia).
  - `.env`: banco remoto, não usado aqui.
  - `DOCUMENTOS_DE_APOIO/`: tutoriais da faculdade, como o passo a passo de criar rota.
  - `public/`: o que aparece no navegador (`index.html`, `login.html`, `cadastro.html`, `simulador.html`, a pasta `dashboard/` com as páginas logadas, `css/`, `js/` com `sessao.js` e `alerta.js`, e `assets/`).
  - `src/routes/`: os caminhos da API, como `/usuarios/cadastrar`.
  - `src/controllers/`: recebem os dados, validam e chamam o model.
  - `src/models/`: montam o SQL e mandam executar.
  - `src/database/`: `config.js` (conexão) e `script-tabelas.sql` (tabelas).

Os arquivos de aquário, empresa, medida e aviso são do AquaTech, o exemplo da faculdade. Servem de modelo para os meus.

Não copie arquivos do protótipo para a `web-data-viz/` e não altere a `web-data-viz/` a partir dele.

O navegador e a API rodam na minha máquina. Na VM fica só o MySQL.

### Caminho de uma requisição

Usando o login como exemplo:

1. O jogador preenche `public/login.html`.
2. O JavaScript faz `fetch` com `POST` para `/usuarios/autenticar`, mandando `emailServer` e `senhaServer`.
3. O `app.js` passa para `src/routes/usuarios.js`.
4. A rota chama `autenticar` no `usuarioController.js`.
5. O controller pega `req.body.emailServer` e `req.body.senhaServer`, vê se não estão vazios e chama o `usuarioModel.js`.
6. O model monta o `SELECT` na variável `instrucaoSql` e roda com `database.executar()`, que conecta no MySQL da VM.
7. A resposta volta pelo mesmo caminho. Se deu certo, a página guarda `NOME_USUARIO`, `EMAIL_USUARIO` e `ID_USUARIO` no `sessionStorage` e vai para a área logada.

As páginas logadas chamam `validarSessao()` (do `js/sessao.js`) logo no começo da função que roda quando a página abre (o `<script>` fica no fim do `body` e chama essa função na última linha). Sem ninguém logado, volta para o login. O botão de sair chama `limparSessao()`.

Tudo que for novo segue o mesmo caminho: página, `fetch`, rota, controller, model e banco.

### Dados da dashboard

1. A página faz `fetch` com `GET` para uma rota que busca os dados do jogador, usando o `ID_USUARIO` do `sessionStorage`.
2. Rota, controller e model funcionam igual ao login. O model já faz as contas no `SELECT` (`SUM` das horas, `COUNT` dos bosses, `AVG` das tentativas, com `GROUP BY`).
3. A página recebe o JSON, percorre com `for`, faz o que faltar (como a porcentagem de bosses derrotados) e monta os gráficos com Chart.js, como no `dashboard/dashboard.html` da web-data-viz.

Os números gerais da página inicial seguem o mesmo caminho, só que sem filtrar por jogador.

### Onde criar arquivos novos

Seguindo o padrão da web-data-viz e o `PASSO_A_PASSO_CRIAR_ROTA_NA_API.md`, os jogos ficariam assim:

- página `public/jogos.html` (ou em `public/dashboard/` se for da área logada);
- CSS `public/css/jogos.css`;
- rota `src/routes/jogos.js` (plural);
- controller `src/controllers/jogoController.js` e model `src/models/jogoModel.js` (singular);
- tabelas novas no `script-tabelas.sql`.

A rota nova precisa ser registrada no `app.js` em dois lugares, igual às que já existem:

- `var jogosRouter = require("./src/routes/jogos");` junto das outras importações;
- `app.use("/jogos", jogosRouter);` junto dos outros `app.use`.

Rota que só busca usa `router.get` (ex.: `/jogos/listar`). Rota que grava usa `router.post` (ex.: `/progressos/registrar`).

Antes de criar qualquer arquivo, olhe os de usuário (rota, controller e model) e siga o mesmo formato.

Ideia de rotas (confirmar comigo quando chegar a hora de cada uma):

- `usuarios.js` (já existe): cadastro e login.
- `jogos.js`, com `jogoController.js` e `jogoModel.js`: catálogo, um jogo e os bosses dele com a média de tentativas.
- `progressos.js`, com `progressoController.js` e `progressoModel.js`: registrar horas e status, registrar boss derrotado e buscar o progresso para o perfil.
- `indicadores.js`, com `indicadorController.js` e `indicadorModel.js`: números da página inicial e indicadores da dashboard.

## Banco de dados

Tabelas que vou criar no `script-tabelas.sql`:

| Tabela | Colunas | Observação |
| --- | --- | --- |
| `usuario` | `id`, `nome`, `email`, `senha` | Adaptar a que já existe na web-data-viz. |
| `jogo` | `id`, `nome`, `estudio`, `ano`, `genero`, `criadores`, `pais`, `descricao`, `lema`, `temas`, `filosofia` | Catálogo fixo, com `INSERT` no script. `temas` pode ser um texto separado por vírgula e `filosofia` um texto maior. |
| `boss` | `id`, `nome`, `fk_jogo` | Bosses de cada jogo. |
| `progresso` | `id`, `fk_usuario`, `fk_jogo`, `horas`, `status` | `status` com `CHECK` em `'jogando'`, `'zerado'` ou `'pausado'`. |
| `boss_derrotado` | `id`, `fk_usuario`, `fk_boss`, `tentativas`, `dificuldade` | `CHECK` com tentativas maior ou igual a 1 e dificuldade de 1 a 5. |

Relacionamentos:

- `jogo` 1:N `boss`: cada jogo tem vários bosses, e cada boss é de um jogo só.
- `usuario` N:N `jogo`, resolvido pela tabela `progresso`.
- `usuario` N:N `boss`, resolvido pela tabela `boss_derrotado`.

As tabelas do meio (`progresso` e `boss_derrotado`) têm `id` próprio com `AUTO_INCREMENT` e as duas chaves estrangeiras. A imagem do modelo lógico vai em `docs/modelo-logico.png`.

Contas que aparecem no site:

- total de horas do jogador: `SUM(horas)`;
- jogo mais jogado: o de mais horas (`ORDER BY horas DESC LIMIT 1`);
- média de tentativas de cada boss entre todos os jogadores: `ROUND(AVG(tentativas))`, sempre um número inteiro;
- porcentagem de conclusão de cada jogo: bosses derrotados ÷ total de bosses do jogo × 100, com `.toFixed()`;
- comparação com a média: (valor do jogador − média de todos) ÷ média × 100.

Indicadores da dashboard: total de horas, jogos cadastrados, bosses derrotados, jogo mais jogado, boss mais difícil, conclusão de cada jogo, jogos por status e a comparação com a média dos jogadores.

## Plano do site

O protótipo em `testes/prototipo/` mostra como o site deve ficar. Ele foi feito só com os comandos que eu sei, mas é uma base para eu estudar: o código de verdade eu escrevo na mão, ligando com a API e o banco.

### Páginas

Todas em `web-data-viz/public/`, cada uma no seu `.html` e com o seu CSS.

| Página | Arquivo | CSS | Conteúdo |
| --- | --- | --- | --- |
| Início | `index.html` | `inicio.css` | Capas em tiras inclinadas no fundo do título, números gerais, destaques, história dos indies (texto, três ideias e linha do tempo com capas), curiosidades, um indie para cada tipo de jogador |
| Sobre mim | `sobre.html` | `sobre.css` | Quem eu sou e dedicatória (textos meus, `[PREENCHER]`) |
| Catálogo | `jogos.html` | `jogos.css` | Capas dos jogos, busca e o cenário do jogo no fundo ao passar o mouse |
| Jogo | `jogo.html` | `jogos.css` | Capa, ficha (estúdio, criadores, país, ano, gênero), temas, filosofia em parágrafos, bosses e média de tentativas, com o cenário fixo no fundo |
| Login | `login.html` | `login.css` | Login |
| Cadastro | `cadastro.html` | `login.css` | Cadastro com validações |
| Perfil | `dashboard/perfil.html` | `perfil.css` | Resumo, horas por jogo (da maior para a menor) e bosses de um jogo por vez |
| Registrar | `dashboard/registrar.html` | `registrar.css` | Registro em 3 passos: jogo, horas e status, chefe vencido |
| Dashboard | `dashboard/dashboard.html` | `dashboard.css` | Indicadores e gráficos |

O `dashboard.css` do projeto não é o `dashboards.css` do AquaTech.

`index.html`, `login.html`, `cadastro.html`, `dashboard/dashboard.html` e `css/estilo.css` já existem na web-data-viz (são do AquaTech). Peça confirmação antes de trocar o conteúdo de qualquer um deles.

Texto fixo (apresentação, linha do tempo, curiosidades, sobre mim) fica escrito no HTML. O que vem do banco (catálogo, bosses, perfil, dashboard, números gerais) é montado com `for` e `innerHTML +=` depois do `fetch`, como o `cadastro.html` da web-data-viz faz com as empresas.

### Ordem de construção

Seguindo o cronograma do professor:

1. Semana 3: Home e Sobre mim, só HTML e CSS, com o `estilo.css` geral.
2. Semana 4: cadastro e login com validação e API, tabelas na VM, catálogo e página do jogo com vetor e `for`.
3. Depois: registrar progresso e perfil, com as rotas de progresso.
4. Semana 5: dashboard com Chart.js.
5. Semana 6: apresentação.

### Como o protótipo resolveu cada coisa

O primeiro protótipo (feito por outra IA, fora deste repositório) usava muita coisa que eu não aprendi. O `testes/prototipo/` refez tudo assim, e o projeto de verdade deve seguir o mesmo caminho:

| Recurso | Como fazer |
| --- | --- |
| Site de uma página só trocando conteúdo pelo `location.hash` | Um `.html` por página, com links normais |
| Página do jogo saber qual jogo abrir | Ao clicar no cartão, guardar `sessionStorage.ID_JOGO` e abrir `jogo.html`, que lê esse valor quando o `<script>` do fim da página roda |
| Fundo do título da Home | Capas em tiras inclinadas (`skewX` de 12°) ocupando o topo inteiro, montadas com `for` a partir do vetor de jogos. A imagem leva a inclinação contrária para ficar reta, uma sombra escura fica do lado do texto e o `:hover` alarga a tira um pouco |
| Recomendações da Home | Vetor de objetos ligando um tipo de jogador a um jogo, percorrido com `for` para montar os cartões |
| Números animados | Números fixos, com um `@keyframes` simples de aparecer |
| Abas dos jogos em destaque | Botões com `onclick="mostrarDestaque(0)"` que trocam o `innerHTML` a partir de um vetor |
| Busca de jogos | `oninput="buscarJogos()"`, percorrendo o vetor com `for`, `if`, `.toLowerCase()` e `.includes()` |
| Escolher opções no Registrar (jogo, status, chefe, dificuldade) | Botões com `onclick` que guardam a escolha numa variável e remontam os botões marcando o escolhido. Sem `onchange` e sem `radio` |
| Mostrar e esconder partes | `style.display = "block"` ou `"none"` |
| Aviso que aparece e some | `style.display` e `setTimeout` |
| Ordenar por horas ou tentativas | No banco, `ORDER BY`. No protótipo, um `while` que vai pegando o maior que ainda não entrou na lista (`.sort()` é proibido) |
| Maior valor | `for` com `if` guardando o maior |
| Cenário no fundo ao passar o mouse | Só CSS: a imagem fica escondida com `position: fixed` e `opacity: 0`, e o `:hover` do cartão mostra ela |
| Tabela de bosses | `div`s em linha com Grid ou Flexbox (`<table>` é proibido) |
| Formulário | Botão com `onclick="cadastrar()"`, como na web-data-viz |
| Gráficos | Chart.js no formato da web-data-viz: `bar` para horas e `doughnut` para conclusão e status |

Se aparecer algo que não dá para fazer com o que eu sei, fale isso claramente e sugira o mais parecido.

### Visual

Tema escuro em azul e amarelo: fundo azul bem escuro, azul vivo nos títulos, links e detalhes, e amarelo nos botões, rótulos e destaques. Faixas alternando fundo mais claro e mais escuro com luzes coloridas, títulos grandes em maiúsculas com degradê, cartões com as capas dos jogos e as cores de dificuldade de 1 a 5.

As capas são as da biblioteca da Steam (600×900, todas em pé) e os cenários são as artes largas da Steam. No projeto de verdade elas vão para `web-data-viz/public/assets/`.

Cores (variáveis no `:root` do `estilo.css`):

| Variável | Cor | Uso |
| --- | --- | --- |
| `--preto` | `#0a0f1d` | Cabeçalho e rodapé |
| `--fundo` | `#0d1526` | Blocos claros |
| `--fundo-escuro` | `#080d19` | Blocos escuros |
| `--fundo-cartao` | `#131d33` | Cartões e painéis |
| `--fundo-cartao-claro` | `#1b2846` | Cartões dentro de cartões, campos |
| `--borda` | `#27375a` | Bordas |
| `--texto` | `#eef2f8` | Texto principal |
| `--texto-suave` | `#9aa8c4` | Texto secundário |
| `--azul` | `#4db6ff` | Títulos, links e detalhes |
| `--azul-escuro` | `#2f95e8` | Azul mais escuro |
| `--amarelo` | `#ffcc40` | Botões, textos acima dos títulos e destaques |
| `--amarelo-escuro` | `#f0a91a` | Fim do degradê dos botões |
| `--laranja` | `#ff9f2e` | Detalhes em laranja (curiosidades) |
| `--dificuldade-1` a `--dificuldade-5` | `#7fc493`, `#d8c35e`, `#e48a52`, `#dd5f6a`, `#b77ce0` | Dificuldade de Fácil a Insana |

Fontes do Google Fonts: `Grenze Gotisch` (600 e 700) no logo e em detalhes, e `Alegreya Sans` (400, 500, 700 e 800) no resto.

## Comandos que eu já sei

O código só pode usar o que eu já aprendi nas aulas.

JavaScript:

- `let`, `var`, `Number()`, `parseInt()`, `parseFloat()`, `isNaN()`, `.toFixed()`;
- `+ - * / %`, comparação, `&&`, `||`, `!`, `++`, `+=`;
- `if`, `else if`, `else`;
- `while` e `for`;
- `function` com parâmetros e `return`, chamada no `onclick` ou no `oninput`;
- vetores: `[]`, índice, `.length`, `.push()`, `.pop()`, `.at()`, `.includes()`, `.indexOf()`, `.toString()`, `.replaceAll()`;
- objetos (`{ chave: valor }`) e vetor de objetos (`lista[0].nome`);
- textos: `` `${}` ``, `.toUpperCase()`, `.toLowerCase()`, `.substring()`, `.replace()`, `.trim()`;
- pegar e mostrar dados: `ipt_nome.value`, `div_msg.innerHTML`, `innerHTML +=`, `alert()`;
- estilo pelo JS: `elemento.style.display` e `elemento.style.width`;
- `setTimeout`, `setInterval`, `clearInterval`;
- `sessionStorage`, como no login da web-data-viz;
- `fetch(...).then(...).catch(...)` e Chart.js (`bar`, `line` e `doughnut`) no formato das páginas da web-data-viz. Dá para copiar o `resposta.json().then(json => { ... })` do `login.html`, mas para percorrer listas use `for` ou `while`. O Chart.js precisa de `<canvas>`, e quando o id do gráfico muda (um gráfico por jogo) pode usar `document.getElementById`, como a web-data-viz faz com os aquários.

HTML: tags básicas e semânticas (`nav`, `main`, `footer`, `div`, `span`, `h1` a `h6`, `p`, `br`, `ul`, `a`, `img`), `input`, `label`, `select`, `option`, `button`, links, `onclick` e `oninput`. O cabeçalho é uma `div` com a classe `cabecalho`, e as partes da página também são `div`.

SQL: `CREATE DATABASE`, `CREATE TABLE`, `INSERT`, `SELECT`, `UPDATE`, `DELETE`, `ALTER TABLE`, `PRIMARY KEY`, `FOREIGN KEY`, `CONSTRAINT`, `CHECK`, `UNIQUE`, `DEFAULT`, `AUTO_INCREMENT`, `JOIN`, `LEFT JOIN`, `WHERE`, `LIKE`, `ORDER BY`, `LIMIT`, `AS`, `CASE`, `IFNULL`, `CONCAT`, `COUNT`, `SUM`, `AVG`, `ROUND`, `GROUP BY`, `CREATE USER` e `GRANT`. `COUNT`, `SUM`, `AVG`, `ROUND` e `GROUP BY` eu ainda vou ver em aula, então explique quando usar.

## O que não pode usar

Aparece no protótipo antigo ou na internet, mas eu não aprendi:

- montar a página inteira pelo JavaScript ou trocar conteúdo pelo `location.hash`;
- `addEventListener`, `querySelector`, `querySelectorAll`, `classList`, `dataset` e `data-*`;
- `header`, `section` e `li` (no lugar, usar `div`);
- `const` (usar `let`);
- `onload`, `onchange`, `onmouseover` ou qualquer evento além de `onclick` e `oninput`;
- criar arquivos `.js` meus no front (como um `dados.js` ou um arquivo de funções em `public/js/`);
- `.map()`, `.filter()`, `.reduce()`, `.find()`, `.forEach()`, `.sort()`, `.join()`, `Object.keys()`, `Object.entries()`, `Object.values()`, `Array.from()`;
- `=>` fora do formato do `fetch`, `? :`, desestruturação e `...`;
- `localStorage`, `try/catch`, expressões regulares, `requestAnimationFrame`, `matchMedia`, `performance.now()`, `toLocaleString()`, `Math.max(...)` com vetor;
- `<table>`, `<details>`, `<summary>`, `<form>` com `submit`, `<svg>` no código e `input type="radio"`;
- qualquer framework ou biblioteca nova (React, Bootstrap, jQuery, TypeScript...).

A web-data-viz usa alguns desses (como `.forEach` e `.find` no AquaTech), mas isso não libera para os meus arquivos.

Se algo útil não estiver na lista, pergunte antes e me explique o comando, para eu decidir se estudo ou se seguimos sem.

## CSS

- Todo CSS em arquivos `.css` separados em `web-data-viz/public/css/`. Nada de `<style>` no HTML e o mínimo de `style=""` (só para larguras calculadas, como as barras).
- Um `estilo.css` geral (cores, fontes, cabeçalho, rodapé, botões, cartões) e um arquivo por página quando fizer sentido.
- No CSS eu tenho mais liberdade, mas tem que ser algo que eu consiga explicar.
- Pode usar: Flexbox, Grid, `:root` e `var()`, `:hover`, `:focus`, `:nth-child`, `::before` e `::after`, `transition`, `transform`, `@keyframes`, `animation`, `@media`, `position` (inclusive `fixed` e `sticky`), `z-index`, `overflow`, `opacity`, `box-shadow`, `text-shadow`, `border-radius`, `linear-gradient`, `radial-gradient`, `border-image`, `aspect-ratio`, `object-fit`, `pointer-events`, `mask-image`, `background-clip: text`, `filter` (`saturate` e `brightness`), `vw`, `overflow-x: clip` e Google Fonts.
- Evite o que é avançado demais: `clip-path` com `calc()`, `:has()`, `-webkit-text-stroke`, `text-wrap: balance`, `hsl()` calculado, `env()`, `:focus-visible` e `color-scheme`.
- Comentários curtos separando as partes do CSS, e um comentário na frente de cada recurso que eu ainda não usei nas aulas, dizendo o que ele faz.

## Jeito de escrever o código

- `let` para as variáveis (`const` eu ainda não aprendi). Os arquivos da API usam `var`, não reescreva eles só por isso.
- Nomes de variáveis e funções em português e camelCase (`nomeJogo`, `listarJogos`).
- Dados do `fetch` terminam com `Server` (`nomeJogoServer`).
- Arquivos em minúsculo: rota no plural (`jogos.js`), controller e model no singular com o tipo no fim (`jogoController.js`).
- Tabelas e colunas em português, sem acento, no singular. Chave estrangeira começa com `fk_`.
- Ids no padrão das aulas: `ipt_` para campos e `div_` para divs.
- Indentação organizada e igual no arquivo todo.
- Comentários curtos só onde não for óbvio.
- O JavaScript da página fica num `<script>` no fim do `body`. A última linha do script chama a função que monta a página (ex.: `carregarPagina();`), no lugar do `onload`: quando o script roda, o HTML de cima já existe.
- Eu não posso criar arquivos `.js` meus no front. Função usada em várias páginas é escrita no `<script>` de cada página que precisa dela. Os arquivos `.js` que já vêm na web-data-viz (como o `sessao.js`) podem ser usados.
- Sempre testar no navegador depois de mudar algo.

## Commits

Formato: `tipo: descrição curta em português`, começando com letra minúscula e verbo no presente.

- `feat`: funcionalidade nova
- `fix`: correção
- `style`: visual ou CSS
- `docs`: documentação (README, AGENTS.md, Diário)
- `refactor`: organização sem mudar o que o código faz

Exemplos: `feat: cria tela de cadastro`, `feat: mostra horas jogadas na dashboard`, `fix: corrige soma de horas no perfil`, `style: ajusta cores do menu`, `docs: atualiza o README`.

Um commit para cada mudança. Se mexeu em duas coisas, são dois commits.

## Como a IA deve me ajudar

O professor disse: "você pode usar IA, mas não pode terceirizar o entendimento". Se eu não souber explicar um trecho, ele não conta. Na avaliação ele pode pedir para eu explicar qualquer parte, mudar algo ao vivo e desenhar o caminho front → back → banco.

Então:

- Use a IA para tirar dúvida, explicar erro, revisar, testar, comparar jeitos de fazer e gerar trechos pequenos dentro da web-data-viz.
- Não gere o projeto inteiro de uma vez, não mude a arquitetura, não traga tecnologia de fora e não entregue código que eu não sei explicar.
- Uma parte por vez: diga antes o que vai fazer, depois explique o código em linguagem simples e espere eu testar e aprovar.
- Só use os comandos da lista que eu sei.
- Quando tiver mais de um jeito de fazer, pergunte em vez de escolher sozinha.
- Lembre que o protótipo e os dados de exemplo são só base. O banco, a API e o resto eu faço na mão.
- Não invente nada sobre mim (história, valores, dificuldades, pessoas). Onde precisar, deixe `[PREENCHER]`.
- Não faça commit nem push. Isso é comigo.

### Diário de Prompts

O professor pede um Diário de Prompts. No fim de cada tarefa, a IA adiciona uma entrada no `DIARIO-DE-PROMPTS.md` usando o modelo do arquivo (data e assunto, IA, o que eu pedi, o que ela fez, o que eu usei, o que eu mudei e link). O que ela não souber, deixa em branco para eu completar.

## Cuidados

O mais importante: não mudar a estrutura da web-data-viz.

- Não mude as pastas nem a configuração da API (`package.json`, `package-lock.json`, `src/database/config.js` e a escolha de ambiente no começo do `app.js`).
- Pode criar arquivos novos no mesmo padrão (rotas, controllers e models da API, páginas e CSS). No front, nada de arquivo `.js` novo.
- Em arquivos que já existem, só pode:
  - registrar rotas novas no `app.js`;
  - colocar as tabelas do projeto no `script-tabelas.sql`;
  - adaptar cadastro e login (`cadastro.html`, `login.html`, `usuarioController.js` e `usuarioModel.js`) como nas atividades de aula, pedindo confirmação antes;
  - trocar o conteúdo de `index.html`, `dashboard/dashboard.html` e `css/estilo.css` pelo do projeto, pedindo confirmação antes.
- Não apague os arquivos do AquaTech nem os `DOCUMENTOS_DE_APOIO`.
- Não apague, renomeie ou mova arquivos sem me perguntar.
- Nunca escreva senha, usuário ou dados de acesso de verdade em arquivo nenhum. Isso fica no `.env.dev`, que eu preencho. Não faça commit do `.env.dev` com a senha.
- Não instale pacotes (`npm install nome-do-pacote`) e não rode `npm audit fix`.
- Não mexa na `node_modules`.
- Nada de mudança grande de uma vez. Prefira passos pequenos e explique o que fez.
- Na dúvida, pergunte antes.

Se faltar alguma informação aqui, olhe o código que já existe e siga o mesmo padrão. Se ainda tiver dúvida, pergunte.
