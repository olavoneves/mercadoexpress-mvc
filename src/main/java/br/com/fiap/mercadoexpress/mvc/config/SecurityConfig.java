package br.com.fiap.mercadoexpress.mvc.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

/**
 * Configuracao do Spring Security.
 *
 * <p>O eixo do projeto e a separacao entre o que qualquer visitante ve e o que
 * so o administrador acessa:</p>
 *
 * <table>
 *   <caption>Mapa de acesso</caption>
 *   <tr><th>Publico</th><td>GET /, GET /produtos/{id}, GET /login e os estaticos</td></tr>
 *   <tr><th>Privado</th><td>tudo sob /admin/** exige ROLE_ADMIN autenticado</td></tr>
 * </table>
 *
 * <p>Visitante anonimo que tenta uma rota privada e mandado para o formulario
 * de login; usuario ja autenticado sem ROLE_ADMIN recebe a pagina 403 propria
 * do projeto, em vez da tela padrao do container.</p>
 */
@Configuration
@EnableWebSecurity
public class SecurityConfig {

    /**
     * Cadeia principal. As regras sao lidas de cima para baixo: a primeira que
     * casar com a requisicao decide, por isso as rotas publicas vem antes do
     * bloqueio geral de /admin/**.
     */
    @Bean
    @Order(Ordered.LOWEST_PRECEDENCE)
    SecurityFilterChain filtroPrincipal(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(rotas -> rotas
                        // ---------- Estaticos ----------
                        .requestMatchers("/css/**", "/js/**", "/img/**", "/favicon.ico").permitAll()
                        // ---------- Rotas publicas ----------
                        .requestMatchers("/", "/produtos/**", "/login", "/acesso-negado").permitAll()
                        // O Spring Boot despacha os erros para /error, e esse despacho
                        // tambem passa por esta cadeia. Sem liberar a rota, qualquer
                        // falha numa pagina publica virava redirect para /login - e,
                        // em cliente sem cookie, um loop de redirecionamento.
                        .requestMatchers("/error").permitAll()
                        // ---------- Rotas privadas ----------
                        .requestMatchers("/admin/**").hasRole("ADMIN")
                        // ---------- Qualquer outra coisa ----------
                        .anyRequest().authenticated())

                // Formulario proprio em /login, com a identidade visual do projeto,
                // no lugar da pagina gerada pelo Spring Security.
                .formLogin(login -> login
                        .loginPage("/login")
                        .loginProcessingUrl("/login")
                        .usernameParameter("usuario")
                        .passwordParameter("senha")
                        .successHandler(destinoAposLogin())
                        .failureUrl("/login?erro")
                        .permitAll())

                // Logout so por POST (o header manda o token CSRF junto).
                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/?logout")
                        .invalidateHttpSession(true)
                        .deleteCookies("JSESSIONID")
                        .permitAll())

                // Autenticado sem permissao: pagina 403 propria.
                .exceptionHandling(erros -> erros.accessDeniedPage("/acesso-negado"));

        return http.build();
    }

    /**
     * Depois de autenticar, o administrador cai direto no painel e os demais
     * perfis voltam para a vitrine. Assim o ROLE_USER nao aterrissa em uma
     * pagina 403 logo apos digitar a senha correta.
     */
    private AuthenticationSuccessHandler destinoAposLogin() {
        return (requisicao, resposta, autenticacao) -> {
            boolean administrador = autenticacao.getAuthorities().stream()
                    .anyMatch(permissao -> "ROLE_ADMIN".equals(permissao.getAuthority()));
            resposta.sendRedirect(requisicao.getContextPath() + (administrador ? "/admin" : "/"));
        };
    }

    /**
     * Cadeia auxiliar do console do H2, que so existe no perfil dev.
     * Fica isolada em um securityMatcher proprio para nao afrouxar nada na
     * cadeia principal, que continua com CSRF e frames bloqueados.
     */
    @Bean
    @Order(1)
    @Profile("dev")
    SecurityFilterChain filtroConsoleH2(HttpSecurity http) throws Exception {
        http
                .securityMatcher("/h2-console/**")
                .authorizeHttpRequests(rotas -> rotas.anyRequest().permitAll())
                .csrf(csrf -> csrf.disable())
                .headers(headers -> headers.frameOptions(frame -> frame.sameOrigin()));
        return http.build();
    }

    /**
     * Usuarios de teste em memoria. E um projeto academico: as credenciais
     * estao documentadas no README de proposito.
     *
     * <ul>
     *   <li><strong>admin / admin123</strong> - ROLE_ADMIN, acessa o painel;</li>
     *   <li><strong>user / user123</strong> - ROLE_USER, so enxerga a vitrine.</li>
     * </ul>
     *
     * As senhas nunca ficam em texto puro nem em memoria: entram ja com hash
     * BCrypt.
     */
    @Bean
    InMemoryUserDetailsManager usuarios(PasswordEncoder encoder) {
        UserDetails admin = User.withUsername("admin")
                .password(encoder.encode("admin123"))
                .roles("ADMIN")
                .build();

        UserDetails cliente = User.withUsername("user")
                .password(encoder.encode("user123"))
                .roles("USER")
                .build();

        return new InMemoryUserDetailsManager(admin, cliente);
    }

    @Bean
    PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
