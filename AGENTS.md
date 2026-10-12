# AGENTS.md

Este arquivo explica o projeto para qualquer agente de IA que for trabalhar nele. Leia tudo antes de fazer qualquer alteração.

## Visão geral

Este é o meu projeto individual da matéria de Pesquisa e Inovação (PI), do 1º semestre de Análise e Desenvolvimento de Sistemas. O tema é jogos indie.

Quem joga indie costuma jogar muitos jogos diferentes, de estúdios pequenos, e acaba não tendo um lugar só para guardar o que já jogou, até onde chegou em cada jogo e o que achou. As conversas sobre esses jogos também ficam espalhadas em vários lugares.

A ideia do site é juntar isso em um lugar só. Nele o usuário pode:

- se cadastrar e fazer login;
- cadastrar os jogos que joga e registrar o progresso em cada um;
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
- web-data-viz: API da faculdade que serve o site e faz a comunicação entre as páginas e o banco. É nela que ficam o login, o cadastro e os dados da dashboard.
- dat-acqu-ino: API da faculdade usada para captura de dados e envio para o banco. Faz parte da estrutura pedida no PI e deve ser mantida como foi entregue.

Não use nenhuma tecnologia fora dessa lista.

## Comandos

Clonar o repositório:

```
git clone https://github.com/ernani-carvalho/projeto-individual.git
```

Atualizar o projeto antes de começar a mexer:

```
git pull
```

Salvar e enviar alterações:

```
git add .
git commit -m "tipo: descrição curta"
git push
```

Rodar o site (dentro da pasta da web-data-viz):

```
cd web-data-viz
npm install
npm start
```

O `npm install` só precisa ser rodado na primeira vez ou quando o `package.json` mudar. A dat-acqu-ino funciona do mesmo jeito: entrar na pasta dela, rodar `npm install` e depois `npm start`.

Banco de dados: abrir o arquivo `web-data-viz/src/database/script-tabelas.sql` no MySQL Workbench e executar o script inteiro. Isso cria o banco e as tabelas do projeto.

## Arquitetura

A raiz do repositório tem as duas APIs da faculdade:

```
Projeto-Individual/
  AGENTS.md
  README.md
  web-data-viz/
    app.js
    package.json
    .env.dev
    public/
      index.html
      login.html
      cadastro.html
      dashboard/
      css/
      js/
      assets/
    src/
      routes/
      controllers/
      models/
      database/
  dat-acqu-ino/
```

O que fica em cada pasta da web-data-viz:

- `public/`: tudo que aparece no navegador.
  - arquivos `.html` das páginas;
  - `css/` com os estilos;
  - `js/` com os scripts das páginas;
  - `assets/` com imagens e ícones;
  - `dashboard/` com as páginas que só aparecem depois do login.
- `src/routes/`: define os caminhos da API (por exemplo `/usuarios/cadastrar`) e diz qual função do controller vai ser chamada.
- `src/controllers/`: recebe os dados da requisição, confere se está tudo certo e chama o model.
- `src/models/`: monta os comandos SQL e manda para o banco.
- `src/database/`: conexão com o MySQL e o script de criação das tabelas.
- `app.js`: arquivo principal que liga o servidor e registra as rotas.

### Caminho de uma requisição

Exemplo usando o cadastro de usuário:

1. O usuário preenche o formulário em `public/cadastro.html` e clica em cadastrar.
2. O JavaScript da página pega os valores dos campos e faz um `fetch` para `/usuarios/cadastrar`.
3. O `app.js` manda a requisição para a rota em `src/routes/usuarios.js`.
4. A rota chama a função `cadastrar` do `src/controllers/usuarioController.js`.
5. O controller confere os dados e chama o `usuarioModel.js`.
6. O model monta o `INSERT` e executa no banco pelo arquivo de conexão em `src/database/`.
7. A resposta volta pelo mesmo caminho até a página, que mostra uma mensagem para o usuário.

Toda funcionalidade nova deve seguir esse mesmo caminho.

### Onde criar arquivos novos

