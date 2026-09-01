package br.com.fiap.mercadoexpress.mvc.model;

import jakarta.persistence.Column;
import jakarta.persistence.Convert;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import jakarta.validation.constraints.DecimalMax;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import jakarta.validation.constraints.PositiveOrZero;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * Produto exposto na vitrine do Mercado Express.
 *
 * <p>Mapeada na tabela TDS_MVC_TB_MERCADO do mesmo banco Oracle usado na
 * Parte I. Alem das colunas herdadas da Parte I (nome, tipo, setor, tamanho
 * e preco), a Parte II acrescenta descricao, estoque, situacao e data de
 * cadastro, que sao os campos que a interface web precisa exibir.</p>
 *
 * <p>Esta mesma classe serve de objeto de formulario no Thymeleaf, por isso
 * carrega as anotacoes de Bean Validation.</p>
 */
@Entity
@Table(name = "TDS_MVC_TB_MERCADO")
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class Produto {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seqMercadoMvc")
    @SequenceGenerator(name = "seqMercadoMvc", sequenceName = "TDS_MVC_SQ_MERCADO", allocationSize = 1)
    @Column(name = "ID")
    @EqualsAndHashCode.Include
    private Long id;

    @NotBlank(message = "Informe o nome do produto")
    @Size(max = 100, message = "O nome pode ter no maximo 100 caracteres")
    @Column(name = "NOME", nullable = false, length = 100)
    private String nome;

    @NotBlank(message = "Informe o tipo do produto")
    @Size(max = 50, message = "O tipo pode ter no maximo 50 caracteres")
    @Column(name = "TIPO", nullable = false, length = 50)
    private String tipo;

    @NotBlank(message = "Escolha um setor")
    @Size(max = 50, message = "O setor pode ter no maximo 50 caracteres")
    @Column(name = "SETOR", nullable = false, length = 50)
    private String setor;

    @Size(max = 30, message = "O tamanho pode ter no maximo 30 caracteres")
    @Column(name = "TAMANHO", length = 30)
    private String tamanho;

    @NotNull(message = "Informe o preco")
    @Positive(message = "O preco precisa ser maior que zero")
    @DecimalMax(value = "99999999.99", message = "O preco maximo aceito e R$ 99.999.999,99")
    @Column(name = "PRECO", nullable = false, precision = 10, scale = 2)
    private BigDecimal preco;

    @Size(max = 500, message = "A descricao pode ter no maximo 500 caracteres")
    @Column(name = "DESCRICAO", length = 500)
    private String descricao;

    @NotNull(message = "Informe a quantidade em estoque")
    @PositiveOrZero(message = "O estoque nao pode ser negativo")
    @Column(name = "ESTOQUE")
    private Integer estoque;

    /** Produto inativo continua no banco, mas some da vitrine publica. */
    @Column(name = "ATIVO", length = 1)
    @Convert(converter = SimNaoConverter.class)
    private Boolean ativo;

    @Column(name = "DATA_CADASTRO")
    private LocalDate dataCadastro;

    /** Blinda o banco caso o formulario nao envie os campos de controle. */
    @PrePersist
    private void aoCadastrar() {
        if (dataCadastro == null) {
            dataCadastro = LocalDate.now();
        }
        if (ativo == null) {
            ativo = Boolean.TRUE;
        }
    }

    /** Usado pela vitrine para marcar o card de produto sem estoque. */
    public boolean isEsgotado() {
        return estoque == null || estoque <= 0;
    }
}
