

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
	PRIMARY KEY (clienteId),
)