Exemplo para uma funcionalidade de jogos:

- página: `public/jogos.html` (ou dentro de `public/dashboard/` se for uma área logada);
- estilo: `public/css/jogos.css`;
- script da página: `public/js/jogos.js`;
- rota: `src/routes/jogos.js`;
- controller: `src/controllers/jogoController.js`;
- model: `src/models/jogoModel.js`;
- tabelas novas: no `script-tabelas.sql`.

Depois de criar a rota, ela precisa ser registrada no `app.js`, do mesmo jeito que as rotas que já existem lá.

Antes de criar qualquer arquivo, veja os arquivos de usuário que já existem (rota, controller e model) e copie o mesmo formato.

## Padrões de desenvolvimento

- Usar `const` por padrão e `let` só quando a variável precisar mudar de valor. Não usar `var` em código novo.
- Nomes de variáveis e funções em português e em camelCase. Exemplo: `nomeJogo`, `listarJogos`, `registrarProgresso`.
- Nomes de arquivos em letra minúscula. Quando tiver mais de uma palavra, seguir o padrão que já existe na pasta (por exemplo `jogoController.js`).
- Nomes de tabelas e colunas do banco em português e sem acento.
- Manter a indentação organizada, com o mesmo espaçamento em todo o arquivo.
- Escrever comentários curtos só nas partes importantes ou que não são óbvias.
- Um arquivo CSS e um arquivo JS por página quando fizer sentido. Estilos que se repetem em várias páginas ficam em um CSS geral.
- Não escrever CSS dentro do HTML nem JavaScript solto no meio do HTML. Usar os arquivos separados.
- Sempre conferir no navegador se a página continua funcionando depois de uma alteração.

## Modelo de commit

Os commits seguem o formato:

```
tipo: descrição curta em português
```

Tipos usados:

- `feat`: funcionalidade nova
- `fix`: correção de erro
- `style`: mudança visual ou de CSS
- `docs`: documentação (README, AGENTS.md)
- `refactor`: organização do código sem mudar o que ele faz

A descrição começa com letra minúscula, usa o verbo no presente e é curta.

Exemplos:

```
feat: cria tela de cadastro de jogos
feat: adiciona registro de progresso por jogo
feat: mostra horas jogadas na dashboard
fix: corrige erro no login com email inválido
fix: arruma comentário que não aparecia na página do jogo
style: ajusta cores do menu da página inicial
docs: atualiza passo a passo do README
refactor: separa funções do jogoController
```

Cada commit deve ter uma alteração só. Se mexeu em duas coisas diferentes, faça dois commits.

## Cuidados e restrições

A regra mais importante: a estrutura das APIs da faculdade (web-data-viz e dat-acqu-ino) não deve ser alterada.

- Não mudar a configuração, a organização das pastas nem os arquivos originais dessas APIs.
- É permitido criar arquivos novos seguindo o mesmo padrão delas (rotas, controllers, models, páginas, CSS e JS).
- As únicas alterações aceitas em arquivos que já existem são registrar novas rotas no `app.js` e adicionar as tabelas do projeto no `script-tabelas.sql`, sempre seguindo o formato que já está lá.

Outros cuidados:

- Não apagar, renomear ou mover arquivos sem pedir antes.
- Não colocar senha, usuário ou dados de acesso do banco direto no código. Esses dados ficam no arquivo `.env.dev`, que é onde a web-data-viz já busca essas informações.
- Não instalar bibliotecas ou pacotes novos com `npm install nome-do-pacote`.
- Não usar frameworks ou tecnologias fora da lista (React, Bootstrap, TypeScript, etc.).
- Não mudar o `package.json`.
- Não fazer alterações grandes de uma vez. Prefira mudanças pequenas e explique o que foi feito.
- Se não tiver certeza de alguma coisa, pergunte antes de alterar.

## Regra geral

Antes de fazer qualquer alteração, siga as tecnologias, a arquitetura, os padrões e as restrições descritos neste documento. Se faltar alguma informação, analise o código que já existe no projeto e siga os padrões que já estão sendo usados.
