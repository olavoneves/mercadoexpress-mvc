-- Massa de teste do perfil dev (H2 em memoria).
-- A tabela e a sequence sao criadas pelo Hibernate (ddl-auto=create-drop);
-- aqui entram so os INSERTs, consumindo a mesma sequence da entidade.

INSERT INTO TDS_MVC_TB_MERCADO (ID, NOME, TIPO, SETOR, TAMANHO, PRECO, DESCRICAO, ESTOQUE, ATIVO, DATA_CADASTRO) VALUES
 (NEXT VALUE FOR TDS_MVC_SQ_MERCADO, 'Banana prata', 'Fruta', 'Hortifruti', '1kg', 7.99, 'Banana prata madura, colhida no Vale do Ribeira e entregue na feira duas vezes por semana.', 120, 'S', DATE '2026-08-02');
INSERT INTO TDS_MVC_TB_MERCADO (ID, NOME, TIPO, SETOR, TAMANHO, PRECO, DESCRICAO, ESTOQUE, ATIVO, DATA_CADASTRO) VALUES
 (NEXT VALUE FOR TDS_MVC_SQ_MERCADO, 'Tomate italiano', 'Legume', 'Hortifruti', '1kg', 9.49, 'Tomate italiano firme, ideal para molho caseiro. Vendido a granel.', 64, 'S', DATE '2026-08-02');
INSERT INTO TDS_MVC_TB_MERCADO (ID, NOME, TIPO, SETOR, TAMANHO, PRECO, DESCRICAO, ESTOQUE, ATIVO, DATA_CADASTRO) VALUES
 (NEXT VALUE FOR TDS_MVC_SQ_MERCADO, 'Alface crespa', 'Verdura', 'Hortifruti', 'Unidade', 3.90, 'Alface crespa hidroponica, embalada no mesmo dia da colheita.', 0, 'S', DATE '2026-08-05');
INSERT INTO TDS_MVC_TB_MERCADO (ID, NOME, TIPO, SETOR, TAMANHO, PRECO, DESCRICAO, ESTOQUE, ATIVO, DATA_CADASTRO) VALUES
 (NEXT VALUE FOR TDS_MVC_SQ_MERCADO, 'Pao frances', 'Panificacao', 'Padaria', '1kg', 18.90, 'Assado de hora em hora, das 6h as 19h. Casca crocante e miolo leve.', 40, 'S', DATE '2026-08-06');
INSERT INTO TDS_MVC_TB_MERCADO (ID, NOME, TIPO, SETOR, TAMANHO, PRECO, DESCRICAO, ESTOQUE, ATIVO, DATA_CADASTRO) VALUES
 (NEXT VALUE FOR TDS_MVC_SQ_MERCADO, 'Bolo de fuba caseiro', 'Confeitaria', 'Padaria', '500g', 22.00, 'Bolo de fuba com erva-doce, receita da casa, feito todo dia de manha.', 12, 'S', DATE '2026-08-06');
INSERT INTO TDS_MVC_TB_MERCADO (ID, NOME, TIPO, SETOR, TAMANHO, PRECO, DESCRICAO, ESTOQUE, ATIVO, DATA_CADASTRO) VALUES
 (NEXT VALUE FOR TDS_MVC_SQ_MERCADO, 'Cafe torrado e moido', 'Mercearia seca', 'Mercearia', '500g', 21.90, 'Cafe 100% arabica, torra media, moagem para coador de pano.', 85, 'S', DATE '2026-08-08');
INSERT INTO TDS_MVC_TB_MERCADO (ID, NOME, TIPO, SETOR, TAMANHO, PRECO, DESCRICAO, ESTOQUE, ATIVO, DATA_CADASTRO) VALUES
 (NEXT VALUE FOR TDS_MVC_SQ_MERCADO, 'Suco de laranja integral', 'Bebida', 'Bebidas', '1L', 14.50, 'Suco integral sem acucar, prensado na hora e resfriado. Validade de tres dias.', 30, 'S', DATE '2026-08-10');
INSERT INTO TDS_MVC_TB_MERCADO (ID, NOME, TIPO, SETOR, TAMANHO, PRECO, DESCRICAO, ESTOQUE, ATIVO, DATA_CADASTRO) VALUES
 (NEXT VALUE FOR TDS_MVC_SQ_MERCADO, 'Agua mineral com gas', 'Bebida', 'Bebidas', '500ml', 3.25, 'Agua mineral naturalmente gaseificada, garrafa retornavel.', 200, 'S', DATE '2026-08-10');
INSERT INTO TDS_MVC_TB_MERCADO (ID, NOME, TIPO, SETOR, TAMANHO, PRECO, DESCRICAO, ESTOQUE, ATIVO, DATA_CADASTRO) VALUES
 (NEXT VALUE FOR TDS_MVC_SQ_MERCADO, 'Detergente neutro', 'Limpeza', 'Higiene e Limpeza', '500ml', 3.49, 'Detergente neutro biodegradavel, rende ate 40% mais que o comum.', 150, 'S', DATE '2026-08-12');
INSERT INTO TDS_MVC_TB_MERCADO (ID, NOME, TIPO, SETOR, TAMANHO, PRECO, DESCRICAO, ESTOQUE, ATIVO, DATA_CADASTRO) VALUES
 (NEXT VALUE FOR TDS_MVC_SQ_MERCADO, 'Sabao em po', 'Limpeza', 'Higiene e Limpeza', '1,6kg', 24.90, 'Sabao em po concentrado para maquina e lavagem a mao.', 48, 'S', DATE '2026-08-12');
INSERT INTO TDS_MVC_TB_MERCADO (ID, NOME, TIPO, SETOR, TAMANHO, PRECO, DESCRICAO, ESTOQUE, ATIVO, DATA_CADASTRO) VALUES
 (NEXT VALUE FOR TDS_MVC_SQ_MERCADO, 'Muzzarela fatiada', 'Frios', 'Frios e Laticinios', '200g', 16.80, 'Muzzarela fatiada na hora, no ponto certo para lanche e pizza.', 26, 'S', DATE '2026-08-14');
INSERT INTO TDS_MVC_TB_MERCADO (ID, NOME, TIPO, SETOR, TAMANHO, PRECO, DESCRICAO, ESTOQUE, ATIVO, DATA_CADASTRO) VALUES
 (NEXT VALUE FOR TDS_MVC_SQ_MERCADO, 'Meia esportiva algodao', 'Vestuario', 'Bazar', 'M', 19.90, 'Par de meias esportivas de algodao com punho reforcado.', 18, 'S', DATE '2026-08-15');
INSERT INTO TDS_MVC_TB_MERCADO (ID, NOME, TIPO, SETOR, TAMANHO, PRECO, DESCRICAO, ESTOQUE, ATIVO, DATA_CADASTRO) VALUES
 (NEXT VALUE FOR TDS_MVC_SQ_MERCADO, 'Panetone tradicional', 'Doce', 'Mercearia', '400g', 27.90, 'Item sazonal de fim de ano, mantido fora da vitrine no resto do ano.', 0, 'N', DATE '2026-08-16');
