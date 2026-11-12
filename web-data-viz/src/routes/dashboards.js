var express = require("express");
var router = express.Router();

var dashboardController = require("../controllers/dashboardController");

// uma rota para cada parte da dashboard; o :idUsuario é o jogador logado

router.get("/totais/:idUsuario", function (req, res) {
    dashboardController.buscarTotais(req, res);
});

router.get("/horas/:idUsuario", function (req, res) {
    dashboardController.buscarHorasPorJogo(req, res);
});

router.get("/conclusao/:idUsuario", function (req, res) {
    dashboardController.buscarConclusao(req, res);
});

router.get("/dificuldades/:idUsuario", function (req, res) {
    dashboardController.buscarDificuldades(req, res);
});

router.get("/boss-mais-dificil/:idUsuario", function (req, res) {
    dashboardController.buscarBossMaisDificil(req, res);
});

module.exports = router;
