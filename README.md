# Projeto Individual: Jogos Indie

Projeto individual da matéria de Pesquisa e Inovação (PI), do 1º semestre de Análise e Desenvolvimento de Sistemas.

## Sobre o projeto

Um site para fãs de jogos indie registrarem o progresso nos jogos que jogam e conversarem sobre eles. Desenvolvedores indie também podem participar, interagindo com quem joga e comenta sobre os jogos deles.

A ideia surgiu porque quem joga indie costuma jogar muitos jogos de estúdios pequenos e não tem um lugar só para guardar o que já jogou e trocar experiências.

## Funcionalidades

- Cadastro e login de usuários
- Cadastro dos jogos que o usuário joga
- Registro do progresso em cada jogo
- Dashboard para acompanhar o progresso
- Comentários e troca de experiências sobre os jogos
- Participação de desenvolvedores indie nas conversas

## Tecnologias

- HTML
- CSS
- JavaScript
- MySQL
- web-data-viz (API da faculdade)
- dat-acqu-ino (API da faculdade)

## Como rodar o projeto

1. Clone o repositório:

```
git clone https://github.com/ernani-carvalho/projeto-individual.git
```

2. Abra o arquivo `web-data-viz/src/database/script-tabelas.sql` no MySQL Workbench e execute o script.

3. Confira se o usuário e a senha do seu MySQL estão certos no arquivo `.env.dev` da web-data-viz.

4. Entre na pasta da web-data-viz, instale as dependências e inicie o servidor:

```
cd web-data-viz
npm install
npm start
```

5. Abra no navegador o endereço que aparecer no terminal.

## Estrutura

- `web-data-viz/public`: páginas HTML, CSS, JavaScript e imagens do site
- `web-data-viz/src`: rotas, controllers, models e conexão com o banco
- `dat-acqu-ino`: API da faculdade para captura de dados
- `AGENTS.md`: regras e contexto do projeto para agentes de IA

## Autor

Projeto feito por [ernani-carvalho](https://github.com/ernani-carvalho).
