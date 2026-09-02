package br.com.fiap.mercadoexpress.mvc.controller;

import br.com.fiap.mercadoexpress.mvc.model.Produto;
import br.com.fiap.mercadoexpress.mvc.service.ProdutoService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Area publica do Mercado Express: vitrine e detalhe do produto.
 *
 * <p>Nenhuma rota daqui exige autenticacao. Sao as duas telas que qualquer
 * visitante ve antes de pensar em fazer login.</p>
 */
@Controller
@RequiredArgsConstructor
public class CatalogoController {

    private final ProdutoService service;

    /**
     * GET / - vitrine em grade, com busca por nome e filtro por setor
     * chegando como parametros de consulta.
     */
    @GetMapping("/")
    public String vitrine(@RequestParam(required = false) String busca,
                          @RequestParam(required = false) String setor,
                          @PageableDefault(size = 12, sort = "nome", direction = Sort.Direction.ASC) Pageable paginacao,
                          Model model) {

        Page<Produto> pagina = service.listarVitrine(busca, setor, paginacao);

        model.addAttribute("pagina", pagina);
        model.addAttribute("setores", service.setoresCadastrados());
        model.addAttribute("busca", busca);
        model.addAttribute("setorSelecionado", setor);
        model.addAttribute("temFiltro", (busca != null && !busca.isBlank()) || (setor != null && !setor.isBlank()));

        return "catalogo/index";
    }

    /** GET /produtos/{id} - ficha completa do produto. */
    @GetMapping("/produtos/{id}")
    public String detalhe(@PathVariable Long id, Model model) {
        model.addAttribute("produto", service.buscarPorId(id));
        return "catalogo/detalhe";
    }
}
