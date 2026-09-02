package br.com.fiap.mercadoexpress.mvc.controller;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;

import org.springframework.security.core.Authentication;

/**
 * Rotas de entrada e saida da area privada.
 *
 * <p>O POST /login e o POST /logout nao aparecem aqui: quem os processa e o
 * proprio filtro do Spring Security, configurado em
 * {@link br.com.fiap.mercadoexpress.mvc.config.SecurityConfig}.</p>
 */
@Controller
public class AutenticacaoController {

    /**
     * Formulario de login (publico). Quem ja esta autenticado nao precisa dele:
     * o administrador segue para o painel e os demais perfis, para a vitrine.
     */
    @GetMapping("/login")
    public String login(Authentication autenticacao) {
        if (autenticacao == null || !autenticacao.isAuthenticated()) {
            return "auth/login";
        }
        boolean administrador = autenticacao.getAuthorities().stream()
                .anyMatch(permissao -> "ROLE_ADMIN".equals(permissao.getAuthority()));
        return administrador ? "redirect:/admin" : "redirect:/";
    }

    /**
     * Pagina 403: usuario autenticado tentando uma rota que nao e dele.
     *
     * <p>Aceita qualquer verbo de proposito. O Spring Security chega aqui por
     * <em>forward</em>, preservando o metodo original, entao um POST negado
     * precisa cair nesta mesma pagina em vez de virar um 405.</p>
     */
    @RequestMapping("/acesso-negado")
    @ResponseStatus(HttpStatus.FORBIDDEN)
    public String acessoNegado() {
        return "error/403";
    }
}
