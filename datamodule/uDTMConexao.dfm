object dtmPrincipal: TdtmPrincipal
  OldCreateOrder = False
  Height = 236
  Width = 423
  object ConexaoDB: TZConnection
    ControlsCodePage = cCP_UTF16
    AutoEncodeStrings = True
    Catalog = ''
    SQLHourGlass = True
    HostName = '.\SERVERCURSO'
    Port = 0
    Database = 'vendas'
    User = 'sa'
    Password = 'mudar@123'
    Protocol = 'mssql'
    LibraryLocation = 'C:\CursoDelphi\ntwdblib.dll'
    Left = 24
    Top = 16
  end
  object qryScriptCategorias: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      'IF OBJECT_ID ('#39'categorias'#39') IS NULL '
      'BEGIN'
      #9'CREATE TABLE categorias('
      #9#9'categoriaId int IDENTITY(1,1) NOT NULL,'
      #9#9'descricao  varchar(30) NULL,'
      #9#9'PRIMARY KEY (categoriaId)'
      #9')'
      'END')
    Params = <>
    Left = 112
    Top = 16
  end
  object qryScriptClientes: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      'IF OBJECT_ID ('#39'clientes'#39') IS NULL '
      'BEGIN'
      #9'CREATE TABLE clientes('
      #9#9'clienteId INT IDENTITY(1,1) NOT NULL,'
      #9#9'nome VARCHAR(60) NULL,'
      #9#9'endereco VARCHAR(60) NULL,'
      #9#9'cidade VARCHAR(50) NULL,'
      #9#9'bairro VARCHAR(40) NULL,'
      #9#9'estado VARCHAR(2) NULL,'
      #9#9'cep VARCHAR(10) NULL,'
      #9#9'telefone VARCHAR(14) NULL,'
      #9#9'email VARCHAR(100) NULL,'
      #9#9'dataNascimento DATETIME NULL,'
      #9#9'PRIMARY KEY (clienteId)'
      #9')'
      'END')
    Params = <>
    Left = 208
    Top = 16
  end
  object qryScriptProdutos: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      'IF OBJECT_ID ('#39'produtos'#39') IS NULL '
      'BEGIN'
      #9'CREATE TABLE produtos('
      #9#9'produtoId INT IDENTITY(1,1) NOT NULL,'
      #9#9'nome VARCHAR(60) NULL,'
      #9#9'descricao VARCHAR(255) NULL,'
      #9#9'valor DECIMAL(18,5) DEFAULT 0.00000 NULL,'
      #9#9'quantidade DECIMAL(18,5) DEFAULT 0.00000 NULL,'
      #9#9'categoriaId INT NULL,'
      #9#9'PRIMARY KEY (produtoId),'
      #9#9'CONSTRAINT FK_ProdutosCategorias'
      #9#9'FOREIGN KEY (categoriaId) REFERENCES categorias(categoriaId)'
      #9')'
      'END')
    Params = <>
    Left = 296
    Top = 16
  end
  object qryScriptVendas: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      'IF OBJECT_ID ('#39'vendas'#39') IS NULL '
      'BEGIN'
      #9'CREATE TABLE vendas ('
      #9#9'  vendaId INT IDENTITY(1,1) NOT NULL,'
      #9#9'  clienteId INT NOT NULL,'
      #9#9'  dataVenda DATETIME DEFAULT getdate(),'
      #9#9'  totalVenda DECIMAL(18,5) DEFAULT 0.00000,'
      #9#9'  PRIMARY KEY (vendaId),'
      #9#9'  CONSTRAINT FK_VendasClientes '
      #9#9'  FOREIGN KEY (clienteId) REFERENCES clientes(clienteId)'
      #9')'
      'END')
    Params = <>
    Left = 112
    Top = 72
  end
  object qryScriptItensVendas: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      'IF OBJECT_ID ('#39'vendasItens'#39') IS NULL '
      'BEGIN'
      #9'CREATE TABLE vendasItens ('
      #9#9'vendaId INT NOT NULL,'
      #9#9'produtoId INT NOT NULL,'
      #9#9'valorUnitario DECIMAL (18,5) DEFAULT 0.00000,'
      #9#9'quantidade DECIMAL (18,5) DEFAULT 0.00000,'
      #9#9'totalProduto DECIMAL (18,5) DEFAULT 0.00000,'
      #9#9'PRIMARY KEY (vendaId,produtoId),'
      #9#9'CONSTRAINT FK_VendasItensProdutos '
      #9#9'FOREIGN KEY (produtoId) REFERENCES produtos(produtoId)'
      #9')'
      'END')
    Params = <>
    Left = 208
    Top = 72
  end
  object qryScriptUsuarios: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      'IF OBJECT_ID ('#39'usuarios'#39') IS NULL'
      'BEGIN'
      #9'CREATE TABLE usuarios('
      #9#9'usuarioId INT IDENTITY(1,1) NOT NULL,'
      #9#9'nome VARCHAR(50) NOT NULL,'
      #9#9'senha VARCHAR(40) NOT NULL,'
      #9#9'PRIMARY KEY(usuarioId)'
      #9')'
      'END;')
    Params = <>
    Left = 307
    Top = 72
  end
end
