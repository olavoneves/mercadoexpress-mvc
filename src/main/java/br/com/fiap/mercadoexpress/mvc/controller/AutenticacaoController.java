package br.com.fiap.mercadoexpress.mvc.controller;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseStatus;

import java.security.Principal;

/**
 * Rotas de entrada e saida da area privada.
 *
 * <p>O POST /login e o POST /logout nao aparecem aqui: quem os processa e o
 * proprio filtro do Spring Security, configurado em
 * {@link br.com.fiap.mercadoexpress.mvc.config.SecurityConfig}.</p>
 */
@Controller
public class AutenticacaoController {

    /** Formulario de login (publico). Quem ja esta logado vai direto ao painel. */
    @GetMapping("/login")
    public String login(Principal autenticado) {
        return autenticado != null ? "redirect:/admin" : "auth/login";
    }

    /** Pagina 403: usuario autenticado tentando uma rota que nao e dele. */
    @GetMapping("/acesso-negado")
    @ResponseStatus(HttpStatus.FORBIDDEN)
    public String acessoNegado() {
        return "erro/403";
    }
}
