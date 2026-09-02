-- =====================================================================
-- FIAP - TDS - Checkpoint 4 (Parte II - MVC e Deploy)
-- Projeto: Mercado Express MVC
-- Banco...: Oracle (oracle.fiap.com.br) - o MESMO usado na Parte I
--
-- Execute este script no SQL Developer conectado com o seu usuario RM.
-- A tabela da Parte I (TDS_TB_MERCADO) nao e tocada: a Parte II usa a sua
-- propria tabela, TDS_MVC_TB_MERCADO, como o professor pediu.
-- =====================================================================

-- ---------------------------------------------------------------------
-- 1) LIMPEZA
--    Na primeira execucao os erros ORA-00942 (tabela nao existe) e
--    ORA-02289 (sequence nao existe) sao esperados: ignore.
-- ---------------------------------------------------------------------
DROP TABLE TDS_MVC_TB_MERCADO CASCADE CONSTRAINTS;
DROP SEQUENCE TDS_MVC_SQ_MERCADO;

-- ---------------------------------------------------------------------
-- 2) TABELA
--    Alem das colunas herdadas da Parte I, a Parte II acrescenta
--    DESCRICAO, ESTOQUE, ATIVO e DATA_CADASTRO, que a interface web exibe.
-- ---------------------------------------------------------------------
CREATE TABLE TDS_MVC_TB_MERCADO (
    ID             NUMBER(10)     NOT NULL,
    NOME           VARCHAR2(100)  NOT NULL,
    TIPO           VARCHAR2(50)   NOT NULL,
    SETOR          VARCHAR2(50)   NOT NULL,
    TAMANHO        VARCHAR2(30),
    PRECO          NUMBER(10,2)   NOT NULL,
    DESCRICAO      VARCHAR2(500),
    ESTOQUE        NUMBER(6)      DEFAULT 0 NOT NULL,
    ATIVO          CHAR(1)        DEFAULT 'S' NOT NULL,
    DATA_CADASTRO  DATE           DEFAULT SYSDATE NOT NULL,
    CONSTRAINT PK_TDS_MVC_MERCADO      PRIMARY KEY (ID),
    CONSTRAINT CK_TDS_MVC_PRECO        CHECK (PRECO > 0),
    CONSTRAINT CK_TDS_MVC_ESTOQUE      CHECK (ESTOQUE >= 0),
    CONSTRAINT CK_TDS_MVC_ATIVO        CHECK (ATIVO IN ('S', 'N'))
);

COMMENT ON TABLE  TDS_MVC_TB_MERCADO               IS 'Produtos da vitrine do Mercado Express (Parte II - Spring MVC)';
COMMENT ON COLUMN TDS_MVC_TB_MERCADO.ID            IS 'Identificador unico, gerado por TDS_MVC_SQ_MERCADO';
COMMENT ON COLUMN TDS_MVC_TB_MERCADO.NOME          IS 'Nome comercial do produto';
COMMENT ON COLUMN TDS_MVC_TB_MERCADO.TIPO          IS 'Tipo do produto (Fruta, Limpeza, Bebida...)';
COMMENT ON COLUMN TDS_MVC_TB_MERCADO.SETOR         IS 'Setor do mercado (Hortifruti, Padaria, Bazar...)';
COMMENT ON COLUMN TDS_MVC_TB_MERCADO.TAMANHO       IS 'Tamanho ou volume da embalagem (1kg, 500ml, M...)';
COMMENT ON COLUMN TDS_MVC_TB_MERCADO.PRECO         IS 'Preco unitario em reais, sempre maior que zero';
COMMENT ON COLUMN TDS_MVC_TB_MERCADO.DESCRICAO     IS 'Texto exibido na pagina de detalhe do produto';
COMMENT ON COLUMN TDS_MVC_TB_MERCADO.ESTOQUE       IS 'Quantidade disponivel; zero marca o card como esgotado';
COMMENT ON COLUMN TDS_MVC_TB_MERCADO.ATIVO         IS 'S = aparece na vitrine publica, N = fora de linha';
COMMENT ON COLUMN TDS_MVC_TB_MERCADO.DATA_CADASTRO IS 'Data em que o produto entrou na vitrine';

