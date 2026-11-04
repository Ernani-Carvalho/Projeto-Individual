-- ===================================================================
-- FirstRun: script do banco de dados
--
-- Ter este arquivo aqui não cria nada: é preciso rodar no MySQL da VM.
--
--   Parte 1: banco e tabelas
--   Parte 2: catálogo de jogos e bosses
--   Parte 3: textos da página de cada jogo
--   Parte 4: usuário que a API usa
--   Parte 5: selects da dashboard
-- ===================================================================


-- ===================================================================
-- PARTE 1: BANCO E TABELAS
-- ===================================================================

CREATE DATABASE firstrun;

USE firstrun;

-- Jogadores que criam conta no site
CREATE TABLE usuario (
	id    INT PRIMARY KEY AUTO_INCREMENT,
	nome  VARCHAR(50),
	email VARCHAR(100),
	senha VARCHAR(50),
	CONSTRAINT uq_usuario_email UNIQUE (email)
);

-- Catálogo fixo de jogos: só muda por este script
-- A coluna imagem guarda o nome do arquivo, que é igual nas duas pastas:
-- a capa fica em assets/jogos/ e o cenário em assets/cenarios/
CREATE TABLE jogo (
	id        INT PRIMARY KEY AUTO_INCREMENT,
	nome      VARCHAR(60),
	estudio   VARCHAR(50),
	ano       INT,
	genero    VARCHAR(30),
	imagem    VARCHAR(30),
	lema      VARCHAR(150),
	temas     VARCHAR(150),
	filosofia VARCHAR(1500)
);

-- Cada boss é de um jogo só (jogo 1:N boss)
CREATE TABLE boss (
	id      INT PRIMARY KEY AUTO_INCREMENT,
	nome    VARCHAR(50),
	fk_jogo INT,
	CONSTRAINT fk_boss_jogo FOREIGN KEY (fk_jogo) REFERENCES jogo(id)
);

-- Horas e status de cada jogador em cada jogo (usuario N:N jogo)
-- O UNIQUE deixa uma linha só por jogador e jogo: registrar de novo vira UPDATE
CREATE TABLE progresso (
	id         INT PRIMARY KEY AUTO_INCREMENT,
	fk_usuario INT,
	fk_jogo    INT,
	horas      INT DEFAULT 0,
	status     VARCHAR(10) DEFAULT 'jogando',
	CONSTRAINT fk_progresso_usuario FOREIGN KEY (fk_usuario) REFERENCES usuario(id),
	CONSTRAINT fk_progresso_jogo FOREIGN KEY (fk_jogo) REFERENCES jogo(id),
	CONSTRAINT uq_progresso UNIQUE (fk_usuario, fk_jogo),
	CONSTRAINT chk_progresso_horas CHECK (horas >= 0),
	CONSTRAINT chk_progresso_status CHECK (
		status = 'jogando' OR status = 'zerado' OR status = 'pausado'
	)
);

-- Bosses que cada jogador derrotou (usuario N:N boss)
CREATE TABLE boss_derrotado (
	id          INT PRIMARY KEY AUTO_INCREMENT,
	fk_usuario  INT,
	fk_boss     INT,
	tentativas  INT,
	dificuldade INT,
	CONSTRAINT fk_derrotado_usuario FOREIGN KEY (fk_usuario) REFERENCES usuario(id),
	CONSTRAINT fk_derrotado_boss FOREIGN KEY (fk_boss) REFERENCES boss(id),
	CONSTRAINT uq_boss_derrotado UNIQUE (fk_usuario, fk_boss),
	CONSTRAINT chk_derrotado_tentativas CHECK (tentativas >= 1),
	CONSTRAINT chk_derrotado_dificuldade CHECK (dificuldade >= 1 AND dificuldade <= 5)
);


-- ===================================================================
-- PARTE 2: CATÁLOGO DE JOGOS E BOSSES
-- ===================================================================

