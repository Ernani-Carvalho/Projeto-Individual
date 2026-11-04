-- Script do banco do FirstRun.
-- Ter este arquivo aqui não cria nada: é preciso rodar o script inteiro no MySQL da VM.

CREATE DATABASE firstrun;

USE firstrun;

-- Jogadores que criam conta no site
CREATE TABLE usuario (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50),
	email VARCHAR(100),
	senha VARCHAR(50),
	CONSTRAINT uq_usuario_email UNIQUE (email)
);

-- Catálogo fixo de jogos: só muda por este script
CREATE TABLE jogo (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(60),
	estudio VARCHAR(50),
	ano INT,
	genero VARCHAR(30),
	criadores VARCHAR(80),
	pais VARCHAR(50),
	descricao VARCHAR(200),
	lema VARCHAR(150),
	temas VARCHAR(150),
	filosofia VARCHAR(1500),
	capa VARCHAR(100),
	cenario VARCHAR(100)
);

-- Cada boss é de um jogo só (jogo 1:N boss)
CREATE TABLE boss (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50),
	fk_jogo INT,
	CONSTRAINT fk_boss_jogo FOREIGN KEY (fk_jogo) REFERENCES jogo(id)
);

-- Horas e status de cada jogador em cada jogo (usuario N:N jogo)
-- O UNIQUE deixa uma linha só por jogador e jogo: registrar de novo vira UPDATE
CREATE TABLE progresso (
	id INT PRIMARY KEY AUTO_INCREMENT,
	fk_usuario INT,
	fk_jogo INT,
	horas INT DEFAULT 0,
	status VARCHAR(10) DEFAULT 'jogando',
	CONSTRAINT fk_progresso_usuario FOREIGN KEY (fk_usuario) REFERENCES usuario(id),
	CONSTRAINT fk_progresso_jogo FOREIGN KEY (fk_jogo) REFERENCES jogo(id),
	CONSTRAINT uq_progresso UNIQUE (fk_usuario, fk_jogo),
	CONSTRAINT chk_progresso_horas CHECK (horas >= 0),
	CONSTRAINT chk_progresso_status CHECK (status = 'jogando' OR status = 'zerado' OR status = 'pausado')
);

-- Bosses que cada jogador derrotou (usuario N:N boss)
CREATE TABLE boss_derrotado (
	id INT PRIMARY KEY AUTO_INCREMENT,
	fk_usuario INT,
	fk_boss INT,
	tentativas INT,
	dificuldade INT,
	CONSTRAINT fk_derrotado_usuario FOREIGN KEY (fk_usuario) REFERENCES usuario(id),
	CONSTRAINT fk_derrotado_boss FOREIGN KEY (fk_boss) REFERENCES boss(id),
	CONSTRAINT uq_boss_derrotado UNIQUE (fk_usuario, fk_boss),
	CONSTRAINT chk_derrotado_tentativas CHECK (tentativas >= 1),
	CONSTRAINT chk_derrotado_dificuldade CHECK (dificuldade >= 1 AND dificuldade <= 5)
);

INSERT INTO jogo (nome, estudio, ano, genero, criadores, pais, descricao, lema, temas, filosofia, capa, cenario) VALUES
('Hollow Knight', 'Team Cherry', 2017, 'Metroidvania', 'Ari Gibson e William Pellen', 'Austrália',
'Um cavaleiro sem nome explora Hallownest, um reino de insetos em ruínas, cheio de segredos e de bosses que pedem paciência.',
'Nenhum reino dura para sempre, mas ainda vale a pena explorar o que restou.',
'Sacrifício, Memória, Exploração, Solidão, Persistência',
'Hallownest foi um reino que quis durar para sempre. Para isso, o rei prendeu um mal antigo dentro de criaturas vazias, os Vasos, que deveriam existir sem mente, sem vontade e sem voz. Quando você chega, o reino já está em ruínas: o preço de tentar ser eterno foi alto demais.

O jogo quase não explica nada. O mapa precisa ser comprado e desenhado, e a história aparece em pedaços, em placas, conversas e lugares abandonados. Quem joga monta o quebra-cabeça sozinho, e a sensação de descoberta é a recompensa.

Quando você morre, deixa para trás uma sombra com o seu dinheiro e precisa voltar até ela para recuperar tudo. Errar custa caro, mas sempre dá para voltar e tentar de novo.',
'assets/jogos/hollow-knight.jpg', 'assets/cenarios/hollow-knight.jpg'),