-- Consultas mais comuns da aplicacao: filtro por setor e busca por nome
CREATE INDEX IX_TDS_MVC_SETOR ON TDS_MVC_TB_MERCADO (SETOR);
CREATE INDEX IX_TDS_MVC_NOME  ON TDS_MVC_TB_MERCADO (NOME);

-- ---------------------------------------------------------------------
-- 3) SEQUENCE (allocationSize = 1 no lado do JPA)
-- ---------------------------------------------------------------------
CREATE SEQUENCE TDS_MVC_SQ_MERCADO
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- ---------------------------------------------------------------------
-- 4) MASSA DE TESTE - variedade real de mercado de bairro
-- ---------------------------------------------------------------------
INSERT INTO TDS_MVC_TB_MERCADO (ID, NOME, TIPO, SETOR, TAMANHO, PRECO, DESCRICAO, ESTOQUE, ATIVO, DATA_CADASTRO)
VALUES (TDS_MVC_SQ_MERCADO.NEXTVAL, 'Banana prata', 'Fruta', 'Hortifruti', '1kg', 7.99,
        'Banana prata madura, colhida no Vale do Ribeira e entregue na feira duas vezes por semana.',
        120, 'S', TO_DATE('02/08/2026', 'DD/MM/YYYY'));

INSERT INTO TDS_MVC_TB_MERCADO (ID, NOME, TIPO, SETOR, TAMANHO, PRECO, DESCRICAO, ESTOQUE, ATIVO, DATA_CADASTRO)
VALUES (TDS_MVC_SQ_MERCADO.NEXTVAL, 'Tomate italiano', 'Legume', 'Hortifruti', '1kg', 9.49,
        'Tomate italiano firme, ideal para molho caseiro. Vendido a granel.',
        64, 'S', TO_DATE('02/08/2026', 'DD/MM/YYYY'));

INSERT INTO TDS_MVC_TB_MERCADO (ID, NOME, TIPO, SETOR, TAMANHO, PRECO, DESCRICAO, ESTOQUE, ATIVO, DATA_CADASTRO)
VALUES (TDS_MVC_SQ_MERCADO.NEXTVAL, 'Alface crespa', 'Verdura', 'Hortifruti', 'Unidade', 3.90,
        'Alface crespa hidroponica, embalada no mesmo dia da colheita.',
        0, 'S', TO_DATE('05/08/2026', 'DD/MM/YYYY'));

INSERT INTO TDS_MVC_TB_MERCADO (ID, NOME, TIPO, SETOR, TAMANHO, PRECO, DESCRICAO, ESTOQUE, ATIVO, DATA_CADASTRO)
VALUES (TDS_MVC_SQ_MERCADO.NEXTVAL, 'Pao frances', 'Panificacao', 'Padaria', '1kg', 18.90,
        'Assado de hora em hora, das 6h as 19h. Casca crocante e miolo leve.',
        40, 'S', TO_DATE('06/08/2026', 'DD/MM/YYYY'));

INSERT INTO TDS_MVC_TB_MERCADO (ID, NOME, TIPO, SETOR, TAMANHO, PRECO, DESCRICAO, ESTOQUE, ATIVO, DATA_CADASTRO)
VALUES (TDS_MVC_SQ_MERCADO.NEXTVAL, 'Bolo de fuba caseiro', 'Confeitaria', 'Padaria', '500g', 22.00,
        'Bolo de fuba com erva-doce, receita da casa, feito todo dia de manha.',
        12, 'S', TO_DATE('06/08/2026', 'DD/MM/YYYY'));

INSERT INTO TDS_MVC_TB_MERCADO (ID, NOME, TIPO, SETOR, TAMANHO, PRECO, DESCRICAO, ESTOQUE, ATIVO, DATA_CADASTRO)
VALUES (TDS_MVC_SQ_MERCADO.NEXTVAL, 'Cafe torrado e moido', 'Mercearia seca', 'Mercearia', '500g', 21.90,
        'Cafe 100% arabica, torra media, moagem para coador de pano.',
        85, 'S', TO_DATE('08/08/2026', 'DD/MM/YYYY'));

INSERT INTO TDS_MVC_TB_MERCADO (ID, NOME, TIPO, SETOR, TAMANHO, PRECO, DESCRICAO, ESTOQUE, ATIVO, DATA_CADASTRO)
VALUES (TDS_MVC_SQ_MERCADO.NEXTVAL, 'Suco de laranja integral', 'Bebida', 'Bebidas', '1L', 14.50,
        'Suco integral sem acucar, prensado na hora e resfriado. Validade de tres dias.',
        30, 'S', TO_DATE('10/08/2026', 'DD/MM/YYYY'));

