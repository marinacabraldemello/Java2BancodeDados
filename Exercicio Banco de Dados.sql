CREATE TABLE cliente (
id_cliente integer not null,
nome_cliente varchar2 (50) not null,
sexo varchar2 (1),
telefone varchar2 (12),
CONSTRAINT ID_CLIENTE_PK primary key (id_cliente)
);

CREATE SEQUENCE SEQUENCE_CLIENTE INCREMENT BY 1 START WITH 1;

CREATE OR REPLACE TRIGGER TRIGGER_CLIENTE
BEFORE INSERT ON CLIENTE
FOR EACH ROW
BEGIN 
SELECT SEQUENCE_CLIENTE.NEXTVAL INTO: NEW.ID_CLIENTE FROM DUAL;
END;

INSERT INTO cliente (nome_cliente, sexo, telefone)
VALUES ('Marina Ribeiro', 'F', '81996857788');

INSERT INTO cliente (nome_cliente, sexo, telefone)
VALUES ('Fábio Cabral', 'M', '81996857744');

INSERT INTO cliente (nome_cliente, sexo, telefone)
VALUES ('Jáder Mello', 'M', '81995874422');

INSERT INTO cliente (nome_cliente, sexo, telefone)
VALUES ('Auxiliadora Ribeiro', 'F', '81952364455');

INSERT INTO cliente (nome_cliente, sexo, telefone)
VALUES ('Thiago Filipe', 'M', '81995714488');

SELECT * FROM cliente;

CREATE TABLE produto (
id_produto INTEGER not null,
nome_produto VARCHAR2(50) not null,
peco_unit NUMBER (4,2),
custo_unit NUMBER (4,2),
CONSTRAINT ID_PRODUTO_PK primary key (id_produto)
);

CREATE SEQUENCE SEQUENCE_PRODUTO INCREMENT BY 1 START WITH 1;

CREATE OR REPLACE TRIGGER TRIGGER_PRODUTO
BEFORE INSERT ON PRODUTO
FOR EACH ROW
BEGIN
SELECT SEQUENCE_PRODUTO .NEXTVAL INTO : NEW.ID_PRODUTO FROM DUAL;
END;

INSERT INTO PRODUTO (nome_produto, peco_unit, custo_unit)
VALUES ('Carne acebolada', 19.0, 8.6);

ALTER TABLE produto
RENAME COLUMN peco_unit TO  preco_unit;

INSERT INTO produto (nome_produto, preco_unit, custo_unit)
VALUES ('Frango com Espinafre', 15, 5.89);

INSERT INTO produto (nome_produto, preco_unit, custo_unit)
VALUES ('Suíno com purê de lentilha', 16, 6.80);

INSERT INTO produto (nome_produto, preco_unit, custo_unit)
VALUES ('Escondidinho', 15, 5.1);

INSERT INTO produto (nome_produto, preco_unit, custo_unit)
VALUES ('Carne de panela com Grão de Bico', 19, 8.40);

CREATE TABLE vendas (
id_venda INTEGER not null,
data_venda date not null,
id_cliente INTEGER not null,
id_produto INTEGER not null,
quantidade INTEGER not null,
CONSTRAINT ID_VENDA_PK primary key (id_venda)
);

CREATE SEQUENCE SEQUENCE_VENDAS INCREMENT BY 1 START WITH 1;

CREATE OR REPLACE TRIGGER TRIGGER_VENDAS
BEFORE INSERT ON VENDAS
FOR EACH ROW
BEGIN
SELECT SEQUENCE_VENDAS.NEXTVAL INTO: NEW.ID_VENDA FROM DUAL;
END;

INSERT INTO vendas(data_venda, id_cliente, id_produto, quantidade)
VALUES (SYSDATE, 1, 3, 1);

select * from vendas;
INSERT INTO vendas (data_venda, id_cliente, id_produto, quantidade)
VALUES (SYSDATE, 2, 5, 3 );

INSERT INTO vendas (data_venda, id_cliente, id_produto, quantidade)
VALUES (SYSDATE, 2, 2, 1 );

INSERT INTO vendas (data_venda, id_cliente, id_produto, quantidade)
VALUES (SYSDATE, 3, 3, 5 );

INSERT INTO vendas (data_venda, id_cliente, id_produto, quantidade)
VALUES (SYSDATE, 4, 4, 1 );


ALTER TABLE vendas ADD CONSTRAINT
id_cliente_fk FOREIGN KEY 
(id_cliente) references cliente (id_cliente);

ALTER TABLE vendas ADD CONSTRAINT
id_produto_fk FOREIGN KEY
(id_produto) references produto (id_produto);


SELECT cliente.nome_cliente, vendas.data_venda , produto.nome_produto FROM VENDAS
INNER JOIN CLIENTE ON CLIENTE.ID_CLIENTE = VENDAS.ID_CLIENTE
INNER JOIN PRODUTO ON produto.id_produto = VENDAS.ID_PRODUTO;

SELECT cliente.nome_cliente, produto.nome_produto, vendas.quantidade FROM VENDAS
INNER JOIN cliente ON CLIENTE.ID_CLIENTE = VENDAS.ID_CLIENTE
INNER JOIN PRODUTO ON PRODUTO.ID_PRODUTO = VENDAS.ID_PRODUTO;

SELECT cliente.nome_cliente, produto.nome_produto, vendas.quantidade, produto.preco_unit FROM VENDAS
INNER JOIN cliente ON CLIENTE.ID_CLIENTE = VENDAS.ID_CLIENTE
INNER JOIN produto ON produto.id_produto = VENDAS.ID_VENDA;

SELECT cliente.nome_cliente, produto.nome_produto, vendas.quantidade FROM VENDAS
FULL OUTER  JOIN cliente ON CLIENTE.ID_CLIENTE = VENDAS.ID_CLIENTE
FULL OUTER JOIN PRODUTO ON PRODUTO.ID_PRODUTO = VENDAS.ID_PRODUTO;

SELECT cliente.nome_cliente, cliente.sexo, vendas.data_venda FROM VENDAS
INNER JOIN cliente ON CLIENTE.ID_CLIENTE = VENDAS.ID_CLIENTE
WHERE cliente.sexo = 'F';

SELECT cliente.nome_cliente, vendas.data_venda FROM VENDAS
INNER JOIN cliente ON CLIENTE.ID_CLIENTE = VENDAS.ID_CLIENTE
INNER JOIN produto ON PRODUTO.ID_PRODUTO = VENDAS.ID_PRODUTO
WHERE PRODUTO.NOME_PRODUTO = 'Escondidinho';

SELECT produto.nome_produto, vendas.data_venda, vendas.quantidade FROM VENDAS
INNER JOIN produto ON PRODUTO.ID_PRODUTO = VENDAS.ID_PRODUTO
INNER JOIN cliente ON CLIENTE.ID_CLIENTE = VENDAS.ID_CLIENTE
WHERE cliente.nome_cliente = 'Marina Ribeiro';

SELECT cliente.nome_cliente, vendas.data_venda FROM VENDAS
RIGHT JOIN cliente ON CLIENTE.ID_CLIENTE = VENDAS.ID_CLIENTE






