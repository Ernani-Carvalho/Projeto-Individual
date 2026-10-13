# AGENTS.md

Este arquivo explica o projeto para qualquer agente de IA que for trabalhar nele. Leia tudo antes de fazer qualquer alteração.

## Visão geral

Este é o meu projeto individual da matéria de Pesquisa e Inovação (PI), do 1º semestre de Análise e Desenvolvimento de Sistemas. O tema é jogos indie.

Quem joga indie costuma jogar muitos jogos diferentes, de estúdios pequenos, e acaba não tendo um lugar só para guardar o que já jogou, até onde chegou em cada jogo e o que achou. As conversas sobre esses jogos também ficam espalhadas em vários lugares.

A ideia do site é juntar isso em um lugar só. Nele o usuário pode:

- se cadastrar e fazer login;
- cadastrar os jogos que joga e registrar o progresso em cada um;
- ter um perfil com o total de horas jogadas, as horas de cada jogo, os bosses derrotados em cada jogo, o número de tentativas para vencer cada boss e a dificuldade que ele deu para cada um;
- acompanhar esse progresso em uma dashboard;
- compartilhar experiências e comentar sobre os jogos.

O site tem dois tipos de usuário:

- Fãs de jogos indie, que usam o site para registrar o progresso e comentar.
- Desenvolvedores indie, que podem participar das conversas e interagir com quem joga e comenta sobre os jogos deles.

O projeto é acadêmico e não vai para produção.

## Tecnologias

- HTML: estrutura das páginas do site.
- CSS: visual das páginas (cores, fontes, layout).
- JavaScript: interação nas páginas e chamadas para a API usando `fetch`. Também é a linguagem usada dentro das APIs.
- MySQL: banco de dados onde ficam os usuários, jogos, progresso e comentários.
- web-data-viz: API da faculdade que serve o site e faz a comunicação entre as páginas e o banco. É nela que ficam o login, o cadastro e os dados da dashboard. Roda com Node.js e já vem com as bibliotecas express, mysql2 e dotenv. Os gráficos das dashboards usam o Chart.js, que é carregado direto no HTML.
- dat-acqu-ino: API da faculdade que lê os dados do sensor do Arduino pela porta USB, mostra esses dados em gráficos e pode gravar as leituras no banco. Faz parte da estrutura pedida no PI e deve ser mantida como foi entregue.

Não use nenhuma tecnologia fora dessa lista. O Chart.js pode ser usado nos gráficos porque já faz parte das APIs.

## Comandos

Git:

- `git clone https://github.com/ernani-carvalho/projeto-individual.git` para baixar o projeto.
- `git pull` antes de começar a mexer.
- `git add .`, depois `git commit -m "tipo: descrição curta"` e `git push` para enviar as alterações.

Site (web-data-viz):

- Entrar na pasta com `cd web-data-viz`.
- `npm install` na primeira vez ou quando o `package.json` mudar.
- `npm start` para ligar o servidor. O site abre em `http://localhost:3333`.
- `Ctrl + C` no terminal para desligar.

Sensor (dat-acqu-ino):

- Entrar na pasta com `cd dat-acqu-ino`.
- `npm install` e depois `npm start`. A API abre em `http://localhost:3300`.
- O Monitor Serial da IDE do Arduino precisa estar fechado antes do `npm start`, senão a API não consegue usar a porta.
- `Ctrl + C` no terminal para desligar.

Banco de dados:

- Abrir o arquivo `web-data-viz/src/database/script-tabelas.sql` no MySQL Workbench e executar o script inteiro.
- Preencher o nome do banco, o usuário e a senha do MySQL no arquivo `web-data-viz/.env.dev`.

Não rode `npm audit fix`. As versões das bibliotecas foram travadas pela faculdade e esse comando muda as versões e quebra o projeto.

## Arquitetura

A raiz do repositório tem as duas APIs:

