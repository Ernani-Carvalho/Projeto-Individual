var jogoModel = require("../models/jogoModel");

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
    listarBosses
};
