unit cCadCliente;

interface

uses
  System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs, uDTMConexao, System.SysUtils,
  ZAbstractConnection, ZConnection, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TCliente = class
    private
      ConexaoDB: TZConnection;

      // propriedades do banco de dados
      F_clienteId: Integer;
      F_nome: String;
      F_endereco: String;
      F_cidade: String;
      F_bairro: String;
      F_estado: String;
      F_cep: String;
      F_telefone: String;
      F_email: String;
      F_dataNascimento: TDateTime;

    public
      constructor Create(aConexao: TZConnection);
      destructor Destroy; override;
      function Inserir: Boolean;
      function Atualizar: Boolean;
      function Apagar: Boolean;
      function Selecionar(id: Integer): Boolean;

    published
    // propriedades do form
      property codigo        : Integer   read F_clienteId      write F_clienteId;
      property nome          : String    read F_nome           write F_nome;
      property endereco      : String    read F_endereco       write F_endereco;
      property cidade        : String    read F_cidade         write F_cidade;
      property bairro        : String    read F_bairro         write F_bairro;
      property estado        : String    read F_estado         write F_estado;
      property cep           : String    read F_cep            write F_cep;
      property telefone      : String    read F_telefone       write F_telefone;
      property email         : String    read F_email          write F_email;
      property dataNascimento: TDateTime read F_dataNascimento write F_dataNascimento;
  end;

implementation

{ TCliente }

{$region 'CONSTRUCTOR E DESTRUCTOR'}
constructor TCliente.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
end;

destructor TCliente.Destroy;
begin

  inherited;
end;
{$endregion}

{$region 'CRUD'}
function TCliente.Apagar: Boolean;
var qry: TZQuery;
begin
  if MessageDlg('Apagar o registro: ' +#13+#13+
                'Código: ' + IntToStr(F_clienteId) +#13+
                'Nome: ' + F_nome, mtConfirmation, [mbYes, mbNo], 0) = mrNo then begin
    Result := false;
    Abort;
  end;

  try
    Result := true;
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('DELETE FROM clientes WHERE clienteId = :clienteId');
    qry.ParamByName('clienteId').AsInteger := F_clienteId;

    try
      ConexaoDB.StartTransaction;
      qry.ExecSQL;
      ConexaoDB.Commit;
    except
      ConexaoDB.Rollback;
      Result := false;
    end;

  finally
    if Assigned(qry) then
      FreeAndNil(qry);
  end;
end;

function TCliente.Atualizar: Boolean;
var qry: TZQuery;
begin
  try
    Result := true;
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('UPDATE clientes SET nome = :nome, endereco = :endereco, cidade = :cidade, '+
                'bairro = :bairro, estado = :estado, cep = :cep, telefone = :telefone, '+
                'email = :email, dataNascimento = :dataNascimento WHERE clienteId = :clienteId');
    qry.ParamByName('clienteId').AsInteger       := Self.F_clienteId;
    qry.ParamByName('nome').AsString             := Self.F_nome;
    qry.ParamByName('endereco').AsString         := Self.F_endereco;
    qry.ParamByName('cidade').AsString           := Self.F_cidade;
    qry.ParamByName('bairro').AsString           := Self.F_bairro;
    qry.ParamByName('estado').AsString           := Self.F_estado;
    qry.ParamByName('cep').AsString              := Self.F_cep;
    qry.ParamByName('telefone').AsString         := Self.F_telefone;
    qry.ParamByName('email').AsString            := Self.F_email;
    qry.ParamByName('dataNascimento').AsDateTime := Self.F_dataNascimento;

    try
      ConexaoDB.StartTransaction;
      qry.ExecSQL;
      ConexaoDB.Commit;
    except
      ConexaoDB.Rollback;
      Result := false;
    end;

  finally
    if Assigned(qry) then
      FreeAndNil(qry);
  end;
end;

function TCliente.Inserir: Boolean;
var qry: TZQuery;
begin
  try
    Result := true;
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('INSERT INTO clientes (nome, endereco, cidade, bairro, estado, cep, telefone, ' +
                'email, dataNascimento) VALUES (:nome, :endereco, :cidade, :bairro, :estado, ' +
                ':cep, :telefone, :email, :dataNascimento)');
    qry.ParamByName('nome').AsString             := Self.F_nome;
    qry.ParamByName('endereco').AsString         := Self.F_endereco;
    qry.ParamByName('cidade').AsString           := Self.F_cidade;
    qry.ParamByName('bairro').AsString           := Self.F_bairro;
    qry.ParamByName('estado').AsString           := Self.F_estado;
    qry.ParamByName('cep').AsString              := Self.F_cep;
    qry.ParamByName('telefone').AsString         := Self.F_telefone;
    qry.ParamByName('email').AsString            := Self.F_email;
    qry.ParamByName('dataNascimento').AsDateTime := Self.F_dataNascimento;

    try
      ConexaoDB.StartTransaction;
      qry.ExecSQL;
      ConexaoDB.Commit;
    except
      ConexaoDB.Rollback;
      Result := false;
    end;

  finally
    if Assigned(qry) then
      FreeAndNil(qry);
  end;
end;

function TCliente.Selecionar(id: Integer): Boolean;
var qry: TZQuery;
begin
  try
    Result := true;
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT clienteId, nome, endereco, cidade, bairro, estado, cep, '+
                'telefone, email, dataNascimento FROM clientes WHERE clienteId = :clienteId');
    qry.ParamByName('clienteId').AsInteger := id;

    try
      qry.Open;

      Self.F_clienteId      := qry.FieldByName('clienteId').AsInteger;
      Self.F_nome           := qry.FieldByName('nome').AsString;
      Self.F_endereco       := qry.FieldByName('endereco').AsString;
      Self.F_cidade         := qry.FieldByName('cidade').AsString;
      Self.F_bairro         := qry.FieldByName('bairro').AsString;
      Self.F_estado         := qry.FieldByName('estado').AsString;
      Self.F_cep            := qry.FieldByName('cep').AsString;
      Self.F_telefone       := qry.FieldByName('telefone').AsString;
      Self.F_email          := qry.FieldByName('email').AsString;
      Self.F_dataNascimento := qry.FieldByName('dataNascimento').AsDateTime;

    except
      Result := false;
    end;

  finally
    if Assigned(qry) then
       FreeAndNil(qry);
  end;
end;
{$endregion}
end.