- `AGENTS.md` e `README.md`
- `web-data-viz/`
  - `app.js`: arquivo principal. Liga o servidor e registra as rotas.
  - `package.json`: lista de bibliotecas e o comando do `npm start`.
  - `.env.dev`: dados de acesso ao banco local (é o arquivo usado no dia a dia).
  - `.env`: dados de acesso a um banco remoto. Não é usado neste projeto.
  - `DOCUMENTOS_DE_APOIO/`: tutoriais e exemplos da faculdade, como o passo a passo para criar uma rota nova.
  - `public/`: tudo que aparece no navegador.
    - `index.html`, `login.html`, `cadastro.html` e `simulador.html`;
    - `dashboard/`: páginas que só aparecem depois do login (`cards.html`, `dashboard.html`, `mural.html`, `edicao-aviso.html`);
    - `css/`: `estilo.css` (geral) e `dashboards.css`;
    - `js/`: `sessao.js` (controle de login) e `alerta.js`;
    - `assets/`: imagens (`imgs/`), ícones (`icon/`) e gifs de carregamento.
  - `src/`
    - `routes/`: os caminhos da API, como `/usuarios/cadastrar`. Cada arquivo chama uma função do controller.
    - `controllers/`: recebem os dados da requisição, fazem as validações e chamam o model.
    - `models/`: montam o comando SQL e mandam executar no banco.
    - `database/`: `config.js` (conexão com o MySQL) e `script-tabelas.sql` (criação das tabelas).
- `dat-acqu-ino/`
  - `main.js`: a API inteira. Lê o Arduino e publica os dados.
  - `index.html`: página com os gráficos do sensor.
  - `package.json`: lista de bibliotecas e o comando do `npm start`.

Os arquivos de aquário, empresa, medida e aviso que vieram na web-data-viz são do AquaTech, o projeto de exemplo da faculdade. Eles servem de modelo para criar os arquivos do meu projeto.

### Caminho de uma requisição

Exemplo usando o login:

1. O usuário preenche o formulário em `public/login.html`.
2. O JavaScript da página faz um `fetch` com `POST` para `/usuarios/autenticar`, enviando os dados com o final `Server` no nome (`emailServer`, `senhaServer`).
3. O `app.js` manda a requisição para `src/routes/usuarios.js`.
4. A rota chama a função `autenticar` do `src/controllers/usuarioController.js`.
5. O controller pega os dados em `req.body.emailServer` e `req.body.senhaServer`, confere se não estão vazios e chama o `usuarioModel.js`.
6. O model monta o `SELECT` numa variável `instrucaoSql` e executa com `database.executar()`, do arquivo `src/database/config.js`.
7. A resposta volta pelo mesmo caminho. Se der certo, a página guarda o nome, o email e o id do usuário no `sessionStorage` (`NOME_USUARIO`, `EMAIL_USUARIO`, `ID_USUARIO`) e manda para a área logada.

As páginas da área logada chamam `validarSessao()`, do `js/sessao.js`, no `onload` do `body`. Se não tiver ninguém logado, o usuário volta para o login. O botão de sair chama `limparSessao()`.

Toda funcionalidade nova deve seguir esse mesmo caminho: página, `fetch`, rota, controller, model e banco.

### Caminho dos dados do sensor

Sensor, Arduino, porta serial, dat-acqu-ino e, por fim, banco de dados e gráficos.

- O Arduino precisa enviar cada leitura no formato `digital;analogico`, com `Serial.println` no final. Exemplo: `1;33.56`.
- Os dados ficam disponíveis em `http://localhost:3300/sensores/analogico` e `http://localhost:3300/sensores/digital`.
- A gravação no banco começa desligada. Ela é ligada pela constante `HABILITAR_OPERACAO_INSERIR`, no início do `main.js`.

### Onde criar arquivos novos

Seguindo o padrão da web-data-viz e o `PASSO_A_PASSO_CRIAR_ROTA_NA_API.md`, uma funcionalidade de jogos fica assim:

- página: `public/jogos.html`, ou dentro de `public/dashboard/` se for da área logada;
- estilo: `public/css/jogos.css`;
- rota: `src/routes/jogos.js` (nome no plural);
- controller: `src/controllers/jogoController.js` (nome no singular);
- model: `src/models/jogoModel.js` (nome no singular);
- tabelas novas: no `src/database/script-tabelas.sql`.

Depois de criar a rota, ela precisa ser registrada no `app.js` em dois lugares, do mesmo jeito que as rotas que já existem:

- junto das outras importações: `var jogosRouter = require("./src/routes/jogos");`
- junto dos outros `app.use`: `app.use("/jogos", jogosRouter);`

Rotas que só buscam dados usam `router.get` (por exemplo `/jogos/listar`). Rotas que gravam dados usam `router.post` (por exemplo `/jogos/cadastrar`).

Antes de criar qualquer arquivo, veja os arquivos de usuário que já existem (rota, controller e model) e siga o mesmo formato.

## Padrões de desenvolvimento

