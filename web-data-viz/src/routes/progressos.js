var express = require("express");
var router = express.Router();

var progressoController = require("../controllers/progressoController");

// salva as horas e o status do jogo e, se tiver boss escolhido, o boss também
router.post("/registrar", function (req, res) {
    progressoController.registrar(req, res);
});

router.get("/jogos/:idUsuario", function (req, res) {
    progressoController.listarJogos(req, res);
});

router.get("/bosses/:idUsuario", function (req, res) {
    progressoController.listarBosses(req, res);
});

module.exports = router;
