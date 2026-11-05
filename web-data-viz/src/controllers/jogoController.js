var jogoModel = require("../models/jogoModel");

function buscarMedias(req, res) {
    var idJogo = req.params.idJogo;

    jogoModel.buscarMedias(idJogo)
        .then(function (resultado) {
            res.status(200).json(resultado);
        })
        .catch(function (erro) {
            console.log(erro);
            console.log("Houve um erro ao buscar as médias: ", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
}

function listarBosses(req, res) {
    jogoModel.listarBosses(req.params.idJogo)
        .then(function (resultado) {
            res.status(200).json(resultado);
        })
        .catch(function (erro) {
            console.log(erro);
            res.status(500).json(erro.sqlMessage);
        });
}

module.exports = {
    buscarMedias,
    listarBosses
};
