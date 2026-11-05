var express = require("express");
var router = express.Router();

var jogoController = require("../controllers/jogoController");

router.get("/medias/:idJogo", function (req, res) {
    jogoController.buscarMedias(req, res);
});

router.get("/bosses/:idJogo", function (req, res) {
    jogoController.listarBosses(req, res);
});

module.exports = router;