('Hollow Knight: Silksong', 'Team Cherry', 2025, 'Metroidvania', 'Ari Gibson e William Pellen', 'Austrália',
'Hornet é levada para Pharloom, um reino governado pela seda e pela música, e precisa subir até a cidadela no topo.',
'Subir até o topo para entender por que trouxeram você até aqui.',
'Liberdade, Controle, Coragem, Identidade',
'Hornet, que no primeiro jogo era rival e aliada do Cavaleiro, agora é a protagonista. Ela é capturada e levada para Pharloom, um reino governado pela seda e pela música, e precisa subir até a cidadela no topo para descobrir quem a trouxe e por quê.

Diferente do Cavaleiro, Hornet fala, tem personalidade e já sabe lutar desde o começo. A jornada fala de liberdade, de quem controla quem e de recusar o lugar que outros escolheram para você.',
'assets/jogos/silksong.jpg', 'assets/cenarios/silksong.jpg'),

('Hades', 'Supergiant Games', 2020, 'Roguelike', 'Equipe da Supergiant, estúdio de Bastion e Transistor', 'Estados Unidos',
'Zagreus tenta fugir do submundo grego. Cada tentativa de fuga muda um pouco a história e as armas disponíveis.',
'Cada derrota leva de volta para casa, e cada volta conta um pouco mais da história.',
'Família, Perdão, Persistência, Mitologia grega',
'Zagreus é filho de Hades e quer fugir do submundo para encontrar a mãe que nunca conheceu. Os deuses do Olimpo ajudam com poderes, e cada fuga é uma corrida diferente.

Aqui morrer não é fracasso. Cada morte leva Zagreus de volta para a casa do pai, onde ele conversa com os personagens e a história avança. O jogo foi feito para que tentar de novo seja sempre interessante.

No fundo, é uma história sobre família: um pai difícil, um filho teimoso e a tentativa de consertar o que ficou quebrado entre eles.',
'assets/jogos/hades.jpg', 'assets/cenarios/hades.jpg'),

('Cuphead', 'Studio MDHR', 2017, 'Run and gun', 'Chad e Jared Moldenhauer', 'Canadá',
'Inspirado nos desenhos animados dos anos 30, é quase só uma sequência de lutas contra bosses, uma mais difícil que a outra.',
'Não faça acordo com o Diabo, e não desista depois de errar.',
'Persistência, Consequência, Animação clássica',
'Cuphead e Mugman apostaram a própria alma no cassino do Diabo e perderam. Para não pagar a dívida, aceitam cobrar a alma de outros devedores, e cada um deles é um boss.

O visual imita os desenhos animados dos anos 30: as animações foram desenhadas à mão e os cenários pintados em aquarela. A trilha é jazz tocado por músicos de verdade.

É um jogo sobre insistir. Cada luta tem padrões que se aprende morrendo, e a vitória vem de prestar atenção e não desistir.',
'assets/jogos/cuphead.jpg', 'assets/cenarios/cuphead.jpg'),

('Celeste', 'Extremely OK Games', 2018, 'Plataforma', 'Maddy Thorson e Noel Berry', 'Canadá',
'Madeline decide escalar a montanha Celeste. Um jogo de plataforma difícil e preciso, que fala sobre ansiedade e superação.',
'Subir a montanha não é vencer a si mesmo, é aprender a andar junto consigo.',
'Ansiedade, Saúde mental, Autoaceitação, Superação',
'Madeline decide escalar a montanha Celeste sem saber direito por quê. No caminho, encontra Badeline, uma versão sombria de si mesma, que tenta fazê-la desistir.

Badeline representa a ansiedade e a voz que diz que ela não é capaz. A virada da história não é derrotar essa parte, e sim aceitar e aprender a conviver com ela.

O jogo é muito difícil, mas é gentil com quem joga: trata cada morte como aprendizado, volta rápido para a próxima tentativa e tem um modo de assistência para quem precisa de ajuda.',
'assets/jogos/celeste.jpg', 'assets/cenarios/celeste.jpg'),

('Dead Cells', 'Motion Twin', 2018, 'Roguelite', 'Motion Twin (hoje continuado pela Evil Empire)', 'França',
'Um roguelite de ação em que cada morte leva de volta ao começo, mas com novas armas e caminhos liberados.',
'Morrer faz parte, desde que você volte melhor.',
'Recomeço, Aprendizado, Persistência, Humor',
'Uma ilha foi tomada por uma praga chamada Malaise. O personagem é um amontoado de células que toma o corpo de um prisioneiro e tenta escapar do castelo.

Cada morte volta tudo ao começo e o mapa muda, mas as células coletadas liberam armas e melhorias que ficam para sempre. O que você aprende também fica: os inimigos, os atalhos e o seu próprio jeito de jogar.

Com bastante humor, o jogo mostra que repetir não é andar em círculos: cada volta deixa você um pouco mais forte.',
'assets/jogos/dead-cells.jpg', 'assets/cenarios/dead-cells.jpg'),