-- O id de cada jogo segue a ordem desta lista (1 = Hollow Knight ... 9 = Ori)
INSERT INTO jogo (nome, estudio, ano, genero, imagem) VALUES
('Hollow Knight',            'Team Cherry',        2017, 'Metroidvania', 'hollow-knight.jpg'),
('Hollow Knight: Silksong',  'Team Cherry',        2025, 'Metroidvania', 'silksong.jpg'),
('Hades',                    'Supergiant Games',   2020, 'Roguelike',    'hades.jpg'),
('Cuphead',                  'Studio MDHR',        2017, 'Run and gun',  'cuphead.jpg'),
('Celeste',                  'Extremely OK Games', 2018, 'Plataforma',   'celeste.jpg'),
('Dead Cells',               'Motion Twin',        2018, 'Roguelite',    'dead-cells.jpg'),
('Undertale',                'Toby Fox',           2015, 'RPG',          'undertale.jpg'),
('Blasphemous',              'The Game Kitchen',   2019, 'Metroidvania', 'blasphemous.jpg'),
('Ori and the Blind Forest', 'Moon Studios',       2015, 'Metroidvania', 'ori.jpg');

-- O número depois do nome é o id do jogo
INSERT INTO boss (nome, fk_jogo) VALUES
-- Hollow Knight
('False Knight', 1),
('Hornet', 1),
('Mantis Lords', 1),
('Soul Master', 1),
('Watcher Knights', 1),
('The Hollow Knight', 1),
('Nightmare King Grimm', 1),
('The Radiance', 1),
-- Hollow Knight: Silksong
('Moss Mother', 2),
('Bell Beast', 2),
('Lace', 2),
('Widow', 2),
('Grand Mother Silk', 2),
-- Hades
('Megaera', 3),
('Lernaean Bone Hydra', 3),
('Theseus e Asterius', 3),
('Hades', 3),
-- Cuphead
('The Root Pack', 4),
('Goopy Le Grande', 4),
('Hilda Berg', 4),
('Cagney Carnation', 4),
('Grim Matchstick', 4),
('King Dice', 4),
('The Devil', 4),
-- Celeste
('Mr. Oshiro', 5),
('Badeline', 5),
-- Dead Cells
('The Concierge', 6),
('Conjunctivius', 6),
('The Time Keeper', 6),
('The Giant', 6),
('The Hand of the King', 6),
-- Undertale
('Toriel', 7),
('Papyrus', 7),
('Undyne', 7),
('Mettaton EX', 7),
('Asgore', 7),
('Sans', 7),
-- Blasphemous
('Ten Piedad', 8),
('Tres Angustias', 8),
('Esdras', 8),
('Crisanta', 8),
-- Ori and the Blind Forest
('Ginso Tree Escape', 9),
('Forlorn Ruins Escape', 9),
('Mount Horu Escape', 9);


-- ===================================================================
-- PARTE 3: TEXTOS DA PÁGINA DE CADA JOGO
--
-- O CONCAT junta os pedaços num texto só, para as linhas não ficarem enormes.
-- O \n\n separa os parágrafos: na página, use white-space: pre-line no CSS.
-- ===================================================================

-- Hollow Knight
UPDATE jogo SET
	lema = 'Nenhum reino dura para sempre, mas ainda vale a pena explorar o que restou.',
	temas = 'Sacrifício, Memória, Exploração, Solidão, Persistência',
	filosofia = CONCAT(
		'Hallownest foi um reino que quis durar para sempre. Para isso, o rei prendeu ',
		'um mal antigo dentro de criaturas vazias, os Vasos, que deveriam existir sem ',
		'mente, sem vontade e sem voz. Quando você chega, o reino já está em ruínas: ',
		'o preço de tentar ser eterno foi alto demais.\n\n',

		'O jogo quase não explica nada. O mapa precisa ser comprado e desenhado, e a ',
		'história aparece em pedaços, em placas, conversas e lugares abandonados. Quem ',
		'joga monta o quebra-cabeça sozinho, e a sensação de descoberta é a recompensa.\n\n',

		'Quando você morre, deixa para trás uma sombra com o seu dinheiro e precisa ',
		'voltar até ela para recuperar tudo. Errar custa caro, mas sempre dá para ',
		'voltar e tentar de novo.'
	)