INSERT INTO TDS_MVC_TB_MERCADO (ID, NOME, TIPO, SETOR, TAMANHO, PRECO, DESCRICAO, ESTOQUE, ATIVO, DATA_CADASTRO)
VALUES (TDS_MVC_SQ_MERCADO.NEXTVAL, 'Agua mineral com gas', 'Bebida', 'Bebidas', '500ml', 3.25,
        'Agua mineral naturalmente gaseificada, garrafa retornavel.',
        200, 'S', TO_DATE('10/08/2026', 'DD/MM/YYYY'));

INSERT INTO TDS_MVC_TB_MERCADO (ID, NOME, TIPO, SETOR, TAMANHO, PRECO, DESCRICAO, ESTOQUE, ATIVO, DATA_CADASTRO)
VALUES (TDS_MVC_SQ_MERCADO.NEXTVAL, 'Detergente neutro', 'Limpeza', 'Higiene e Limpeza', '500ml', 3.49,
        'Detergente neutro biodegradavel, rende ate 40% mais que o comum.',
        150, 'S', TO_DATE('12/08/2026', 'DD/MM/YYYY'));

INSERT INTO TDS_MVC_TB_MERCADO (ID, NOME, TIPO, SETOR, TAMANHO, PRECO, DESCRICAO, ESTOQUE, ATIVO, DATA_CADASTRO)
VALUES (TDS_MVC_SQ_MERCADO.NEXTVAL, 'Sabao em po', 'Limpeza', 'Higiene e Limpeza', '1,6kg', 24.90,
        'Sabao em po concentrado para maquina e lavagem a mao.',
        48, 'S', TO_DATE('12/08/2026', 'DD/MM/YYYY'));

INSERT INTO TDS_MVC_TB_MERCADO (ID, NOME, TIPO, SETOR, TAMANHO, PRECO, DESCRICAO, ESTOQUE, ATIVO, DATA_CADASTRO)
VALUES (TDS_MVC_SQ_MERCADO.NEXTVAL, 'Muzzarela fatiada', 'Frios', 'Frios e Laticinios', '200g', 16.80,
        'Muzzarela fatiada na hora, no ponto certo para lanche e pizza.',
        26, 'S', TO_DATE('14/08/2026', 'DD/MM/YYYY'));

INSERT INTO TDS_MVC_TB_MERCADO (ID, NOME, TIPO, SETOR, TAMANHO, PRECO, DESCRICAO, ESTOQUE, ATIVO, DATA_CADASTRO)
VALUES (TDS_MVC_SQ_MERCADO.NEXTVAL, 'Meia esportiva algodao', 'Vestuario', 'Bazar', 'M', 19.90,
        'Par de meias esportivas de algodao com punho reforcado.',
        18, 'S', TO_DATE('15/08/2026', 'DD/MM/YYYY'));

-- Produto inativo de proposito: mostra a diferenca entre o painel (ve tudo)
-- e a vitrine publica (so ve o que esta ativo).
INSERT INTO TDS_MVC_TB_MERCADO (ID, NOME, TIPO, SETOR, TAMANHO, PRECO, DESCRICAO, ESTOQUE, ATIVO, DATA_CADASTRO)
VALUES (TDS_MVC_SQ_MERCADO.NEXTVAL, 'Panetone tradicional', 'Doce', 'Mercearia', '400g', 27.90,
        'Item sazonal de fim de ano, mantido fora da vitrine no resto do ano.',
        0, 'N', TO_DATE('16/08/2026', 'DD/MM/YYYY'));

COMMIT;

-- ---------------------------------------------------------------------
-- 5) CONFERENCIA
-- ---------------------------------------------------------------------
SELECT ID, NOME, SETOR, PRECO, ESTOQUE, ATIVO, DATA_CADASTRO
  FROM TDS_MVC_TB_MERCADO
 ORDER BY ID;

SELECT SETOR, COUNT(*) AS QTD_PRODUTOS
  FROM TDS_MVC_TB_MERCADO
 GROUP BY SETOR
 ORDER BY SETOR;
