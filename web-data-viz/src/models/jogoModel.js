var database = require("../database/config");

function listarBosses(idJogo) {
    var instrucaoSql = `
        SELECT id, nome FROM boss WHERE fk_jogo = ${idJogo} ORDER BY id;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    listarBosses
};
