var progressoModel = require("../models/progressoModel");

// salva o jogo e, se idBoss for diferente de 0, salva o boss também
// em cada parte: se a linha já existe vira UPDATE, se não existe vira INSERT
function registrar(req, res) {
    var idUsuario = req.body.idUsuarioServer;
    var idJogo = req.body.idJogoServer;
    var horas = req.body.horasServer;
    var status = req.body.statusServer;
    var idBoss = req.body.idBossServer;
    var tentativas = req.body.tentativasServer;
    var dificuldade = req.body.dificuldadeServer;

    if (idUsuario == undefined || idJogo == undefined || horas == undefined || status == undefined || idBoss == undefined) {
        res.status(400).send("Algum dado está undefined!");
        return;
    }

    // 1º o jogo
    progressoModel.buscarProgresso(idUsuario, idJogo)
        .then(function (resultado) {
            if (resultado.length > 0) {
                return progressoModel.atualizarProgresso(idUsuario, idJogo, horas, status);
            } else {
                return progressoModel.inserirProgresso(idUsuario, idJogo, horas, status);
            }
        })
        // 2º o boss, só se algum foi escolhido
        .then(function () {
            if (idBoss == 0) {
                return;
            }
            return progressoModel.buscarBossDerrotado(idUsuario, idBoss);
        })
        .then(function (resultado) {
            if (idBoss == 0) {
                return;
            }
            if (resultado.length > 0) {
                return progressoModel.atualizarBossDerrotado(idUsuario, idBoss, tentativas, dificuldade);
            } else {
                return progressoModel.inserirBossDerrotado(idUsuario, idBoss, tentativas, dificuldade);
            }
        })
        .then(function () {
            res.status(200).send("Progresso salvo!");
        })
        .catch(function (erro) {
            console.log(erro);
            console.log("Houve um erro ao salvar o progresso: ", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
}

function listarJogos(req, res) {
    progressoModel.listarJogos(req.params.idUsuario)
        .then(function (resultado) {
            res.status(200).json(resultado);
        })
        .catch(function (erro) {
            console.log(erro);
            res.status(500).json(erro.sqlMessage);
        });
}

function listarBosses(req, res) {
    progressoModel.listarBosses(req.params.idUsuario)
        .then(function (resultado) {
            res.status(200).json(resultado);
        })
        .catch(function (erro) {
            console.log(erro);
            res.status(500).json(erro.sqlMessage);
        });
}

module.exports = {
    registrar,
    listarJogos,
    listarBosses
};
