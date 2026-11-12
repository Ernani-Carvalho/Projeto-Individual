var progressoModel = require("../models/progressoModel");

// se o jogador já tem esse jogo, atualiza (UPDATE); se não tem, cria a linha (INSERT)
function salvarJogo(idUsuario, idJogo, horas, status) {
    return progressoModel.buscarProgresso(idUsuario, idJogo)
        .then(function (resultado) {
            if (resultado.length > 0) {
                return progressoModel.atualizarProgresso(idUsuario, idJogo, horas, status);
            }
            return progressoModel.inserirProgresso(idUsuario, idJogo, horas, status);
        });
}

// mesma ideia para o boss
function salvarBoss(idUsuario, idBoss, tentativas, dificuldade) {
    return progressoModel.buscarBossDerrotado(idUsuario, idBoss)
        .then(function (resultado) {
            if (resultado.length > 0) {
                return progressoModel.atualizarBossDerrotado(idUsuario, idBoss, tentativas, dificuldade);
            }
            return progressoModel.inserirBossDerrotado(idUsuario, idBoss, tentativas, dificuldade);
        });
}

// salva o jogo e, se idBoss for diferente de 0, salva o boss também
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

    // as mesmas regras do CHECK do banco, conferidas antes de chegar nele
    if (horas < 0) {
        res.status(400).send("As horas precisam ser 0 ou mais.");
        return;
    }
    if (status != "jogando" && status != "zerado" && status != "pausado") {
        res.status(400).send("O status precisa ser jogando, zerado ou pausado.");
        return;
    }
    if (idBoss != 0 && tentativas < 1) {
        res.status(400).send("As tentativas precisam ser 1 ou mais.");
        return;
    }
    if (idBoss != 0 && (dificuldade < 1 || dificuldade > 5)) {
        res.status(400).send("A dificuldade precisa ser de 1 a 5.");
        return;
    }

    // 1º salva o jogo; 2º salva o boss, só se algum foi escolhido
    salvarJogo(idUsuario, idJogo, horas, status)
        .then(function () {
            if (idBoss != 0) {
                return salvarBoss(idUsuario, idBoss, tentativas, dificuldade);
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
