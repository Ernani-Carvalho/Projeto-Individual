-- script do banco do FirstRun

CREATE DATABASE firstrun;

USE firstrun;

-- jogadores
CREATE TABLE usuario (
	id    INT PRIMARY KEY AUTO_INCREMENT,
	nome  VARCHAR(50),
	email VARCHAR(100),
	senha VARCHAR(50),
	CONSTRAINT uq_usuario_email UNIQUE (email)
);

-- jogos do catálogo
-- imagem é o nome do arquivo da capa, em assets/jogos
CREATE TABLE jogo (
	id     INT PRIMARY KEY AUTO_INCREMENT,
	nome   VARCHAR(60),
	imagem VARCHAR(30)
);

-- bosses de cada jogo
CREATE TABLE boss (
	id      INT PRIMARY KEY AUTO_INCREMENT,
	nome    VARCHAR(50),
	fk_jogo INT,
	CONSTRAINT fk_boss_jogo FOREIGN KEY (fk_jogo) REFERENCES jogo(id)
);

-- horas e status de cada jogador em cada jogo
-- unique: uma linha só por jogador em cada jogo
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

-- bosses que cada jogador derrotou
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

-- o id segue essa ordem e é o mesmo usado nas páginas em jogos/
INSERT INTO jogo (nome, imagem) VALUES
('Hollow Knight',            'hollow-knight.jpg'),
('Hollow Knight: Silksong',  'silksong.jpg'),
('Hades',                    'hades.jpg'),
('Cuphead',                  'cuphead.jpg'),
('Celeste',                  'celeste.jpg'),
('Dead Cells',               'dead-cells.jpg'),
('Undertale',                'undertale.jpg'),
('Blasphemous',              'blasphemous.jpg'),
('Ori and the Blind Forest', 'ori.jpg'),
('Nine Sols',                'nine-sols.jpg');

-- o número é o id do jogo. O id de cada boss segue esta ordem e é usado nas páginas em jogos/
INSERT INTO boss (nome, fk_jogo) VALUES
-- Hollow Knight
('False Knight', 1),
('Gruz Mother', 1),
('Massive Moss Charger', 1),
('Vengefly King', 1),
('Brooding Mawlek', 1),
('Hornet', 1),
('Mantis Lords', 1),
('Soul Warrior', 1),
('Soul Master', 1),
('Crystal Guardian', 1),
('Oblobbles', 1),
('Dung Defender', 1),
('Flukemarm', 1),
('God Tamer', 1),
('Hive Knight', 1),
('Broken Vessel', 1),
('Nosk', 1),
('Uumuu', 1),
('Traitor Lord', 1),
('The Collector', 1),
('Watcher Knights', 1),
('The Hollow Knight', 1),
('The Radiance', 1),
('Grimm', 1),
('Zote', 1),
('Elder Hu', 1),
('Galien', 1),
('Gorb', 1),
('Markoth', 1),
('Marmu', 1),
('No Eyes', 1),
('Xero', 1),
('Brothers Oro & Mato', 1),
('Paintmaster Sheo', 1),
('Great Nailsage Sly', 1),
-- Hollow Knight: Silksong
('Moss Mother', 2),
('Bell Beast', 2),
('Lace', 2),
('Fourth Chorus', 2),
('Savage Beastfly', 2),
('Skull Tyrant', 2),
('Sister Splinter', 2),
('Widow', 2),
('Phantom', 2),
('Moorwing', 2),
('Great Conchflies', 2),
('Last Judge', 2),
('Cogwork Dancers', 2),
('Trobbio', 2),
('Signis and Gron', 2),
('Groal the Great', 2),
('The Unraveled', 2),
('Disgraced Chef Lugoli', 2),
('First Sinner', 2),
('Craggler', 2),
('Father of the Flame', 2),
('Hunter Queen Carmelita', 2),
('Voltvyrm', 2),
('Second Sentinel', 2),
('Broodmother', 2),
('Bell Eater', 2),
('Plasmified Zango', 2),
('Crust King Khann', 2),
('Seth', 2),
('Nyleth', 2),
('Clover Dancers', 2),
('Pinstress', 2),
('Gurr the Outcast', 2),
('Watcher at the Edge', 2),
('Crawfather', 2),
('Summoned Saviour', 2),
('Shakra', 2),
('Garmond and Zaza', 2),
('Grand Mother Silk', 2),
-- Hades
('Megaera', 3),
('Alecto', 3),
('Tisiphone', 3),
('Lernaean Bone Hydra', 3),
('Theseus e Asterius', 3),
('Hades', 3),
('Charon', 3),
-- Cuphead
('The Root Pack', 4),
('Goopy Le Grande', 4),
('Hilda Berg', 4),
('Cagney Carnation', 4),
('Ribby and Croaks', 4),
('Baroness Von Bon Bon', 4),
('Djimmi The Great', 4),
('Beppi The Clown', 4),
('Wally Warbles', 4),
('Grim Matchstick', 4),
('Rumor Honeybottoms', 4),
('Captain Brineybeard', 4),
('Sally Stageplay', 4),
('Werner Werman', 4),
('Dr. Kahl''s Robot', 4),
('Cala Maria', 4),
('Phantom Express', 4),
('King Dice', 4),
('The Devil', 4),
('Glumstone The Giant', 4),
('Moonshine Mob', 4),
('Mortimer Freeze', 4),
('Esther Winchester', 4),
('The Howling Aces', 4),
('Chef Saltbaker', 4),
-- Celeste
('Mr. Oshiro', 5),
('Badeline', 5),
-- Dead Cells
('The Concierge', 6),
('Conjunctivius', 6),
('Mama Tick', 6),
('The Time Keeper', 6),
('The Giant', 6),
('The Scarecrow', 6),
('The Hand of the King', 6),
('The Servants', 6),
('The Queen', 6),
('The Collector', 6),
-- Undertale
('Toriel', 7),
('Napstablook', 7),
('Doggo', 7),
('Lesser Dog', 7),
('Dogamy and Dogaressa', 7),
('Greater Dog', 7),
('Papyrus', 7),
('Shyren', 7),
('Mad Dummy', 7),
('Undyne', 7),
('Glyde', 7),
('Royal Guards', 7),
('So Sorry', 7),
('Muffet', 7),
('Mettaton EX', 7),
('Asgore', 7),
('Omega Flowey', 7),
('Asriel Dreemurr', 7),
('Sans', 7),
('Endogeny', 7),
('Lemon Bread', 7),
('Reaper Bird', 7),
('Snowdrake''s Mother', 7),
('Memoryhead', 7),
-- Blasphemous
('Warden of the Silent Sorrow', 8),
('Ten Piedad', 8),
('Tres Angustias', 8),
('Esdras', 8),
('Melquiades', 8),
('Exposito', 8),
('Quirce', 8),
('Crisanta', 8),
('Our Lady of the Charred Visage', 8),
('Perpetva', 8),
('Last Son of the Miracle', 8),
('Sor Cautiva Del Silencio', 8),
('Escribar', 8),
('Laudes', 8),
('Amanecida of the Bejeweled Arrow', 8),
('Amanecida of the Chiselled Steel', 8),
('Amanecida of the Golden Blades', 8),
('Amanecida of the Molten Thorn', 8),
('Isidora', 8),
('Sierpes', 8),
-- Ori and the Blind Forest
('Ginso Tree Escape', 9),
('Forlorn Ruins Escape', 9),
('Mount Horu Escape', 9),
-- Nine Sols
('General Yingzhao', 10),
('Goumang', 10),
('Xingtian', 10),
('Yanlao', 10),
('Kanghui', 10),
('Jiequan', 10),
('Lady Ethereal', 10),
('Ji', 10),
('Fengs', 10),
('Eigong', 10),
('Red Tiger Elites', 10),
('Celestial Sentinels', 10),
('Celestial Spectres', 10),
('Celestial Enforcers', 10),
('Yinyue', 10),
('Cixing', 10),
('Tianshou', 10);

