CREATE DATABASE vendas

USE vendas

CREATE TABLE categorias(
	categoriaId int IDENTITY(1,1) NOT NULL,
	descricao  varchar(30) NULL,
	PRIMARY KEY (categoriaId)
)

SELECT categoriaId, descricao FROM categorias

/**********************************************/

CREATE TABLE clientes(
	clienteId INT IDENTITY(1,1) NOT NULL,
	nome VARCHAR(60) NULL,
	endereco VARCHAR(60) NULL,
	cidade VARCHAR(50) NULL,
	bairro VARCHAR(40) NULL,
	estado VARCHAR(2) NULL,
	cep VARCHAR(10) NULL,
	telefone VARCHAR(14) NULL,
	email VARCHAR(100) NULL,
	dataNascimento DATETIME NULL,
	PRIMARY KEY (clienteId)
)

SELECT clienteId, nome, endereco, cidade, bairro, estado, cep, telefone, email, dataNascimento FROM clientes

/**********************************************/

CREATE TABLE produtos(
	produtoId INT IDENTITY(1,1) NOT NULL,
	nome VARCHAR(60) NULL,
	descricao VARCHAR(255) NULL,
	valor DECIMAL(18,5) DEFAULT 0.00000 NULL,
	quantidade DECIMAL(18,5) DEFAULT 0.00000 NULL,
	categoriaId INT NULL,
	PRIMARY KEY (produtoId),
	CONSTRAINT FK_ProdutosCategorias
	FOREIGN KEY (categoriaId) REFERENCES categorias(categoriaId)
)

SELECT produtoId, nome, descricao, valor, quantidade, categoriaId FROM produtos

/**********************************************/