- Usar `const` por padrão e `let` só quando a variável precisar mudar de valor. Os arquivos originais das APIs usam `var`. Não reescreva esses arquivos só para trocar isso.
- Nomes de variáveis e funções em português e em camelCase. Exemplo: `nomeJogo`, `listarJogos`, `registrarProgresso`.
- Nos dados enviados pelo `fetch`, manter o padrão da API de terminar o nome com `Server`. Exemplo: `nomeJogoServer`.
- Nomes de arquivos em letra minúscula, seguindo o padrão da pasta: rotas no plural (`jogos.js`), controllers e models no singular com o tipo no final (`jogoController.js`, `jogoModel.js`).
- Nomes de tabelas e colunas do banco em português, sem acento e no singular. Chaves estrangeiras começam com `fk_` (exemplo: `fk_usuario`), como no script da API.
- Manter a indentação organizada, com o mesmo espaçamento em todo o arquivo.
- Escrever comentários curtos só nas partes importantes ou que não são óbvias.
- Cada página tem o seu arquivo CSS quando fizer sentido. Estilos usados em várias páginas ficam no `estilo.css`.
- O JavaScript da página fica numa tag `<script>` no final do HTML, como nas páginas da web-data-viz. Funções usadas em várias páginas vão para um arquivo em `public/js/`.
- Sempre conferir no navegador se a página continua funcionando depois de uma alteração.

## Modelo de commit

Os commits seguem o formato `tipo: descrição curta em português`.

Tipos usados:

- `feat`: funcionalidade nova
- `fix`: correção de erro
- `style`: mudança visual ou de CSS
- `docs`: documentação (README, AGENTS.md)
- `refactor`: organização do código sem mudar o que ele faz

A descrição começa com letra minúscula, usa o verbo no presente e é curta.

Exemplos:

- `feat: cria tela de cadastro de jogos`
- `feat: adiciona registro de progresso por jogo`
- `feat: mostra horas jogadas na dashboard`
- `fix: corrige erro no login com email inválido`
- `fix: arruma comentário que não aparecia na página do jogo`
- `style: ajusta cores do menu da página inicial`
- `docs: atualiza passo a passo do README`
- `refactor: separa funções do jogoController`

Cada commit deve ter uma alteração só. Se mexeu em duas coisas diferentes, faça dois commits.

## Cuidados e restrições

A regra mais importante: a estrutura das APIs da faculdade (web-data-viz e dat-acqu-ino) não deve ser alterada.

- Não mudar a organização das pastas nem a configuração das APIs (`package.json`, `package-lock.json`, `src/database/config.js` e a escolha de ambiente no começo do `app.js`).
- É permitido criar arquivos novos seguindo o mesmo padrão delas (rotas, controllers, models, páginas, CSS e JS).
- Alterações aceitas em arquivos que já existem:
  - registrar novas rotas no `app.js`;
  - adicionar as tabelas do projeto no `script-tabelas.sql`;
  - adaptar o cadastro e o login (`cadastro.html`, `login.html`, `usuarioController.js` e `usuarioModel.js`) para os campos do projeto, do mesmo jeito que foi feito nas atividades de aula. Peça confirmação antes de mexer nesses arquivos.
- Na dat-acqu-ino, só mexer nas partes que o material da aula manda: a constante `HABILITAR_OPERACAO_INSERIR`, os dados de acesso ao banco e o `INSERT` do `main.js`.
- Não apagar os arquivos do AquaTech nem os `DOCUMENTOS_DE_APOIO`.

Outros cuidados:

- Não apagar, renomear ou mover arquivos sem pedir antes.
- Nunca escrever senha, usuário ou dados de acesso de verdade em nenhum arquivo. Na web-data-viz esses dados ficam no `.env.dev`, e quem preenche sou eu, na minha máquina. Não faça commit do `.env.dev` nem do `main.js` da dat-acqu-ino com a senha verdadeira.
- Não instalar bibliotecas ou pacotes novos com `npm install nome-do-pacote` e não rodar `npm audit fix`.
- Não mexer na pasta `node_modules`.
- Não usar frameworks ou tecnologias fora da lista (React, Bootstrap, TypeScript, etc.).
- Não fazer alterações grandes de uma vez. Prefira mudanças pequenas e explique o que foi feito.
- Se não tiver certeza de alguma coisa, pergunte antes de alterar.

## Regra geral

Antes de fazer qualquer alteração, siga as tecnologias, a arquitetura, os padrões e as restrições descritos neste documento. Se faltar alguma informação, analise o código que já existe no projeto e siga os padrões que já estão sendo usados.
