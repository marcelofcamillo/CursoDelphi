unit cAtualizacaoTabelaMSSQL;

interface

uses System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs, ZAbstractConnection,
     ZConnection, ZAbstractRODataset, ZAbstractDataset, ZDataset, System.SysUtils,
     cAtualizacaoBancoDeDados, cCadUsuario;

type
  TAtualizacaoTableMSSQL = class(TAtualizaBancoDados)

  private
    function  TabelaExiste(aNomeTabela: String): Boolean;

  protected

  public
    constructor Create(aConexao: TZConnection);
    destructor Destroy; override;

    procedure Categoria;
    procedure Cliente;
    procedure Produto;
    procedure Vendas;
    procedure VendasItens;
    procedure Usuario;
end;

implementation

{ TAtualizacaoTableMSSQL }

constructor TAtualizacaoTableMSSQL.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
  Categoria;
  Cliente;
  Produto;
  Vendas;
  VendasItens;
  Usuario;
end;

destructor TAtualizacaoTableMSSQL.Destroy;
begin
  inherited;
end;

function TAtualizacaoTableMSSQL.TabelaExiste(aNomeTabela: String): Boolean;
var qry: TZQuery;
begin
  try
    Result := false;
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT OBJECT_ID (:nomeTabela) As ID');
    qry.ParamByName('nomeTabela').AsString := aNomeTabela;
    qry.Open;

    if qry.FieldByName('ID').AsInteger > 0 then
       Result := true;

  finally
    qry.Close;

    if Assigned(qry) then
       FreeAndNil(qry);
  end;
end;

procedure TAtualizacaoTableMSSQL.Usuario;
var oUsuario: TUsuario;
begin
  if not TabelaExiste('usuarios') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE usuarios ( '+
      '	 usuarioId INT IDENTITY(1,1) NOT NULL, '+
      '	 nome VARCHAR(50) NOT NULL, '+
      '	 senha VARCHAR(40) NOT NULL, '+
      '	 PRIMARY KEY (usuarioId) '+
      '	) '
    );
  end;

  try
    oUsuario := TUsuario.Create(ConexaoDB);
    oUsuario.nome := 'ADMIN';
    oUsuario.senha := 'mudar@123';
    if not oUsuario.UsuarioExiste(oUsuario.nome) then
      oUsuario.Inserir;
  finally
    if Assigned(oUsuario) then
       FreeAndNil(oUsuario);
  end;
end;

procedure TAtualizacaoTableMSSQL.Categoria;
begin
  if not TabelaExiste('categorias') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE categorias( '+
      '	 categoriaId INT IDENTITY(1,1) NOT NULL, '+
      '	 descricao VARCHAR(30) NULL, '+
      '	 PRIMARY KEY (categoriaId) '+
      '	) '
    );
  end;
end;

procedure TAtualizacaoTableMSSQL.Cliente;
begin
  if not TabelaExiste('clientes') then
  begin
    ExecutaDiretoBancoDeDados(
      '	CREATE TABLE clientes (  '+
      '		clienteId INT IDENTITY(1,1) NOT NULL, '+
      '		nome VARCHAR(60) NULL, '+
      '		endereco VARCHAR(60) NULL, '+
      '		cidade VARCHAR(50) NULL, '+
      '		bairro VARCHAR(40) NULL, '+
      '		estado VARCHAR(2) NULL, '+
      '		cep VARCHAR(10) NULL, '+
      '		telefone VARCHAR(14) NULL, '+
      '		email VARCHAR(100) NULL,      '+
      '		dataNascimento DATETIME NULL, '+
      '		PRIMARY KEY (clienteId) '+
      '	) '
    );
  end;
end;

procedure TAtualizacaoTableMSSQL.Produto;
begin
  if not TabelaExiste('produtos') then
  begin
    ExecutaDiretoBancoDeDados(
      '	CREATE TABLE produtos(  '+
      '		produtoId INT IDENTITY(1,1) NOT NULL, '+
      '		nome VARCHAR(60) NULL, '+
      '		descricao VARCHAR(255) NULL, '+
      '		valor DECIMAL(18,5) DEFAULT 0.00000 NULL, '+
      '		quantidade DECIMAL(18,5) DEFAULT 0.00000 NULL, '+
      '		categoriaId INT NULL, '+
      '		PRIMARY KEY (produtoId), '+
      '		CONSTRAINT FK_ProdutosCategorias '+
      '		FOREIGN KEY (categoriaId) REFERENCES categorias(categoriaId) '+
      '	) '
    );
  end;
end;

procedure TAtualizacaoTableMSSQL.Vendas;
begin
  if not TabelaExiste('vendas') then
  begin
    ExecutaDiretoBancoDeDados(
      '	CREATE TABLE vendas (  '+
      '	  vendaId INT IDENTITY(1,1) NOT NULL, '+
      '	  clienteId INT NOT NULL, '+
      '	  dataVenda DATETIME DEFAULT getdate(), '+
      '	  totalVenda DECIMAL(18,5) DEFAULT 0.00000, '+

      '	  PRIMARY KEY (vendaId), '+
      '	  CONSTRAINT FK_VendasClientes FOREIGN KEY (clienteId) '+
      '		REFERENCES clientes(clienteId) '+
      '	) '
    );
  end;
end;

procedure TAtualizacaoTableMSSQL.VendasItens;
begin
  if not TabelaExiste('vendasItens') then
  begin
    ExecutaDiretoBancoDeDados(
      ' CREATE TABLE vendasItens (   '+
      ' 	vendaId INT NOT NULL,  '+
      '	  produtoId INT NOT NULL,  '+
      '	  valorUnitario DECIMAL (18,5) DEFAULT 0.00000,  '+
      '	  quantidade DECIMAL (18,5) DEFAULT 0.00000,  '+
      '	  totalProduto DECIMAL (18,5) DEFAULT 0.00000,  '+

      '	  PRIMARY KEY (vendaId,produtoId),  '+
      '	  CONSTRAINT FK_VendasItensProdutos FOREIGN KEY (produtoId)  '+
      '		REFERENCES produtos(produtoId)  '+
      '	)  '
    );
  end;
end;
end.
