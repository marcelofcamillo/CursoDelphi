unit cCadProduto;

interface

uses System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs, ZAbstractConnection,
     ZConnection, ZAbstractRODataset, ZAbstractDataset, ZDataset, System.SysUtils;

type
  TProduto = class
    private
    ConexaoDB: TZConnection;
    F_produtoId: Integer;
    F_nome: String;
    F_descricao: String;
    F_valor: Double;
    F_quantidade: Double;
    F_categoriaId: Integer;

    public
      constructor Create(aConexao: TZConnection);
      destructor Destroy; override;
      function Inserir: Boolean;
      function Atualizar: Boolean;
      function Apagar: Boolean;
      function Selecionar(id: Integer): Boolean;

    published
      property codigo      : Integer read F_produtoId   write F_produtoId;
      property nome        : String  read F_nome        write F_nome;
      property descricao   : String  read F_descricao   write F_descricao;
      property valor       : Double  read F_valor       write F_valor;
      property quantidade  : Double  read F_quantidade  write F_quantidade;
      property categoriaId : Integer read F_categoriaId write F_categoriaId;

  end;
implementation

{ TProduto }

{$region 'CONSTRUCTOR E DESTRUCTOR'}
constructor TProduto.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
end;

destructor TProduto.Destroy;
begin

  inherited;
end;
{$endRegion}

{$region 'CRUD'}
function TProduto.Apagar: Boolean;
var qry: TZQuery;
begin
  if MessageDlg('Apagar o Registro: '+#13+#13+
                'Código: ' + IntToStr(F_produtoId) +#13+
                'Descrição: ' + F_nome, mtConfirmation, [mbYes, mbNo], 0) = mrNo then begin
     Result := false;
     Abort;
  end;

  try
    Result := true;
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('DELETE FROM produtos WHERE produtoId = :produtoId');
    Qry.ParamByName('produtoId').AsInteger := F_produtoId;

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

function TProduto.Atualizar: Boolean;
var qry: TZQuery;
begin
  try
    Result := true;
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('UPDATE produtos SET nome = :nome, descricao = :descricao, valor = :valor, '+
                'quantidade = :quantidade, categoriaId = :categoriaId WHERE produtoId= :produtoId');
    qry.ParamByName('produtoId').AsInteger   := Self.F_produtoId;
    qry.ParamByName('nome').AsString         := Self.F_nome;
    qry.ParamByName('descricao').AsString    := Self.F_descricao;
    qry.ParamByName('valor').AsFloat         := Self.F_valor;
    qry.ParamByName('quantidade').AsFloat    := Self.F_quantidade;
    qry.ParamByName('categoriaId').AsInteger := Self.F_categoriaId;

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

function TProduto.Inserir: Boolean;
var qry: TZQuery;
begin
  try
    Result := true;
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('INSERT INTO produtos (nome, descricao, valor, quantidade, categoriaId) '+
                'VALUES (:nome, :descricao, :valor, :quantidade, :categoriaId)');

    qry.ParamByName('nome').AsString         :=Self.F_nome;
    qry.ParamByName('descricao').AsString    :=Self.F_descricao;
    qry.ParamByName('valor').AsFloat         :=Self.F_valor;
    qry.ParamByName('quantidade').AsFloat    :=Self.F_quantidade;
    qry.ParamByName('categoriaId').AsInteger :=Self.F_categoriaId;

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

function TProduto.Selecionar(id: Integer): Boolean;
var qry:TZQuery;
begin
  try
    Result:=true;
    qry:=TZQuery.Create(nil);
    qry.Connection:=ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT produtoId, nome, descricao, valor, quantidade, categoriaId '+
                'FROM produtos WHERE produtoId = :produtoId');
    qry.ParamByName('produtoId').AsInteger := id;

    try
      qry.Open;

      Self.F_produtoId   := Qry.FieldByName('produtoId').AsInteger;
      Self.F_nome        := Qry.FieldByName('nome').AsString;
      Self.F_descricao   := Qry.FieldByName('descricao').AsString;
      Self.F_valor       := Qry.FieldByName('valor').AsFloat;
      Self.F_quantidade  := Qry.FieldByName('quantidade').AsFloat;
      Self.F_categoriaId := Qry.FieldByName('categoriaId').AsInteger;
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

