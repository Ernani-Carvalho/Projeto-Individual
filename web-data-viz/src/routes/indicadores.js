var express = require("express");
var router = express.Router();

var indicadorController = require("../controllers/indicadorController");

router.get("/gerais", function (req, res) {
    indicadorController.buscarGerais(req, res);
});

module.exports = router;
