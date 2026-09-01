package br.com.fiap.mercadoexpress.mvc.model;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

/**
 * Traduz o {@code Boolean} da entidade para o CHAR(1) 'S'/'N' da coluna ATIVO.
 * E a convencao usada no banco Oracle da FIAP e mantem a tabela legivel para
 * quem consulta pelo SQL Developer.
 */
@Converter(autoApply = false)
public class SimNaoConverter implements AttributeConverter<Boolean, String> {

    private static final String SIM = "S";
    private static final String NAO = "N";

    @Override
    public String convertToDatabaseColumn(Boolean atributo) {
        return Boolean.TRUE.equals(atributo) ? SIM : NAO;
    }

    @Override
    public Boolean convertToEntityAttribute(String coluna) {
        return SIM.equalsIgnoreCase(coluna);
    }
}
