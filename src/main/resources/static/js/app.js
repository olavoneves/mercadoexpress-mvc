/*
 * Unico script da aplicacao: pede confirmacao antes de enviar um formulario
 * marcado com data-confirmar. Fica fora do HTML para nao repetir codigo linha
 * a linha na tabela do painel.
 *
 * E melhoria progressiva: com o JavaScript desligado o botao continua
 * funcionando, so nao exibe o aviso.
 */
document.addEventListener('submit', function (evento) {
    var formulario = evento.target.closest('[data-confirmar]');
    if (formulario && !window.confirm(formulario.dataset.confirmar)) {
        evento.preventDefault();
    }
});