('Undertale', 'Toby Fox', 2015, 'RPG', 'Toby Fox, com arte de Temmie Chang', 'Estados Unidos',
'Um RPG em que dá para terminar o jogo sem derrotar ninguém. As escolhas do jogador mudam o final.',
'Ninguém precisa morrer.',
'Misericórdia, Empatia, Escolhas, Consequência',
'Uma criança humana cai no Subsolo, onde os monstros ficaram presos depois de uma guerra contra os humanos. Todo monstro que aparece pode ser enfrentado ou poupado.

Dá para terminar o jogo sem matar ninguém, conversando e entendendo cada personagem. E o jogo lembra das suas escolhas, até das que você tentou desfazer reiniciando.

Undertale brinca com o que os RPGs ensinam, como lutar e subir de nível, e pergunta se isso é mesmo necessário. É um jogo sobre misericórdia, empatia e as consequências dos nossos atos.',
'assets/jogos/undertale.jpg', 'assets/cenarios/undertale.jpg'),

('Blasphemous', 'The Game Kitchen', 2019, 'Metroidvania', 'The Game Kitchen', 'Espanha',
'Um metroidvania sombrio inspirado na arte religiosa espanhola, com combate pesado e pixel art detalhada.',
'Uma fé que exige sofrimento cobra um preço de todos.',
'Culpa, Fé, Penitência, Fanatismo',
'Cvstodia é uma terra amaldiçoada por um poder chamado o Milagre, que transforma culpa em castigo de verdade. O Penitente, último membro de uma irmandade de penitentes, atravessa esse mundo carregando o peso da própria culpa.

O visual vem da arte religiosa espanhola e das procissões da Semana Santa da Andaluzia: imagens bonitas e assustadoras ao mesmo tempo.

A história faz pensar sobre fé, culpa, sofrimento e fanatismo, e sobre até onde alguém vai para pagar por algo.',
'assets/jogos/blasphemous.jpg', 'assets/cenarios/blasphemous.jpg'),

('Ori and the Blind Forest', 'Moon Studios', 2015, 'Metroidvania', 'Moon Studios, fundado por Thomas Mahler e Gennadiy Korol', 'Equipe espalhada pelo mundo',
'Um pequeno espírito precisa trazer a luz de volta para a floresta de Nibel, numa aventura de plataforma linda e cheia de fugas difíceis.',
'Ninguém ali é mau à toa: até a raiva nasce de uma perda.',
'Luto, Perdão, Família, Natureza',
'Durante uma tempestade, o pequeno espírito Ori cai da Árvore Espiritual e é adotado por Naru, que cuida dele como filho. Quando a floresta de Nibel começa a morrer, Ori perde Naru e fica sozinho.

Com a ajuda de Sein, a luz da Árvore, Ori tenta salvar a floresta. A grande inimiga é a coruja Kuro, mas o jogo mostra que ela também perdeu os filhos, e a dor dela explica a raiva.

É uma história sobre luto, perdão e família, contada quase sem palavras, só com imagens e música.',
'assets/jogos/ori.jpg', 'assets/cenarios/ori.jpg');

-- O número no fim é o id do jogo, na ordem do INSERT acima (1 = Hollow Knight ... 9 = Ori)
INSERT INTO boss (nome, fk_jogo) VALUES
('False Knight', 1), ('Hornet', 1), ('Mantis Lords', 1), ('Soul Master', 1),
('Watcher Knights', 1), ('The Hollow Knight', 1), ('Nightmare King Grimm', 1), ('The Radiance', 1),
('Moss Mother', 2), ('Bell Beast', 2), ('Lace', 2), ('Widow', 2), ('Grand Mother Silk', 2),
('Megaera', 3), ('Lernaean Bone Hydra', 3), ('Theseus e Asterius', 3), ('Hades', 3),
('The Root Pack', 4), ('Goopy Le Grande', 4), ('Hilda Berg', 4), ('Cagney Carnation', 4),
('Grim Matchstick', 4), ('King Dice', 4), ('The Devil', 4),
('Mr. Oshiro', 5), ('Badeline', 5),
('The Concierge', 6), ('Conjunctivius', 6), ('The Time Keeper', 6), ('The Giant', 6), ('The Hand of the King', 6),
('Toriel', 7), ('Papyrus', 7), ('Undyne', 7), ('Mettaton EX', 7), ('Asgore', 7), ('Sans', 7),
('Ten Piedad', 8), ('Tres Angustias', 8), ('Esdras', 8), ('Crisanta', 8),
('Ginso Tree Escape', 9), ('Forlorn Ruins Escape', 9), ('Mount Horu Escape', 9);

-- Usuário que a API usa para entrar no banco, só com o que ela precisa e só neste banco.
-- Troque usuario e senha pelos seus, tire os dois traços e rode estas linhas como root na VM.
-- Depois coloque o mesmo usuário e senha no .env.dev (nunca aqui).
-- CREATE USER 'usuario'@'%' IDENTIFIED BY 'senha';
-- GRANT SELECT, INSERT, UPDATE, DELETE ON firstrun.* TO 'usuario'@'%';
