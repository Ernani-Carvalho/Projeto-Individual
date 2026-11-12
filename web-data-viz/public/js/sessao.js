// páginas de quem está logado: coloca o nome no b_usuario ou volta para o login
function validarSessao() {
    var email = sessionStorage.EMAIL_USUARIO;
    var nome = sessionStorage.NOME_USUARIO;

    var b_usuario = document.getElementById("b_usuario");

    if (email != null && nome != null) {
        b_usuario.innerHTML = nome;
    } else {
        window.location = "../login.html";
    }
}

// botão "Sair": apaga os dados do jogador e volta para o login
function limparSessao() {
    sessionStorage.clear();
    window.location = "../login.html";
}