WHERE id = 1;

-- Hollow Knight: Silksong
UPDATE jogo SET
	lema = 'Subir até o topo para entender por que trouxeram você até aqui.',
	temas = 'Liberdade, Controle, Coragem, Identidade',
	filosofia = CONCAT(
		'Hornet, que no primeiro jogo era rival e aliada do Cavaleiro, agora é a ',
		'protagonista. Ela é capturada e levada para Pharloom, um reino governado pela ',
		'seda e pela música, e precisa subir até a cidadela no topo para descobrir quem ',
		'a trouxe e por quê.\n\n',

		'Diferente do Cavaleiro, Hornet fala, tem personalidade e já sabe lutar desde o ',
		'começo. A jornada fala de liberdade, de quem controla quem e de recusar o lugar ',
		'que outros escolheram para você.'
	)
WHERE id = 2;

-- Hades
UPDATE jogo SET
	lema = 'Cada derrota leva de volta para casa, e cada volta conta um pouco mais da história.',
	temas = 'Família, Perdão, Persistência, Mitologia grega',
	filosofia = CONCAT(
		'Zagreus é filho de Hades e quer fugir do submundo para encontrar a mãe que ',
		'nunca conheceu. Os deuses do Olimpo ajudam com poderes, e cada fuga é uma ',
		'corrida diferente.\n\n',

		'Aqui morrer não é fracasso. Cada morte leva Zagreus de volta para a casa do ',
		'pai, onde ele conversa com os personagens e a história avança. O jogo foi feito ',
		'para que tentar de novo seja sempre interessante.\n\n',

		'No fundo, é uma história sobre família: um pai difícil, um filho teimoso e a ',
		'tentativa de consertar o que ficou quebrado entre eles.'
	)
WHERE id = 3;

-- Cuphead
UPDATE jogo SET
	lema = 'Não faça acordo com o Diabo, e não desista depois de errar.',
	temas = 'Persistência, Consequência, Animação clássica',
	filosofia = CONCAT(
		'Cuphead e Mugman apostaram a própria alma no cassino do Diabo e perderam. Para ',
		'não pagar a dívida, aceitam cobrar a alma de outros devedores, e cada um deles ',
		'é um boss.\n\n',

		'O visual imita os desenhos animados dos anos 30: as animações foram desenhadas ',
		'à mão e os cenários pintados em aquarela. A trilha é jazz tocado por músicos ',
		'de verdade.\n\n',

		'É um jogo sobre insistir. Cada luta tem padrões que se aprende morrendo, e a ',
		'vitória vem de prestar atenção e não desistir.'
	)
WHERE id = 4;

-- Celeste
UPDATE jogo SET
	lema = 'Subir a montanha não é vencer a si mesmo, é aprender a andar junto consigo.',
	temas = 'Ansiedade, Saúde mental, Autoaceitação, Superação',
	filosofia = CONCAT(
		'Madeline decide escalar a montanha Celeste sem saber direito por quê. No ',
		'caminho, encontra Badeline, uma versão sombria de si mesma, que tenta fazê-la ',
		'desistir.\n\n',

		'Badeline representa a ansiedade e a voz que diz que ela não é capaz. A virada ',
		'da história não é derrotar essa parte, e sim aceitar e aprender a conviver ',
		'com ela.\n\n',

		'O jogo é muito difícil, mas é gentil com quem joga: trata cada morte como ',
		'aprendizado, volta rápido para a próxima tentativa e tem um modo de assistência ',
		'para quem precisa de ajuda.'
	)
WHERE id = 5;

