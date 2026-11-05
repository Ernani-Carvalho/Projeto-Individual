var database = require("../database/config");

function buscarMedias(idJogo) {
    var instrucaoSql = `
        SELECT boss.id, ROUND(AVG(boss_derrotado.tentativas)) AS media_tentativas
        FROM boss_derrotado
        JOIN boss ON boss_derrotado.fk_boss = boss.id
        WHERE boss.fk_jogo = ${idJogo}
        GROUP BY boss.id;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listarBosses(idJogo) {
    var instrucaoSql = `
        SELECT id, nome FROM boss WHERE fk_jogo = ${idJogo} ORDER BY id;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarMedias,
    listarBosses
};
