unit cCadCategoria;

interface

uses
  System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs, uDTMConexao, System.SysUtils,
  ZAbstractConnection, ZConnection, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TCategoria = class
    private
      ConexaoDB: TZConnection;
      F_categoriaId: Integer;
      F_descricao: String;

      function getCodigo: Integer;
      function getDescricao: String;
      procedure setCodigo(const Value: Integer);
      procedure setDescricao(const Value: String);

    public
      constructor Create(aConexao: TZConnection);
      destructor Destroy; override;
      function Inserir: Boolean;
      function Atualizar: Boolean;
      function Apagar: Boolean;
      function Selecionar(id: Integer): Boolean;

    published
      property codigo: Integer   read getCodigo    write setCodigo;
      property descricao: String read getDescricao write setDescricao;
  end;

implementation

{ TCategoria }

{$region 'CONSTRUCTOR E DESTRUCTOR'}
constructor TCategoria.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
  //ShowMessage('Objeto criado.');
end;

destructor TCategoria.Destroy;
begin
  //ShowMessage('Objeto destruído.');
  inherited;
end;
{$endregion}

{$region 'CRUD'}
function TCategoria.Apagar: Boolean;
var qry: TZQuery;
begin
  if MessageDlg('Apagar o registro: ' +#13+#13+ 'Código: ' + IntToStr(F_categoriaId) +#13+
          'Descrição: ' + F_descricao, mtConfirmation, [mbYes, mbNo], 0) = mrNo then begin
    Result := false;
    Abort;
  end;

  try
    Result:= true;
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('DELETE FROM categorias WHERE categoriaId = :categoriaId');
    qry.ParamByName('categoriaId').AsInteger := F_categoriaId;

    try
      qry.ExecSQL;
    except
      Result := false;
    end;

  finally
    if Assigned(qry) then
      FreeAndNil(qry);
  end;
end;

function TCategoria.Atualizar: Boolean;
var qry: TZQuery;
begin
  try
    Result := true;
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('UPDATE categorias SET descricao = :descricao WHERE categoriaId = :categoriaId');
    qry.ParamByName('descricao').AsString    := Self.F_descricao;
    qry.ParamByName('categoriaId').AsInteger := Self.F_categoriaId;

    try
      qry.ExecSQL;
    except
      Result := false;
    end;

  finally
    if Assigned(qry) then
      FreeAndNil(qry);
  end;
end;

function TCategoria.Inserir: Boolean;
var qry: TZQuery;
begin
  try
    Result := true;
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('INSERT INTO categorias (descricao) VALUES (:descricao)');
    qry.ParamByName('descricao').AsString := Self.F_descricao;

    try
      qry.ExecSQL;
    except
      Result := false;
    end;

  finally
    if Assigned(qry) then
      FreeAndNil(qry);
  end;
end;

function TCategoria.Selecionar(id: Integer): Boolean;
var qry: TZQuery;
begin
  try
    Result := true;
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT categoriaId, descricao FROM categorias WHERE categoriaId = :categoriaId');
    qry.ParamByName('categoriaId').AsInteger := id;

    try
      qry.Open;

      Self.F_categoriaId := qry.FieldByName('categoriaId').AsInteger;
      Self.F_descricao   := qry.FieldByName('descricao').AsString;
    except
      Result := false;
    end;

  finally
    if Assigned(qry) then
      FreeAndNil(qry);
  end;
end;
{$endregion}

{$region 'GETS'}
function TCategoria.getCodigo: Integer;
begin
  Result := Self.F_categoriaId;
end;

function TCategoria.getDescricao: String;
begin
  Result := Self.F_descricao;
end;
{$endregion}

{$region 'SETS'}
procedure TCategoria.setCodigo(const Value: Integer);
begin
  Self.F_categoriaId := value;
end;

procedure TCategoria.setDescricao(const Value: String);
begin
  Self.F_descricao := value;
end;
{$endregion}

end.
