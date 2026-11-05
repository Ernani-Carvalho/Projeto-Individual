var express = require("express");
var router = express.Router();

var progressoController = require("../controllers/progressoController");

router.post("/jogo", function (req, res) {
    progressoController.registrarJogo(req, res);
});

router.post("/boss", function (req, res) {
    progressoController.registrarBoss(req, res);
});

router.get("/jogos/:idUsuario", function (req, res) {
    progressoController.listarJogos(req, res);
});

router.get("/bosses/:idUsuario", function (req, res) {
    progressoController.listarBosses(req, res);
});

module.exports = router;