-- Dead Cells
UPDATE jogo SET
	lema = 'Morrer faz parte, desde que você volte melhor.',
	temas = 'Recomeço, Aprendizado, Persistência, Humor',
	filosofia = CONCAT(
		'Uma ilha foi tomada por uma praga chamada Malaise. O personagem é um amontoado ',
		'de células que toma o corpo de um prisioneiro e tenta escapar do castelo.\n\n',

		'Cada morte volta tudo ao começo e o mapa muda, mas as células coletadas liberam ',
		'armas e melhorias que ficam para sempre. O que você aprende também fica: os ',
		'inimigos, os atalhos e o seu próprio jeito de jogar.\n\n',

		'Com bastante humor, o jogo mostra que repetir não é andar em círculos: cada ',
		'volta deixa você um pouco mais forte.'
	)
WHERE id = 6;

-- Undertale
UPDATE jogo SET
	lema = 'Ninguém precisa morrer.',
	temas = 'Misericórdia, Empatia, Escolhas, Consequência',
	filosofia = CONCAT(
		'Uma criança humana cai no Subsolo, onde os monstros ficaram presos depois de ',
		'uma guerra contra os humanos. Todo monstro que aparece pode ser enfrentado ou ',
		'poupado.\n\n',

		'Dá para terminar o jogo sem matar ninguém, conversando e entendendo cada ',
		'personagem. E o jogo lembra das suas escolhas, até das que você tentou desfazer ',
		'reiniciando.\n\n',

		'Undertale brinca com o que os RPGs ensinam, como lutar e subir de nível, e ',
		'pergunta se isso é mesmo necessário. É um jogo sobre misericórdia, empatia e ',
		'as consequências dos nossos atos.'
	)
WHERE id = 7;

-- Blasphemous
UPDATE jogo SET
	lema = 'Uma fé que exige sofrimento cobra um preço de todos.',
	temas = 'Culpa, Fé, Penitência, Fanatismo',
	filosofia = CONCAT(
		'Cvstodia é uma terra amaldiçoada por um poder chamado o Milagre, que transforma ',
		'culpa em castigo de verdade. O Penitente, último membro de uma irmandade de ',
		'penitentes, atravessa esse mundo carregando o peso da própria culpa.\n\n',

		'O visual vem da arte religiosa espanhola e das procissões da Semana Santa da ',
		'Andaluzia: imagens bonitas e assustadoras ao mesmo tempo.\n\n',

		'A história faz pensar sobre fé, culpa, sofrimento e fanatismo, e sobre até onde ',
		'alguém vai para pagar por algo.'
	)
WHERE id = 8;

-- Ori and the Blind Forest
UPDATE jogo SET
	lema = 'Ninguém ali é mau à toa: até a raiva nasce de uma perda.',
	temas = 'Luto, Perdão, Família, Natureza',
	filosofia = CONCAT(
		'Durante uma tempestade, o pequeno espírito Ori cai da Árvore Espiritual e é ',
		'adotado por Naru, que cuida dele como filho. Quando a floresta de Nibel começa ',
		'a morrer, Ori perde Naru e fica sozinho.\n\n',

		'Com a ajuda de Sein, a luz da Árvore, Ori tenta salvar a floresta. A grande ',
		'inimiga é a coruja Kuro, mas o jogo mostra que ela também perdeu os filhos, e ',
		'a dor dela explica a raiva.\n\n',

		'É uma história sobre luto, perdão e família, contada quase sem palavras, só ',
		'com imagens e música.'
	)
WHERE id = 9;


-- ===================================================================
-- PARTE 4: USUÁRIO QUE A API USA
--
-- Só com o que ela precisa e só neste banco.
-- Troque usuario e senha pelos seus, tire os dois traços e rode como root na VM.
-- Depois coloque o mesmo usuário e senha no .env.dev (nunca aqui).
-- ===================================================================

