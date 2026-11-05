var indicadorModel = require("../models/indicadorModel");

// números da página inicial, somando todos os jogadores
// o Promise.all espera as 5 consultas terminarem e devolve os resultados na mesma ordem
function buscarGerais(req, res) {
    Promise.all([
        indicadorModel.contarJogadores(),
        indicadorModel.somarHoras(),
        indicadorModel.contarBossesDerrotados(),
        indicadorModel.contarJogos(),
        indicadorModel.buscarRanking()
    ]).then(function (resultados) {
        res.status(200).json({
            jogadores: resultados[0][0].total,
            horas: resultados[1][0].total,
            bosses: resultados[2][0].total,
            jogos: resultados[3][0].total,
            ranking: resultados[4]
        });
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar os indicadores: ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

module.exports = {
    buscarGerais
};
