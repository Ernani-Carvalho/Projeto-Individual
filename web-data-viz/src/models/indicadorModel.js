var database = require("../database/config");

function contarJogadores() {
    var instrucaoSql = `SELECT COUNT(id) AS total FROM usuario;`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function somarHoras() {
    var instrucaoSql = `SELECT IFNULL(SUM(horas), 0) AS total FROM progresso;`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function contarBossesDerrotados() {
    var instrucaoSql = `SELECT COUNT(id) AS total FROM boss_derrotado;`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function contarJogos() {
    var instrucaoSql = `SELECT COUNT(id) AS total FROM jogo;`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    contarJogadores,
    somarHoras,
    contarBossesDerrotados,
    contarJogos
};
