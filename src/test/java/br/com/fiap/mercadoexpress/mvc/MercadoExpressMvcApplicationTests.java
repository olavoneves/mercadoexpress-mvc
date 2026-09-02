package br.com.fiap.mercadoexpress.mvc;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

/**
 * Sobe o contexto inteiro para garantir que controllers, service, repository e
 * a cadeia do Spring Security estao coerentes.
 *
 * <p>Roda no perfil dev (H2 em memoria) de proposito: assim o
 * {@code mvn clean package} passa em qualquer maquina, sem exigir as
 * credenciais do Oracle da FIAP.</p>
 */
@SpringBootTest
@ActiveProfiles("dev")
class MercadoExpressMvcApplicationTests {

	@Test
	void contextLoads() {
	}

}
