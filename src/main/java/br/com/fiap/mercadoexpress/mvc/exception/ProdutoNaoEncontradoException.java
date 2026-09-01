package br.com.fiap.mercadoexpress.mvc.exception;

/**
 * Disparada quando um id inexistente chega pela URL. E traduzida em uma
 * pagina 404 com a identidade visual do projeto pelo
 * {@link br.com.fiap.mercadoexpress.mvc.controller.TratadorDeErros}.
 */
public class ProdutoNaoEncontradoException extends RuntimeException {

    public ProdutoNaoEncontradoException(Long id) {
        super("Nao existe produto com o id " + id + ".");
    }
}
