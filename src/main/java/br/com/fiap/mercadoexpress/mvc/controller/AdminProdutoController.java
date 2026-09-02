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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 * Area privada: o painel de produtos.
 *
 * <p>Todo o mapeamento nasce em /admin, que o
 * {@link br.com.fiap.mercadoexpress.mvc.config.SecurityConfig} reserva para
 * quem tem ROLE_ADMIN.</p>
 */
@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminProdutoController {

    private final ProdutoService service;

    /** Alimenta o <select> de setor em todos os formularios desta area. */
    @ModelAttribute("setoresDisponiveis")
    public List<String> setoresDisponiveis() {
        return ProdutoService.SETORES;
    }

    // ------------------------------------------------------------------
    // READ - painel
    // ------------------------------------------------------------------

    /** GET /admin - tabela densa com todos os produtos, paginada. */
    @GetMapping
    public String painel(@RequestParam(required = false) String busca,
                         @RequestParam(required = false) String setor,
                         @PageableDefault(size = 10, sort = "id", direction = Sort.Direction.DESC) Pageable paginacao,
                         Model model) {

        Page<Produto> pagina = service.listarPainel(busca, setor, paginacao);

        model.addAttribute("pagina", pagina);
        model.addAttribute("busca", busca);
        model.addAttribute("setorSelecionado", setor);
        model.addAttribute("totalAtivos", service.contarAtivos());
        model.addAttribute("totalInativos", service.contarInativos());

        return "admin/painel";
    }
}
