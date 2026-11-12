var database = require("../database/config");

// as consultas usam as views do script (vw_progresso, vw_boss_derrotado e vw_conclusao)

// total de horas e quantidade de jogos do jogador
function buscarTotais(idUsuario) {
    var instrucaoSql = `
        SELECT IFNULL(SUM(horas), 0) AS total_horas, COUNT(jogo) AS total_jogos
        FROM vw_progresso
        WHERE fk_usuario = ${idUsuario};
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

// horas de cada jogo, do mais jogado para o menos jogado (o primeiro é o jogo mais jogado)
function buscarHorasPorJogo(idUsuario) {
    var instrucaoSql = `
        SELECT jogo, imagem, horas
        FROM vw_progresso
        WHERE fk_usuario = ${idUsuario}
        ORDER BY horas DESC;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

// total de bosses e quantos o jogador derrotou em cada jogo
function buscarConclusao(idUsuario) {
    var instrucaoSql = `
        SELECT jogo, total_bosses, bosses_derrotados
        FROM vw_conclusao
        WHERE fk_usuario = ${idUsuario}
        ORDER BY jogo;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

// quantos bosses o jogador marcou em cada dificuldade (de 1 a 5)
function buscarDificuldades(idUsuario) {
    var instrucaoSql = `
        SELECT dificuldade, COUNT(boss) AS quantidade
        FROM vw_boss_derrotado
        WHERE fk_usuario = ${idUsuario}
        GROUP BY dificuldade
        ORDER BY dificuldade;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

// boss mais difícil: maior dificuldade e, no empate, mais tentativas
function buscarBossMaisDificil(idUsuario) {
    var instrucaoSql = `
        SELECT boss, jogo, dificuldade, tentativas
        FROM vw_boss_derrotado
        WHERE fk_usuario = ${idUsuario}
        ORDER BY dificuldade DESC, tentativas DESC
        LIMIT 1;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarTotais,
    buscarHorasPorJogo,
    buscarConclusao,
    buscarDificuldades,
    buscarBossMaisDificil
};
