var progressoModel = require("../models/progressoModel");

// se o jogador já tem esse jogo, atualiza as horas e o status; se não tem, cria a linha
function registrarJogo(req, res) {
    var idUsuario = req.body.idUsuarioServer;
    var idJogo = req.body.idJogoServer;
    var horas = req.body.horasServer;
    var status = req.body.statusServer;

    if (idUsuario == undefined || idJogo == undefined || horas == undefined || status == undefined) {
        res.status(400).send("Algum dado está undefined!");
        return;
    }

    progressoModel.buscarProgresso(idUsuario, idJogo)
        .then(function (resultado) {
            if (resultado.length > 0) {
                return progressoModel.atualizarProgresso(idUsuario, idJogo, horas, status);
            } else {
                return progressoModel.inserirProgresso(idUsuario, idJogo, horas, status);
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

// mesma ideia para o boss: atualiza se já existe, cria se não existe
function registrarBoss(req, res) {
    var idUsuario = req.body.idUsuarioServer;
    var idBoss = req.body.idBossServer;
    var tentativas = req.body.tentativasServer;
    var dificuldade = req.body.dificuldadeServer;

    if (idUsuario == undefined || idBoss == undefined || tentativas == undefined || dificuldade == undefined) {
        res.status(400).send("Algum dado está undefined!");
        return;
    }

    progressoModel.buscarBossDerrotado(idUsuario, idBoss)
        .then(function (resultado) {
            if (resultado.length > 0) {
                return progressoModel.atualizarBossDerrotado(idUsuario, idBoss, tentativas, dificuldade);
            } else {
                return progressoModel.inserirBossDerrotado(idUsuario, idBoss, tentativas, dificuldade);
            }
        })
        .then(function () {
            res.status(200).send("Boss salvo!");
        })
        .catch(function (erro) {
            console.log(erro);
            console.log("Houve um erro ao salvar o boss: ", erro.sqlMessage);
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
    registrarJogo,
    registrarBoss,
    listarJogos,
    listarBosses
};
