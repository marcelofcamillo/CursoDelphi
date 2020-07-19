unit cControleEstoque;

interface

uses System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs, ZAbstractConnection, ZConnection,
     ZAbstractRODataset, ZAbstractDataset, ZDataset, System.SysUtils, Data.DB, Datasnap.DBClient;

type
  TControleEstoque = class
  private
    ConexaoDB: TZConnection;
    F_produtoId: Integer;
    F_quantidade: Double;

  public
    constructor Create(aConexao: TZConnection);
    destructor Destroy; override;
    function BaixarEstoque: Boolean;
    function RetornarEstoque: Boolean;

  published
    property produtoId  : Integer read F_ProdutoId  write F_ProdutoId;
    property quantidade : Double  read F_Quantidade write F_Quantidade;
  end;

implementation

{$region 'CONSTRUCTOR E DESTRUCTOR'}
constructor TControleEstoque.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
end;

destructor TControleEstoque.Destroy;
begin

  inherited;
end;
{$endRegion}

{$region 'FUNÇÕES DE CONTROLE DE ESTOQUE'}
function TControleEstoque.BaixarEstoque: Boolean;
var qry: TZQuery;
begin
  try
    Result := true;
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;
    qry.SQL.Clear;
    qry.SQL.Add('UPDATE produtos SET quantidade = quantidade - :qtdeBaixa WHERE produtoId = :produtoId');
    qry.ParamByName('produtoId').AsInteger := produtoId;
    qry.ParamByName('qtdeBaixa').AsFloat   := quantidade;

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

function TControleEstoque.RetornarEstoque: Boolean;
var qry: TZQuery;
begin
  try
    Result := true;
    qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;

    qry.SQL.Clear;
    qry.SQL.Add('UPDATE produtos SET quantidade = quantidade + :qtdeRetorno WHERE produtoId = :produtoId');
    qry.ParamByName('produtoId').AsInteger := produtoId;
    qry.ParamByName('qtdeRetorno').AsFloat := quantidade;

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
{$endRegion}

end.