-- selects da dashboard
-- o 1 é o id do jogador, no model vira ${idUsuario}

-- jogo mais jogado
SELECT jogo.nome, jogo.imagem, progresso.horas
FROM progresso
JOIN jogo ON progresso.fk_jogo = jogo.id
WHERE progresso.fk_usuario = 1
ORDER BY progresso.horas DESC
LIMIT 1;

-- total de horas, de jogos e de zerados
SELECT
	IFNULL(SUM(horas), 0) AS total_horas,
	COUNT(id) AS total_jogos,
	IFNULL(SUM(CASE WHEN status = 'zerado' THEN 1 ELSE 0 END), 0) AS jogos_zerados
FROM progresso
WHERE fk_usuario = 1;

-- bosses derrotados e tentativas
SELECT
	COUNT(id) AS total_bosses,
	IFNULL(SUM(tentativas), 0) AS total_tentativas
FROM boss_derrotado
WHERE fk_usuario = 1;

-- horas por jogo
SELECT jogo.nome, progresso.horas
FROM progresso
JOIN jogo ON progresso.fk_jogo = jogo.id
WHERE progresso.fk_usuario = 1
ORDER BY progresso.horas DESC;

-- boss mais difícil: maior dificuldade, no empate mais tentativas
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

-- conclusão de cada jogo (a porcentagem é feita na página)
-- left join para contar também os bosses não derrotados
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

-- jogos por status
SELECT status, COUNT(id) AS quantidade
FROM progresso
WHERE fk_usuario = 1
GROUP BY status;

-- totais de todos os jogadores, para comparar com a média
SELECT COUNT(id) AS total_jogadores
FROM usuario;

SELECT IFNULL(SUM(horas), 0) AS horas_de_todos
FROM progresso;

SELECT
	COUNT(id) AS bosses_de_todos,
	IFNULL(SUM(tentativas), 0) AS tentativas_de_todos
FROM boss_derrotado;