-- CREATE USER 'usuario'@'%' IDENTIFIED BY 'senha';
-- GRANT SELECT, INSERT, UPDATE, DELETE ON firstrun.* TO 'usuario'@'%';


-- ===================================================================
-- PARTE 5: SELECTS DA DASHBOARD
--
-- O 1 em fk_usuario = 1 é só um exemplo: no model ele vira ${idUsuario}.
--
-- COUNT conta linhas, SUM soma os valores e GROUP BY faz a conta por grupo.
-- IFNULL devolve 0 no lugar de NULL quando o jogador ainda não tem dados.
-- ===================================================================

-- Painel de boas-vindas: jogo mais jogado (o de mais horas)
SELECT jogo.nome, jogo.imagem, progresso.horas
FROM progresso
JOIN jogo ON progresso.fk_jogo = jogo.id
WHERE progresso.fk_usuario = 1
ORDER BY progresso.horas DESC
LIMIT 1;

-- Indicadores "Total de horas" e "Jogos cadastrados" (com quantos estão zerados)
SELECT
	IFNULL(SUM(horas), 0) AS total_horas,
	COUNT(id) AS total_jogos,
	IFNULL(SUM(CASE WHEN status = 'zerado' THEN 1 ELSE 0 END), 0) AS jogos_zerados
FROM progresso
WHERE fk_usuario = 1;

-- Indicador "Bosses derrotados" (com o total de tentativas)
SELECT
	COUNT(id) AS total_bosses,
	IFNULL(SUM(tentativas), 0) AS total_tentativas
FROM boss_derrotado
WHERE fk_usuario = 1;

-- Gráfico de barras "Horas por jogo"
SELECT jogo.nome, progresso.horas
FROM progresso
JOIN jogo ON progresso.fk_jogo = jogo.id
WHERE progresso.fk_usuario = 1
ORDER BY progresso.horas DESC;

-- Cartão "Boss mais difícil": maior dificuldade e, no empate, mais tentativas
SELECT
	boss.nome AS boss,
	jogo.nome AS jogo,
	boss_derrotado.dificuldade,
	boss_derrotado.tentativas
FROM boss_derrotado
JOIN boss ON boss_derrotado.fk_boss = boss.id
JOIN jogo ON boss.fk_jogo = jogo.id
WHERE boss_derrotado.fk_usuario = 1
ORDER BY boss_derrotado.dificuldade DESC, boss_derrotado.tentativas DESC
LIMIT 1;

-- Gráficos de rosca "Conclusão de cada jogo"
-- O LEFT JOIN mantém os bosses que o jogador ainda não derrotou.
-- A porcentagem é feita na página: bosses_derrotados / total_bosses * 100
SELECT
	jogo.nome,
	COUNT(boss.id) AS total_bosses,
	COUNT(boss_derrotado.id) AS bosses_derrotados
FROM progresso
JOIN jogo ON progresso.fk_jogo = jogo.id
JOIN boss ON boss.fk_jogo = jogo.id
LEFT JOIN boss_derrotado ON boss_derrotado.fk_boss = boss.id
	AND boss_derrotado.fk_usuario = progresso.fk_usuario
WHERE progresso.fk_usuario = 1
GROUP BY jogo.id, jogo.nome
ORDER BY jogo.nome;

-- Gráfico de rosca "Jogos por status"
SELECT status, COUNT(id) AS quantidade
FROM progresso
WHERE fk_usuario = 1
GROUP BY status;

-- "Você x média dos jogadores": os totais de todos os jogadores.
-- Os valores do jogador já vêm dos indicadores acima. Na página:
-- média = total de todos / total_jogadores
-- comparação = (valor do jogador - média) / média * 100
SELECT COUNT(id) AS total_jogadores
FROM usuario;

SELECT IFNULL(SUM(horas), 0) AS horas_de_todos
FROM progresso;

SELECT
	COUNT(id) AS bosses_de_todos,
	IFNULL(SUM(tentativas), 0) AS tentativas_de_todos
FROM boss_derrotado;
