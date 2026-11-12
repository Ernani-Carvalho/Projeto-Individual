var express = require("express");
var router = express.Router();

var jogoController = require("../controllers/jogoController");

router.get("/bosses/:idJogo", function (req, res) {
    jogoController.listarBosses(req, res);
});

module.exports = router;
