var database = require("../database/config");

function buscarProgresso(idUsuario, idJogo) {
    var instrucaoSql = `
        SELECT id FROM progresso WHERE fk_usuario = ${idUsuario} AND fk_jogo = ${idJogo};
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function inserirProgresso(idUsuario, idJogo, horas, status) {
    var instrucaoSql = `
        INSERT INTO progresso (fk_usuario, fk_jogo, horas, status) VALUES (${idUsuario}, ${idJogo}, ${horas}, '${status}');
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function atualizarProgresso(idUsuario, idJogo, horas, status) {
    var instrucaoSql = `
        UPDATE progresso SET horas = ${horas}, status = '${status}' WHERE fk_usuario = ${idUsuario} AND fk_jogo = ${idJogo};
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarBossDerrotado(idUsuario, idBoss) {
    var instrucaoSql = `
        SELECT id FROM boss_derrotado WHERE fk_usuario = ${idUsuario} AND fk_boss = ${idBoss};
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function inserirBossDerrotado(idUsuario, idBoss, tentativas, dificuldade) {
    var instrucaoSql = `
        INSERT INTO boss_derrotado (fk_usuario, fk_boss, tentativas, dificuldade) VALUES (${idUsuario}, ${idBoss}, ${tentativas}, ${dificuldade});
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function atualizarBossDerrotado(idUsuario, idBoss, tentativas, dificuldade) {
    var instrucaoSql = `
        UPDATE boss_derrotado SET tentativas = ${tentativas}, dificuldade = ${dificuldade} WHERE fk_usuario = ${idUsuario} AND fk_boss = ${idBoss};
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

// jogos do jogador, do que tem mais horas para o que tem menos
function listarJogos(idUsuario) {
    var instrucaoSql = `
        SELECT jogo.id, jogo.nome, progresso.horas, progresso.status
        FROM progresso
        JOIN jogo ON progresso.fk_jogo = jogo.id
        WHERE progresso.fk_usuario = ${idUsuario}
        ORDER BY progresso.horas DESC;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listarBosses(idUsuario) {
    var instrucaoSql = `
        SELECT boss.id, boss.nome AS boss, jogo.nome AS jogo, boss_derrotado.tentativas, boss_derrotado.dificuldade
        FROM boss_derrotado
        JOIN boss ON boss_derrotado.fk_boss = boss.id
        JOIN jogo ON boss.fk_jogo = jogo.id
        WHERE boss_derrotado.fk_usuario = ${idUsuario}
        ORDER BY jogo.nome, boss.id;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarProgresso,
    inserirProgresso,
    atualizarProgresso,
    buscarBossDerrotado,
    inserirBossDerrotado,
    atualizarBossDerrotado,
    listarJogos,
    listarBosses
};
