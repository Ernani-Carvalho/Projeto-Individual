var dashboardModel = require("../models/dashboardModel");

// todas as funções fazem a mesma coisa: pegam o id do jogador na rota,
// chamam o model e devolvem o resultado do SELECT em JSON

function buscarTotais(req, res) {
    dashboardModel.buscarTotais(req.params.idUsuario)
        .then(function (resultado) {
            res.status(200).json(resultado);
        })
        .catch(function (erro) {
            console.log(erro);
            res.status(500).json(erro.sqlMessage);
        });
}

function buscarHorasPorJogo(req, res) {
    dashboardModel.buscarHorasPorJogo(req.params.idUsuario)
        .then(function (resultado) {
            res.status(200).json(resultado);
        })
        .catch(function (erro) {
            console.log(erro);
            res.status(500).json(erro.sqlMessage);
        });
}

function buscarConclusao(req, res) {
    dashboardModel.buscarConclusao(req.params.idUsuario)
        .then(function (resultado) {
            res.status(200).json(resultado);
        })
        .catch(function (erro) {
            console.log(erro);
            res.status(500).json(erro.sqlMessage);
        });
}

function buscarDificuldades(req, res) {
    dashboardModel.buscarDificuldades(req.params.idUsuario)
        .then(function (resultado) {
            res.status(200).json(resultado);
        })
        .catch(function (erro) {
            console.log(erro);
            res.status(500).json(erro.sqlMessage);
        });
}

function buscarBossMaisDificil(req, res) {
    dashboardModel.buscarBossMaisDificil(req.params.idUsuario)
        .then(function (resultado) {
            res.status(200).json(resultado);
        })
        .catch(function (erro) {
            console.log(erro);
            res.status(500).json(erro.sqlMessage);
        });
}

module.exports = {
    buscarTotais,
    buscarHorasPorJogo,
    buscarConclusao,
    buscarDificuldades,
    buscarBossMaisDificil
};
